//
//  CYTOrderModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYTImageVoucherModel;

@interface CYTOrderModel : NSObject

/** 订单code */
@property(copy, nonatomic) NSString *orderCode;
/** 待付款：1,待发车：11，待收车：200，待评价：300，交易成功：311，退款：12，已取消：-1 */
@property(assign, nonatomic) NSInteger orderStatus;
/** 下单时间(2017.10.17) */
@property(copy, nonatomic) NSString *createOrderTime;
/** 附加描述（取消原因，验收情况） */
@property(copy, nonatomic) NSString *additionalDesc;
/** 订单状态描述 一大串描述文字 */
@property(copy, nonatomic) NSString *orderStatusDesc;
/** 订单说明文本（待付款之类，交易成功，已取消，(当前退款状态：待卖家处理)） */
@property(copy, nonatomic) NSString *orderStatusText;
/** 关联的物流Id(没有的话返回0) */
@property(assign, nonatomic) NSInteger logisticsOrderId;
/** 0-没有物流订单(不弹框) 1-未支付（弹框） 2-支付后（toast提示） */
@property(assign, nonatomic) NSInteger logisticsStatus;
/** 取消订单的提示文字 */
@property(copy, nonatomic) NSString *logisticsCancelTip;
/** 交易人id（买车订单：卖家id，卖车订单：买家id） */
@property(copy, nonatomic) NSString *traderUserId;
/** 退款金额 */
@property(copy, nonatomic) NSString *refundMoney;
/** 图片凭证 */
@property(strong, nonatomic) NSArray<CYTImageVoucherModel*>*customImageVouchers;
///1-车源，2-寻车
@property(assign, nonatomic) NSInteger orderSourceType;
///车源id/寻车id
@property(assign, nonatomic) NSInteger carTypeId;
///数量（1.8增加）
@property(assign, nonatomic) NSInteger carNum;

@end
