//
//  CYTUserBaseInfoResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUserBaseInfoResult.h"
#import "CYTUsersInfoModel.h"

@implementation CYTUserBaseInfoResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"data" : [CYTUsersInfoModel class]};
}

@end
