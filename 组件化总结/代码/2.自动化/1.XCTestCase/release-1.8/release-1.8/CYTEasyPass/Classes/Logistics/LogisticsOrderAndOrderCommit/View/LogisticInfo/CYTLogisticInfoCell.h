//
//  CYTContactsContentCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTConfirmOrderInfoModel;

@class CYTLogisticDemandModel;

@class CYTLogisticDemandPriceModel;

@class CYTLogisticOrderModel;

@interface CYTLogisticInfoCell : UITableViewCell

/** 物流信息模型 */
@property(strong, nonatomic) CYTConfirmOrderInfoModel *confirmOrderInfoModel;

/** 车辆详情 */
@property(strong, nonatomic) CYTLogisticDemandModel *logisticDemandModel;

/** 物流需求报价 */
@property(strong, nonatomic) CYTLogisticDemandPriceModel *logisticDemandPriceModel;


+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel;

@end
