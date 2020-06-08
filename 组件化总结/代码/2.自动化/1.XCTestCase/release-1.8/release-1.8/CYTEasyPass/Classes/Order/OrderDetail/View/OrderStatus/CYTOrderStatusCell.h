//
//  CYTOrderStatusCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTOrderModel;

@interface CYTOrderStatusCell : UITableViewCell

/** 订单模型 */
@property(strong, nonatomic) CYTOrderModel *orderModel;


+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
