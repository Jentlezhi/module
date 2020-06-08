//
//  CYTGetVehicleListsModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetVehicleListsModel.h"
#import "CYTVehicleToolsModel.h"

@implementation CYTGetVehicleListsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CYTVehicleToolsModel class]};
}

@end
