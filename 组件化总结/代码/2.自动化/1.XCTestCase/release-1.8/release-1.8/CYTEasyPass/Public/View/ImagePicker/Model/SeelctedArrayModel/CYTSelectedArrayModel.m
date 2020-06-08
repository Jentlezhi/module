//
//  CYTSeelctedArrayModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSelectedArrayModel.h"

@implementation CYTSelectedArrayModel

- (instancetype)init{
    if (self = [super init]) {
        self.selectedModels = [NSMutableArray array];
    }
    return self;
}

@end
