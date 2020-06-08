//
//  CYTExtendViewModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTRequestResponseModel.h"
#import "CYTLoginParmeters.h"
#import "CYTUserKeyInfoModel.h"
#import "CYTLoginViewController.h"

@implementation CYTExtendViewModel

- (FFBasicNetworkRequestModel *)requestModelHandleWithModel:(FFBasicNetworkRequestModel *)model {
    if (model) {
        model.httpHeadFiledDictionary = [CYTTools headFiledDictionary];
    }
    return model;
}

///返回数据结构正确，httpcode<400
- (void)responseModelHandleWithModel_success:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    CYTRequestResponseModel *cytResponse = [CYTRequestResponseModel mj_objectWithKeyValues:inputModel.responseObject];
    BOOL effective = cytResponse.result;
    NSString *message = cytResponse.message;
    NSDictionary *data;
    
    //判断data是不是数组，如果是手动封装成字典结构
    if (inputModel.responseObject[@"data"] && [inputModel.responseObject[@"data"] isKindOfClass:[NSArray class]]) {
        //data是数组
        data = @{@"data":inputModel.responseObject[@"data"]};
    }else if (inputModel.responseObject[@"data"] && [inputModel.responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
        data = cytResponse.data;
    }else {
        data = nil;
    }
    
    @weakify(self);
    [self genModel:inputModel effective:effective message:message data:data httpCode:cytResponse.errorCode handleBlock:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.hudSubject sendNext:@"1"];
        handle(responseModel);
    }];
}

///返回数据结构错误
- (void)responseModelHandleWithModel_structError:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    @weakify(self);
    [self genModel:inputModel effective:NO message:CYTNetworkError data:nil httpCode:-1 handleBlock:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.hudSubject sendNext:@"1"];
        handle(responseModel);
    }];
}

#pragma mark- 网络请求错误码处理
- (void)handleErrorCodeWithResponseModel:(FFBasicNetworkResponseModel *)responseModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    CYTRequestResponseModel *cytResponse = [CYTRequestResponseModel mj_objectWithKeyValues:responseModel.responseObject];
    if (cytResponse.errorCode == 401) {
        [self handleErrorCodeWithResponseModel_401:responseModel andHandle:handle];
    }else {
        //其他错误
        [self handleErrorCodeWithResponseModel_otherError:responseModel andHandle:handle];
    }
}

- (void)handleErrorCodeWithResponseModel_401:(FFBasicNetworkResponseModel *)responseModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    //token过期,重新请求token，如果成功则，再次请求接口
    //如果失败则重新登录，登录后进入首页！！
    @weakify(self);
    [self refreshTokenWithResponseBlock:^(FFBasicNetworkResponseModel *response) {
        @strongify(self);
        if (response.httpCode<400) {
            //处理新的token数据,
            CYTUserKeyInfoModel *keyInfo = [CYTUserKeyInfoModel mj_objectWithKeyValues:response.dataDictionary];
            if (!keyInfo) {
                return ;
            }
            CYTAccountManager *account = [CYTAccountManager sharedAccountManager];
            account.accessToken = keyInfo.accessToken;
            account.refreshToken = keyInfo.refreshToken;
            [[NSNotificationCenter defaultCenter] postNotificationName:kTokenRefreshedKey object:nil];
            
            //重新请求上次失败的接口
            [self requestAgainWithResponseModel:responseModel andHandle:handle];
        }else if(response.httpCode == 401){
            //弹出登录页面,不返回数据
            [self presentLoginWithResponseModel:response];
        }else {
            [self genModel:response effective:NO message:response.resultMessage data:nil httpCode:response.httpCode handleBlock:^(FFBasicNetworkResponseModel *responseModel) {
                [self.hudSubject sendNext:@"1"];
                handle(responseModel);
            }];
        }
    }];
}

- (void)handleErrorCodeWithResponseModel_otherError:(FFBasicNetworkResponseModel *)responseModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    CYTRequestResponseModel *cytResponse = [CYTRequestResponseModel mj_objectWithKeyValues:responseModel.responseObject];
    @weakify(self);
    [self genModel:responseModel effective:NO message:cytResponse.message data:nil httpCode:cytResponse.errorCode handleBlock:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.hudSubject sendNext:@"1"];
        handle(responseModel);
    }];
}

#pragma mark- 重新请求上次失败的网络请求
- (void)requestAgainWithResponseModel:(FFBasicNetworkResponseModel *)responseModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle{
    //如果上次网络请求不是刷新token接口,再次请求原始接口
    FFBasicNetworkRequestModel *requestModel = responseModel.requestParameters;
    if ([requestModel.requestURL isEqualToString:kURL.user_identity_auth]) {
        //弹出登录页面,不返回数据
        [self presentLoginWithResponseModel:responseModel];
    }else {
        //重新请求上一次网络请求
        requestModel.httpHeadFiledDictionary = [CYTTools headFiledDictionary];
        [self requestWithModel:requestModel andBlock:^(FFBasicNetworkResponseModel *responseModel) {
            handle(responseModel);
        }];
    }
}

#pragma mark- method
- (void)presentLoginWithResponseModel:(FFBasicNetworkResponseModel *)responseModel {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hudSubject sendNext:@"1"];
        //重新登录逻辑
        [CYTTools existLoginStateWithMessage:responseModel.resultMessage];
    });
}

- (void)refreshTokenWithResponseBlock:(void (^)(FFBasicNetworkResponseModel *responseModel))responseBlock {
    FFBasicNetworkRequestModel *reqMod = [FFBasicNetworkRequestModel new];
    reqMod.needHud = NO;
    reqMod.requestURL = kURL.user_identity_auth;
    reqMod.requestParameters = [CYTTools loginParameters].mj_keyValues;
    reqMod.httpHeadFiledDictionary = [CYTTools headFiledDictionary];
    
    [self.request postWithModel:reqMod result:^(FFBasicNetworkResponseModel *responseObj) {
        CYTRequestResponseModel *cytResponse = [CYTRequestResponseModel mj_objectWithKeyValues:responseObj.responseObject];
        FFBasicNetworkResponseModel * responseObject = responseObj;
        responseObject.resultEffective = cytResponse.result;
        responseObject.resultMessage = cytResponse.message;
        responseObject.dataDictionary = cytResponse.data;
        responseObject.httpCode = cytResponse.errorCode;;
        
        !responseBlock?:responseBlock(responseObject);
    }];
}

@end
