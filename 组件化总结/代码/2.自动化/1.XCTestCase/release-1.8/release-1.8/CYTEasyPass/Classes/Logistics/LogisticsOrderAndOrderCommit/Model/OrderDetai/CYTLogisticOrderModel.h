//
//  CYTLogisticOrderModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTLogisticOrderModel : NSObject

/** 订单id */
@property(assign, nonatomic) NSInteger orderId;
/** 订单状态 */
@property(assign, nonatomic) NSInteger orderStatus;
/** 订单说明文本 */
@property(copy, nonatomic) NSString *orderStatusText;
/** 订单描述 */
@property(copy, nonatomic) NSString *orderStatusDesc;
/** 物流公司电话 */
@property(copy, nonatomic) NSString *logisticsPhoneNum;

@end
