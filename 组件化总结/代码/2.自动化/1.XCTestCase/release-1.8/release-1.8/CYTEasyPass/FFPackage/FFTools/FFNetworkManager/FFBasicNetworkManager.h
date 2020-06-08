//
//  FFBasicNetworkManager.h
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFExtendViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "FFBasicNetworkResponseModel.h"
#import "FFBasicNetworkRequestModel.h"
#import "MJExtension.h"

@interface FFBasicNetworkManager : FFExtendViewModel
///当前task
@property (nonatomic, strong) NSURLSessionTask *currentTask;
///取消当前网络请求
- (void)cancelCurrentTask;
///post请求
- (FFBasicNetworkManager *)postWithModel:(FFBasicNetworkRequestModel *)model result:(void (^)(FFBasicNetworkResponseModel *responseObject))result;
///get请求
- (FFBasicNetworkManager *)getWithModel:(FFBasicNetworkRequestModel *)model result:(void (^)(FFBasicNetworkResponseModel *responseObject))result;

@end
