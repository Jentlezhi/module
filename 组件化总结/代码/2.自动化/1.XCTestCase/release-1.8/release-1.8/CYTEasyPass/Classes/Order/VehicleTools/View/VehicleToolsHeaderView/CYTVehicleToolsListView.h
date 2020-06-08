//
//  CYTVehicleToolsListView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CYTVehicleToolsViewTypeHeaderView = 0, //分组
    CYTVehicleToolsViewTypeList,//列表
} CYTVehicleToolsListType;

@class CYTVehicleToolsModel;

@interface CYTVehicleToolsListView : UIView

/** 随车工具模型 */
@property(strong, nonatomic) CYTVehicleToolsModel *vehicleToolsModel;
/** 点击回调 */
@property(copy, nonatomic) void(^sectionHeaderClick)();

- (instancetype)initWithType:(CYTVehicleToolsListType)listType;

@end
