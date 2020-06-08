//
//  CYTOrderNumberInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTOrderModel;

@interface CYTOrderNumberInfoCell : UITableViewCell

/** 订单模型 */
@property(strong, nonatomic) CYTOrderModel *orderModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
