//
//  CYTLogisticLogCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTLogisticLogModel;

@interface CYTLogisticLogCell : UITableViewCell

/** 物流订单日志模型 */
@property(strong, nonatomic) CYTLogisticLogModel *logisticLogModel;


+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
