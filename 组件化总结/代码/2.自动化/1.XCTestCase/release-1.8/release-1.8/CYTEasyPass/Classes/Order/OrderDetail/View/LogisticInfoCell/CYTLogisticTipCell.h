//
//  CYTLogisticInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTLogisticTipCell : UITableViewCell

/** 物流点击回调 */
@property(copy, nonatomic) void(^logisticClick)();

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
