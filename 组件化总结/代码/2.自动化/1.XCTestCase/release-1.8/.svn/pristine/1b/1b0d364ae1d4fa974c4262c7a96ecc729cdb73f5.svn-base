//
//  FFBasicNetworkResponseModel.h
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFExtendModel.h"
#import "FFBasicNetworkRequestModel.h"

@interface FFBasicNetworkResponseModel : FFExtendModel
///服务器返回的数据
@property (nonatomic, strong) id responseObject;
///与errorCode值相同
@property (nonatomic, assign) NSInteger httpCode;
///原始请求参数
@property (nonatomic, strong) FFBasicNetworkRequestModel *requestParameters;

///网络请求最终数据是否有效标志
@property (nonatomic, assign) BOOL resultEffective;
///网络请求结果数据
@property (nonatomic, strong) NSDictionary *dataDictionary;
///网络请求最终提示
@property (nonatomic, copy) NSString *resultMessage;

@end
