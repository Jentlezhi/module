//
//  CYTVehicleModelViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewController.h"

typedef NS_ENUM(NSUInteger, CYTGetVehicleType) {
    CYTGetVehicleTypeTools = 0, //获取随车工具
    CYTGetVehicleTypeProcedure ,  //获取随车手续
};

typedef NS_ENUM(NSUInteger, CYTVehicleToolsType) {
    CYTVehicleToolsTypeTools = 0,//随车工具
    CYTVehicleToolsTypeProcedure,//获取随车手续
};

@class CYTVehicleToolsModel;

@interface CYTVehicleToolsViewController : CYTBasicTableViewController

/** 选择结果回调 */
@property(copy, nonatomic) void(^vehicleToolsSelected)(NSArray <CYTVehicleToolsModel *>*vehicleToolsModels);

+ (instancetype)vehicleToolsWithToolsType:(CYTVehicleToolsType)vehicleToolsType;

@end
