//
//  CYTCouponListItemModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCouponListItemModel : NSObject

/** 分页索引 */
@property(assign, nonatomic) NSInteger index;
/** 优惠券名称 */
@property(copy, nonatomic) NSString *couponName;
/** 使用限制（0-全额） */
@property(copy, nonatomic) NSString *limitDesc;
/** 抵扣金额 */
@property(copy, nonatomic) NSString *reduceMoney;
/** 券类型(满减1，包邮2，折扣3) */
@property(assign, nonatomic) CYTCouponType couponType;
/** 生效时间 */
@property(copy, nonatomic) NSString *beginTime;
/** 失效时间 */
@property(copy, nonatomic) NSString *endTime;
/** 券标签 */
@property(strong, nonatomic) NSArray *couponMarks;
/** 卡券号 */
@property(copy, nonatomic) NSString *couponCode;
/** 券状态 */
@property(assign, nonatomic) CYTCouponStatusType status;
/** 是否显示选中标识 */
@property(assign, nonatomic,getter=isSelected) BOOL selected;

@end
