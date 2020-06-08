//
//  CYTTotalExpensesCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTLogisticDemandPriceModel;

@interface CYTTotalExpensesCell : UITableViewCell
/** 费用明细回调 */
@property(copy, nonatomic) void(^expensesDetailBlock)();
/** 物流需求报价 */
@property(strong, nonatomic) CYTLogisticDemandPriceModel *logisticDemandPriceModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
