//
//  CYTOrderExtendSectionModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderExtendSectionModel.h"
#import "CYTConfirmSendCarModel.h"

@implementation CYTOrderExtendSectionModel

+ (NSDictionary *)objectClassInArray{
    return @{@"sectionData" : [CYTConfirmSendCarModel class]};
}

@end
