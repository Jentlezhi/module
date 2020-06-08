//
//  CYTLogisticsOrderListModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedListModel.h"

@interface CYTLogisticsOrderListModel : CYTLogisticsNeedListModel
///订单id
@property (nonatomic, assign) NSInteger orderId;
///运单状态
@property (nonatomic, assign) CYTLogisticsOrderStatus orderStatus;
///状态描述
@property (nonatomic, copy) NSString *orderStatusDesc;
///时间
@property (nonatomic, copy) NSString *orderSubmitTime;

@end
