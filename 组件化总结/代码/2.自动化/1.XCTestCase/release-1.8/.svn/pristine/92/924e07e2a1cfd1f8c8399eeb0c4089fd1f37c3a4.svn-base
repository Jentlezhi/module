//
//  FFBasicNetworkViewModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicNetworkViewModel.h"

@implementation FFBasicNetworkViewModel

- (void)ff_initWithModel:(FFExtendModel *)model {
    self.hudSubject = [RACSubject new];
}

- (FFBasicNetworkManager *)requestWithModel:(FFBasicNetworkRequestModel *)model andBlock:(void (^)(FFBasicNetworkResponseModel *responseModel))block {
    //对输入参数操作
    model = [self requestModelHandleWithModel:model];
    if (model.needHud) {[self.hudSubject sendNext:@"0"];}
    FFBasicNetworkManager *requestManager;
    
    if (model.methodType == NetRequestMethodTypePost) {
        requestManager = [self.request postWithModel:model result:^(FFBasicNetworkResponseModel *responseObject) {
            //对返回结果进行处理
            [self responseModelHandleWithModel:responseObject andHandle:^(FFBasicNetworkResponseModel *responseModel) {
                block(responseModel);
            }];
        }];
    }else {
        requestManager = [self.request getWithModel:model result:^(FFBasicNetworkResponseModel *responseObject) {
            //对返回结果进行处理
            [self responseModelHandleWithModel:responseObject andHandle:^(FFBasicNetworkResponseModel *responseModel) {
                block(responseModel);
            }];
        }];
    }
    
    return requestManager;
}

- (void)genModel:(FFBasicNetworkResponseModel *)model effective:(BOOL)effective message:(NSString *)message data:(NSDictionary *)data httpCode:(NSInteger)httpCode handleBlock:(void (^)(FFBasicNetworkResponseModel *responseModel))handleBlock {
    if (!model) {
        model = [FFBasicNetworkResponseModel new];
    }
    model.resultEffective = effective;
    model.resultMessage = message;
    model.dataDictionary = data;
    model.httpCode = httpCode;
    !handleBlock?:handleBlock(model);
}

#pragma mark-
- (RACCommand *)commandWithRequestModel:(FFBasicNetworkRequestModel*(^)(void))requestBlock
                              andHandle:(void (^)(FFBasicNetworkResponseModel *))handleBlock {
    return [self commandWithRequestModel:requestBlock andOtherObj:nil andHandle:handleBlock];
}

- (RACCommand *)commandWithRequestModel:(FFBasicNetworkRequestModel*(^)(void))requestBlock
                            andOtherObj:(void(^)(id))otherObj
                              andHandle:(void (^)(FFBasicNetworkResponseModel *))handleBlock {
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            FFBasicNetworkRequestModel *model = requestBlock();
            //进行网络数据请求
            FFBasicNetworkManager *requestManager = [self requestWithModel:model andBlock:^(FFBasicNetworkResponseModel *responseModel) {
                if (handleBlock) {handleBlock(responseModel);}
                [subscriber sendNext:responseModel];
                [subscriber sendCompleted];
            }];
            !otherObj?:otherObj(requestManager.currentTask);
            return nil;
        }];
    }];
    return command;
}

#pragma mark-
- (void)responseModelHandleWithModel:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    //hud控制
    if (inputModel.requestParameters.needHud) {[self.hudSubject sendNext:@"1"];}
    //不同结果控制
    if (inputModel.responseObject && [inputModel.responseObject isKindOfClass:[NSDictionary class]]) {
        //返回数据结构是字典
        if (inputModel.httpCode>=400) {
            //处理错误码
            [self responseModelHandleWithModel_codeError:inputModel andHandle:handle];
        }else {
            //解析数据并返回
            [self responseModelHandleWithModel_success:inputModel andHandle:handle];
        }
    }else {
        //数据结构错误
        [self responseModelHandleWithModel_structError:inputModel andHandle:handle];
    }
}

///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel_success:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    !handle?:handle(inputModel);
}

///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel_codeError:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    [self handleErrorCodeWithResponseModel:inputModel andHandle:handle];
}

///子类重写----对返回参数进行操作
- (void)responseModelHandleWithModel_structError:(FFBasicNetworkResponseModel *)inputModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    !handle?:handle(inputModel);
}

- (FFBasicNetworkRequestModel *)requestModelHandleWithModel:(FFBasicNetworkRequestModel *)model {
    return model;
}

#pragma mark- errorcode
- (void)handleErrorCodeWithResponseModel:(FFBasicNetworkResponseModel *)responseModel andHandle:(void (^)(FFBasicNetworkResponseModel *))handle {
    !handle?:handle(responseModel);
}

#pragma mark- get
- (FFBasicNetworkManager *)request {
    if (!_request) {
        _request = [FFBasicNetworkManager new];
    }
    return _request;
}

@end
