//
//  FFBasicNetworkRequestModel.m
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFBasicNetworkRequestModel.h"

@implementation FFBasicNetworkRequestModel

- (instancetype)init {
    if (self = [super init]) {
        _methodType = NetRequestMethodTypePost;
    }
    return self;
}

@end
