//
//  CYTCouponListParameters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCouponListParameters : NSObject

/** 开始索引 */
@property(assign, nonatomic) NSInteger lastId;
/** 券状态（1-未使用；2-已使用；3-已过期） */
@property(assign, nonatomic) NSInteger status;
/** 业务线（1-物流订单；2-车源订单） */
@property(assign, nonatomic) NSInteger productType;
/** 业务线主键（productType=1时，物流报价主键） */
@property(copy, nonatomic) NSString *logicId;

@end
