//
//  CYTSettingModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSettingModel.h"

@implementation CYTSettingModel

+ (NSDictionary *)objectClassInDictionary{
    return @{
             @"firstSection" : [NSArray class],
             @"secondSection": [NSArray class],
             @"thirdSection" : [NSArray class],
             };
}

@end
