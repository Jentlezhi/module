//
//  CYTAddressListResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressListResult.h"
#import "CYTAddressListModel.h"

@implementation CYTAddressListResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"data" : [CYTAddressListModel class]};
}

@end
