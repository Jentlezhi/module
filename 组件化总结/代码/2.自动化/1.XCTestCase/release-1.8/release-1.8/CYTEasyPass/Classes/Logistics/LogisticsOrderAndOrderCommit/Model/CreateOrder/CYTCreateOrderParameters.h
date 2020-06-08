//
//  CYTCreateOrderParameters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCreateOrderParameters : NSObject

/** 报价Id */
@property(copy, nonatomic) NSString *demandPriceId;
/** 发车人姓名 */
@property(copy, nonatomic) NSString *senderName;
/** 发车人电话 */
@property(copy, nonatomic) NSString *senderTel;
/** 发车详细地址 */
@property(copy, nonatomic) NSString *sDetailedAddress;
/** 收车人姓名 */
@property(copy, nonatomic) NSString *receiverName;
/** 收车人电话 */
@property(copy, nonatomic) NSString *receiverTel;
/** 收车详细地址 */
@property(copy, nonatomic) NSString *rDetailedAddress;
/** 收车人身份证号 */
@property(copy, nonatomic) NSString *receiverIdentityNo;
/** 卡券号，没有优惠券传空字符串 */
@property(copy, nonatomic) NSString *couponCode;

@end
