//
//  CYTGetVehicleDataNetWorkTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetVehicleDataNetWorkTool.h"

@implementation CYTGetVehicleDataNetWorkTool

+ (void)getVehicleDataWithType:(CYTGetVehicleType)getVehicleType success:(void(^)(CYTGetVehicleDataResult *result))success failure:(void(^)(NSError *error))failure{
    NSString *requsetUrl = getVehicleType == CYTGetVehicleTypeTools ? kURL.car_common_GetVehicleTools : kURL.car_common_GetVehicleProcedureDocuments;
    
    [CYTNetworkManager GET:requsetUrl parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            CYTGetVehicleDataResult *result = [CYTGetVehicleDataResult mj_objectWithKeyValues:responseObject.dataDictionary];
            success(result);
        }else {
            if (failure) {
                failure(nil);
            }
        }
    }];
}

@end
