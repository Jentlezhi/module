//
//  CYTGetVehicleDataNetWorkTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTGetVehicleDataResult.h"
#import "CYTGetVehicleListsModel.h"
#import "CYTVehicleToolsModel.h"

typedef enum : NSUInteger {
    CYTGetVehicleTypeTools = 0, //获取随车工具
    CYTGetVehicleTypeProcedure ,  //获取随车手续
} CYTGetVehicleType;

@interface CYTGetVehicleDataNetWorkTool : NSObject

+ (void)getVehicleDataWithType:(CYTGetVehicleType)getVehicleType success:(void(^)(CYTGetVehicleDataResult *result))success failure:(void(^)(NSError *error))failure;

@end
