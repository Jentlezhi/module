//
//  CYTReSetPwdResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTResetPwdResult.h"
#import "CYTUsersInfoModel.h"

@implementation CYTResetPwdResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"Data" : [CYTUsersInfoModel class]};
}

@end
