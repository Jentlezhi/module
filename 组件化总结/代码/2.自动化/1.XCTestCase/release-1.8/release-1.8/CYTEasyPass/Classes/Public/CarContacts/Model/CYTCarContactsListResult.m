//
//  CYTCarContactsListResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarContactsListResult.h"
#import "CYTCarContactsListModel.h"

@implementation CYTCarContactsListResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"Data" : [CYTCarContactsListModel class]};
}

@end
