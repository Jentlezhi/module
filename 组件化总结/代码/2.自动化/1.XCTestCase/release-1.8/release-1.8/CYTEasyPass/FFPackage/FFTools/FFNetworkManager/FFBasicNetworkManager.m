//
//  FFBasicNetworkManager.m
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFBasicNetworkManager.h"

@interface FFBasicNetworkManager ()
///manager
@property (nonatomic, strong) AFURLSessionManager *urlSessionManager;

@end

@implementation FFBasicNetworkManager

- (void)cancelCurrentTask {
    if (self.currentTask) {
        [self.currentTask cancel];
    }
}

- (NSMutableURLRequest *)getRequestWithModel:(FFBasicNetworkRequestModel *)model withMethod:(NSString *)method{
    //去除空格
    model.requestURL = [model.requestURL stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (!model.requestParameters) {
        model.requestParameters = @{};
    }
    
    //创建请求实例
    //在初始化的时候使用 AFJSONRequestSerializer 即设置了请求格式为json
    //为请求增加格式在此处设置
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:model.requestURL parameters:model.requestParameters error:nil];
    
    //设置header
    NSArray *filedKeys = model.httpHeadFiledDictionary.allKeys;
    if (filedKeys.count>0) {
        for (int i=0; i<filedKeys.count; i++) {
            NSString *key = filedKeys[i];
            NSString *value = [model.httpHeadFiledDictionary objectForKey:key];
            [request setValue:value forHTTPHeaderField:key];
        }
    }
    
    //设置超时时间
    request.timeoutInterval = (model.timeoutInterval==0)?30:model.timeoutInterval;
    
    return request;
}

- (FFBasicNetworkManager *)postWithModel:(FFBasicNetworkRequestModel *)model result:(void (^)(FFBasicNetworkResponseModel *))result {
    
    NSMutableURLRequest *request = [self getRequestWithModel:model withMethod:@"POST"];
    //task
    self.currentTask = [self.urlSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        FFBasicNetworkResponseModel *responseModel = [FFBasicNetworkResponseModel new];
        responseModel.requestParameters = model;
        responseModel.httpCode = ((NSHTTPURLResponse *)response).statusCode;
        responseModel.responseObject = responseObject;
        result(responseModel);
    }];
    
    //启动，必须调用！！
    [self.currentTask resume];
    
    return self;
}

- (FFBasicNetworkManager *)getWithModel:(FFBasicNetworkRequestModel *)model result:(void (^)(FFBasicNetworkResponseModel *))result {
    
    NSMutableURLRequest *request = [self getRequestWithModel:model withMethod:@"GET"];
    
    //task
    self.currentTask = [self.urlSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        FFBasicNetworkResponseModel *responseModel = [FFBasicNetworkResponseModel new];
        responseModel.requestParameters = model;
        responseModel.httpCode = ((NSHTTPURLResponse *)response).statusCode;
        responseModel.responseObject = responseObject;
        result(responseModel);
    }];
    
    //启动，必须调用！！
    [self.currentTask resume];
    
    return self;
}

#pragma mark- get
- (AFURLSessionManager *)urlSessionManager {
    if (!_urlSessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.allowsCellularAccess = YES;
        _urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    }
    return _urlSessionManager;
}

@end
