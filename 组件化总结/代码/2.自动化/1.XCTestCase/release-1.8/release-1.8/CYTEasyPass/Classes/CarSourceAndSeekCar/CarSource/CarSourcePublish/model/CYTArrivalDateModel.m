//
//  CYTArrivalDateModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTArrivalDateModel.h"


@implementation CYTArrivalDateItemModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"idCode" : @"id"};
}
@end


@implementation CYTArrivalDateModel
+ (NSDictionary *)objectClassInArray{
    return @{@"items" : @"CYTArrivalDateItemModel"};
}

@end

