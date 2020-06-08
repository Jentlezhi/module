//
//  CYTAcceptanceSituationCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import"CYTBasicTableViewCell.h"

@class CYTOrderModel;

@interface CYTAcceptanceSituationCell : CYTBasicTableViewCell

/** 订单模型 */
@property(strong, nonatomic) CYTOrderModel *orderModel;
/** 点击的回调 */
@property(copy, nonatomic) void(^voucherPictureViewClick)(NSInteger index);

@end
