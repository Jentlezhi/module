//
//  CYTSendCarConfirmedModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTSendCarConfirmedModel : NSObject

/** 发车公司 */
@property(copy, nonatomic) NSString *sendCompanyName;
/** 发车地址（省市区详细地址） */
@property(copy, nonatomic) NSString *sendAddress;
/** 发车人信息(姓名 手机号 ) */
@property(copy, nonatomic) NSString *senderInfo;
/** 1.车源， 2，寻车*/
@property(assign, nonatomic) NSInteger orderType;
/** 买家电话 */
@property(copy, nonatomic) NSString *buyerPhone;
/** 0-没有物流订单(不弹框) 1-未支付（弹框） 2-支付后（toast提示） */
@property(assign, nonatomic) NSInteger logisticsStatus;
/** 取消订单的提示文字 */
@property(copy, nonatomic) NSString *logisticsCancelTip;

@end
