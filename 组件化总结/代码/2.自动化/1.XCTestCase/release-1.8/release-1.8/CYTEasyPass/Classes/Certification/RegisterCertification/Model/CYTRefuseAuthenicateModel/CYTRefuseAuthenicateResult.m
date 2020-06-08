//
//  CYTRefuseAuthenicateResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTRefuseAuthenicateResult.h"
#import "CYTRefuseAuthenicateReason.h"

@implementation CYTRefuseAuthenicateResult

+ (NSDictionary *)objectClassInArray{
    return @{@"Data" : [CYTRefuseAuthenicateReason class]};
}

@end
