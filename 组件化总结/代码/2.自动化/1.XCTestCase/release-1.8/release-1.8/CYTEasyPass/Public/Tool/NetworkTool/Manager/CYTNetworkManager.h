//
//  CYTNetworkManager.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTNetworkResponse.h"

typedef enum : NSUInteger {
    CYTRequsetMethodPOST = 0,
    CYTRequsetMethodGET,
} CYTRequsetMethod;

@interface CYTNetworkManager : NSObject

/** 网络超时时间 */
@property(assign, nonatomic) NSTimeInterval timeoutIntervel;
/**
 *  单例
 */
+ (instancetype)sharedNetworkManager;
/**
 *  重置请求超时时间
 */
- (void)resetTimeoutIntervel;
/**
 *  POST请求
 *
 *  @param urlString  请求路径
 *  @param parameters 请求参数
 *  @param dataTask   请求任务
 *  @param show       显示错误原因
 *  @param completion 请求完成回调
 */
+(void)POST:(NSString *)urlString parameters:(id)parameters dataTask:(void(^)(NSURLSessionDataTask *dataTask))dataTask showErrorTost:(BOOL)show completion:(void(^)(CYTNetworkResponse *responseObject))completion;
/**
 *  GET请求
 *
 *  @param urlString  请求路径
 *  @param parameters 请求参数
 *  @param dataTask   请求任务
 *  @param show       显示错误原因
 *  @param completion 请求完成回调
 */
+(void)GET:(NSString *)urlString parameters:(id)parameters dataTask:(void(^)(NSURLSessionDataTask *dataTask))dataTask showErrorTost:(BOOL)show completion:(void(^)(CYTNetworkResponse *responseObject))completion;

@end
