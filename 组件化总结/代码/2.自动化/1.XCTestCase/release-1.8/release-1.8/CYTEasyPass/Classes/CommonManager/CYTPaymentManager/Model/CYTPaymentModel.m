//
//  CYTPaymentModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPaymentModel.h"

@implementation CYTPaymentModel

- (void)setPayType:(PayType)payType {
    //支付宝参数处理
    if (payType == PayType_zhifubao) {
        _payType = (kURL.urlType == CYTURLTypeProduction || kURL.urlType == CYTURLTypeProductionWNS)?49:74;
    }
}

@end
