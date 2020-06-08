//
//  CYTRootResponseModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRootResponseModel.h"

@implementation CYTRootResponseModel

- (instancetype)init{
    if (self = [super init]) {
        self.arrayData = [NSMutableArray array];
        self.dictData = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
