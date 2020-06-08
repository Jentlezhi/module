//
//  CYTGetColorBasicVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetColorBasicVM.h"

@implementation CYTGetColorBasicVM

///处理颜色数据
+ (NSArray *)colorArray:(NSArray *)colorArray withType:(CarColorType)type {
    NSMutableArray *tmpArray = [colorArray mutableCopy];
    if (tmpArray.count == 0) {
        tmpArray = [NSMutableArray array];
    }
    NSString *configItem = @"";

    if (type == CarColorTypeAll) {
        configItem = @"全部";
    }else if (type == CarColorTypeColorAll) {
        configItem = @"色全";
    }else if (type == CarColorTypeNoLimit) {
        configItem = @"不限";
    }
    
    [tmpArray insertObject:configItem atIndex:0];
    return tmpArray;
}

@end
