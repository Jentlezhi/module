//
//  CYTCoinRecordModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCoinRecordModel.h"

@implementation CYTCoinRecordModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"recDescription" : @"description"};
}

@end
