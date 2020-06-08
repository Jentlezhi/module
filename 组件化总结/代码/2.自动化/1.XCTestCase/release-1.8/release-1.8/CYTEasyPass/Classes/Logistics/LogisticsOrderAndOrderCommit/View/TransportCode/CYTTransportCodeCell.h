//
//  CYTTransportCodeCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTLogisticTranOrderModel;

@interface CYTTransportCodeCell : UITableViewCell

/** 运单模型 */
@property(strong, nonatomic) CYTLogisticTranOrderModel *logisticTranOrderModel;


+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
