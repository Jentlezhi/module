//
//  CYTRecCarDetailInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTLogisticDemandModel;

@interface CYTRecCarDetailInfoCell : UITableViewCell

/** 车辆详情 */
@property(strong, nonatomic) CYTLogisticDemandModel *logisticDemandModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
