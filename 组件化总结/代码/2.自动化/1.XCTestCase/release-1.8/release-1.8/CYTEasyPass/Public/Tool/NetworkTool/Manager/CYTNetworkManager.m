//
//  CYTNetworkManager.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTNetworkManager.h"
#import "CYTExtendViewModel.h"

#ifdef DEBUG
static NSTimeInterval const defalutTimeoutIntervel = 15.f;
#else
static NSTimeInterval const defalutTimeoutIntervel = 20.f;
#endif

@interface CYTNetworkManager()

@end


@implementation CYTNetworkManager

+ (instancetype)sharedNetworkManager{
    static CYTNetworkManager *networkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[CYTNetworkManager alloc] init];
        networkManager.timeoutIntervel = defalutTimeoutIntervel;
    });
    return networkManager;
}

- (void)resetTimeoutIntervel{
    self.timeoutIntervel = defalutTimeoutIntervel;
}

/**
 *  POST请求
 */
+(void)POST:(NSString *)urlString parameters:(id)parameters dataTask:(void(^)(NSURLSessionDataTask *dataTask))dataTask showErrorTost:(BOOL)show completion:(void(^)(CYTNetworkResponse *responseObject))completion{
    [self dataTaskWithMethod:CYTRequsetMethodPOST url:urlString parameters:parameters dataTask:dataTask showErrorTost:show completion:completion];
}
/**
 *  GET请求
 */
+(void)GET:(NSString *)urlString parameters:(id)parameters dataTask:(void(^)(NSURLSessionDataTask *dataTask))dataTask showErrorTost:(BOOL)show completion:(void(^)(CYTNetworkResponse *responseObject))completion{
    [self dataTaskWithMethod:CYTRequsetMethodGET url:urlString parameters:parameters dataTask:dataTask showErrorTost:show completion:completion];
}
/**
 *  网络请求，集成POST和GET
 */
+ (void)dataTaskWithMethod:(CYTRequsetMethod)method url:(NSString *)urlString parameters:(id)parameters dataTask:(void(^)(NSURLSessionDataTask *dataTask))dataTask showErrorTost:(BOOL)show completion:(void(^)(CYTNetworkResponse *responseObject))completion{
    CYTExtendViewModel *viewModel = [CYTExtendViewModel new];
    RACCommand *command = [viewModel commandWithRequestModel:^FFBasicNetworkRequestModel *{
        FFBasicNetworkRequestModel *requestModel = [FFBasicNetworkRequestModel new];
        requestModel.requestURL = urlString;
        requestModel.requestParameters = parameters;
        requestModel.timeoutInterval = [CYTNetworkManager sharedNetworkManager].timeoutIntervel;
        requestModel.methodType = method == CYTRequsetMethodPOST ? NetRequestMethodTypePost:NetRequestMethodTypeGet;
        return requestModel;
    } andOtherObj:^(id task) {
        !dataTask?:dataTask((NSURLSessionDataTask *)task);
    } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
        NSDictionary *dict = responseModel.mj_keyValues;
        CYTNetworkResponse *response = [CYTNetworkResponse mj_objectWithKeyValues:dict];
        NSString *errorCode = @"errorCode";
        if ([[responseModel.responseObject allKeys] containsObject:errorCode]) {
            response.errorCode = [[responseModel.responseObject valueForKey:errorCode] integerValue];
        }
        if (!responseModel.resultEffective) {
            !show?:[CYTToast errorToastWithMessage:response.resultMessage];
        }
        !completion?:completion(response);
    }];
    [command execute:nil];
}
@end
