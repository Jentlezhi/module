//
//  CYTLogisticsOrderStatusCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTLogisticOrderModel;

@interface CYTLogisticsOrderStatusCell : UITableViewCell

/** 订单 */
@property(strong, nonatomic)  CYTLogisticOrderModel *logisticOrderModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
