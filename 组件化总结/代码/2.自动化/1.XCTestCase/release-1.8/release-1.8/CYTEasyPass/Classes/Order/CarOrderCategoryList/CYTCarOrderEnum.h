//
//  CYTCarOrderEnum.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#ifndef CYTCarOrderEnum_h
#define CYTCarOrderEnum_h

///订单分类
typedef NS_ENUM(NSInteger,CarOrderType) {
    CarOrderTypeBought,
    CarOrderTypeSold
};

///待付款：1,待发车：11，待收车：200，待评价：300，交易成功：311，退款：12，待卖家处理：13，待系统处理：14；已取消：-1
typedef NS_ENUM(NSInteger,CarOrderState) {
    CarOrderStateAll = 0,
    CarOrderStateUnPay = 1,
    CarOrderStateUnSendCar = 11,
    CarOrderStateUnReceiveCar = 200,
    CarOrderStateUnComment = 300,
    CarOrderStateSucceed = 311,
    CarOrderStateCancel = -1,
    CarOrderStateRefund = 12,
    CarOrderStateRefundSellerDo = 13,
    CarOrderStateRefundSysDo = 14,
};



#endif /* CYTCarOrderEnum_h */
