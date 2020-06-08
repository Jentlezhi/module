//
//  CYTMyCouponCardTagView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTCouponTagModel;

@interface CYTMyCouponCardTagView : UIView

/** 点击回调 */
@property(copy, nonatomic) void(^indicatorClicked)(NSInteger index);

/** 标题模型 */
@property(strong, nonatomic) CYTCouponTagModel *couponTagModel;

/** 当前选中索引 */
@property(assign, nonatomic) NSInteger currentIndex;

- (instancetype)initWithCouponCardType:(CYTMyCouponCardType)aCouponCardType;

@end
