//
//  FFBasicNetworkRequestModel.h
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFExtendModel.h"

typedef NS_ENUM(NSInteger,NetRequestMethodType) {
    NetRequestMethodTypePost = 0,
    NetRequestMethodTypeGet = 1,
};

@interface FFBasicNetworkRequestModel : FFExtendModel
///网络请求方法
@property (nonatomic, assign) NetRequestMethodType methodType;
///url
@property (nonatomic, copy) NSString *requestURL;
///超时
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
///请求参数
@property (nonatomic, strong) NSMutableDictionary *requestParameters;
///是否需要hud
@property (nonatomic, assign) BOOL needHud;
///http头需要的参数
@property (nonatomic, strong) NSDictionary *httpHeadFiledDictionary;
///是否支持缓存
@property (nonatomic, assign) BOOL supportCache;

@end
