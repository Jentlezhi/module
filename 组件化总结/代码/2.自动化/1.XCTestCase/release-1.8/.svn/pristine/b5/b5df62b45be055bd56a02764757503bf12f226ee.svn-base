//
//  CYTPaymentModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,PaymentType) {
    ///订金
    PaymentType_dingjin = 9,
    ///物流费用
    PaymentType_logistics=12,
};

typedef NS_ENUM(NSInteger,PayType) {
    ///支付宝
    //正式49，  测试59,74
    PayType_zhifubao,
    ///微信
    PayType_weixin,
};

typedef NS_ENUM(NSInteger,PaySourceType) {
    ///订单，返回订单列表
    PaySourceTypeOrderList,
    ///物流，返回物流订单详情
    PaySourceTypeLogistics,
    ///订单，返回订单详情
    PaySourceTypeOrderDetail,
};

typedef NS_ENUM(NSInteger,PayResultType) {
    ///余额完成支付
    PayResultTypeBalanceFinished,
    ///余额支付取消
    PayResultTypeBalanceCancel,
    
    ///非余额支付
    PayResultTypePayFinished,
    ///支付中
    PayResultTypePaying,
    ///非余额支付取消,从余额支付进入
    PayResultTypePayCancelWithBView,
    ///非余额支付取消,没有经过余额支付直接进入
    PayResultTypePayCancelWithNotBView,
};

@interface CYTPaymentModel : NSObject
///待支付总金额
@property (nonatomic, assign) float unPayTotalCash;
///余额已经支付金额
@property (nonatomic, assign) float balancePaidCash;
///剩余支付金额
@property (nonatomic, assign) float unPaidCash;

///订单
@property (nonatomic, copy) NSString *orderId;
///付款类型
@property (nonatomic, assign) PaymentType paymentType;
///支付方式
@property (nonatomic, assign) PayType payType;
///支付结果
@property (nonatomic, assign) PayResultType payResultType;
///支付入口
@property (nonatomic, assign) PaySourceType sourceType;
///支付信息
@property (nonatomic, copy) NSString *signedString;
///是否经过余额支付页面
@property (nonatomic, assign) BOOL haveBalanceView;

@end
