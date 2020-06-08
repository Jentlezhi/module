//
//  CYTUserCertificationResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUserCertificationResult.h"
#import "CYTUserInfoModel.h"

@implementation CYTUserCertificationResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"Data" : [CYTUserInfoModel class]};
}

@end
