//
//  CYTCarInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTCarSourceInfo;
@class CYTSeekCarInfo;
@class CYTCarModel;

typedef enum : NSUInteger {
    CYTCarInfoCellTypeCarSource = 0,     //车源提交订单
    CYTCarInfoCellTypeSeekCar,       //寻车提交订单
    CYTCarInfoCellTypeOrderDetail,//订单详情
} CYTCarInfoCellType;

@interface CYTCarInfoCell : UITableViewCell

/** 数据模型 */
@property(strong, nonatomic) CYTSeekCarInfo *seekCarInfo;
/** 数据模型 */
@property(strong, nonatomic) CYTCarSourceInfo *carSourceInfo;
/** 数据模型 */
@property(strong, nonatomic) CYTCarModel *carModel;

+ (instancetype)cellWithType:(CYTCarInfoCellType)carInfoCellType forTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
//点击事件
@property (nonatomic, copy) void (^clickedBlock)(CYTCarModel *);

@end
