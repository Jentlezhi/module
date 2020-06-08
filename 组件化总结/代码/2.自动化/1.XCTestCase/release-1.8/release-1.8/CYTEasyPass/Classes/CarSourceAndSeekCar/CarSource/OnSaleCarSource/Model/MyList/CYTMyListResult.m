//
//  CYTMyListResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyListResult.h"
#import "CYTMyListDataModel.h"

@implementation CYTMyListResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"data" : [CYTMyListDataModel class]};
}

@end
