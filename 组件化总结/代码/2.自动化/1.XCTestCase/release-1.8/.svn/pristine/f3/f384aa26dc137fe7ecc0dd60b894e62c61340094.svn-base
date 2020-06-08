//
//  CYTMyCouponViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTCouponListItemModel;

@interface CYTMyCouponViewController : CYTBasicViewController

/** 卡券的选择回调 */
@property(copy, nonatomic) void(^couponSelectBlock)(CYTCouponListItemModel *couponListItemModel);
/** 卡券模型 */
@property(strong, nonatomic) CYTCouponListItemModel *couponListItemModel;
/** 报价Id */
@property(copy, nonatomic) NSString *demandPriceId;

+ (instancetype)myCouponWithCouponCardType:(CYTMyCouponCardType)couponCardType;

@end
