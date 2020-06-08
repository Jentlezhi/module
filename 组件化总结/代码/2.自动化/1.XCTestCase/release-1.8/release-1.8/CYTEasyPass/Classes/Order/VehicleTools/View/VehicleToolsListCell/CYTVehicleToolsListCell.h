//
//  CYTVehicleToolsModelListCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

@class CYTVehicleToolsModel;

@interface CYTVehicleToolsListCell : CYTBasicTableViewCell

/** 随车工具模型 */
@property(strong, nonatomic) CYTVehicleToolsModel *vehicleToolsModel;


@end
