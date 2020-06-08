//
//  CYTCouponListResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCouponListResult.h"
#import "CYTCouponListModel.h"

@implementation CYTCouponListResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"data" : [CYTCouponListModel class]};
}

@end
