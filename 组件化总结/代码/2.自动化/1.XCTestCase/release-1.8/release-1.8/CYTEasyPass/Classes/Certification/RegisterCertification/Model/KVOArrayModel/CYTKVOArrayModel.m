//
//  CYTKVOArrayModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTKVOArrayModel.h"

@implementation CYTKVOArrayModel

- (instancetype)init{
    if (self = [super init]) {
        self.modelArray = [NSMutableArray array];
    }
    return self;
}

@end
