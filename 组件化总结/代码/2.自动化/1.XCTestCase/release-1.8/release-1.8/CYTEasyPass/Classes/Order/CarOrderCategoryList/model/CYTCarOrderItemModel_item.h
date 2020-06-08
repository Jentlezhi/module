//
//  CYTCarOrderItemModel_item.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTCarOrderItemModel_item : FFExtendModel
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, assign) NSInteger rowId;
//订单状态，订单号
@property (nonatomic, copy) NSString *orderCode;
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, copy) NSString *orderStatusDesc;
//车辆信息
@property (nonatomic, copy) NSString *carMainName;
@property (nonatomic, copy) NSString *carDetailName;

@property (nonatomic, copy) NSString *inColor;
@property (nonatomic, copy) NSString *importTypeName;
@property (nonatomic, copy) NSString *exColor;
@property (nonatomic, copy) NSString *carCityName;

@property (nonatomic, copy) NSString *price;
///拼好的“xxx万”
@property (nonatomic, copy) NSString *carReferPriceDesc;
///"xxxx"
@property (nonatomic, copy) NSString *carReferPrice;
@property (nonatomic, copy) NSString *payDesc;

@property (nonatomic, copy) NSString *depositAmount;
@property (nonatomic, copy) NSString *createOrderTime;

@property (nonatomic, copy) NSString *refundMoney;
///已付款
@property (nonatomic, copy) NSString *payPartDesc;
/** 0-没有物流订单(不弹框) 1-未支付（弹框） 2-支付后（toast提示） */
@property(assign, nonatomic) NSInteger logisticsStatus;
/** V1.7新增取消订单的提示文字 */
@property(copy, nonatomic) NSString *logisticsCancelTip;

@end
