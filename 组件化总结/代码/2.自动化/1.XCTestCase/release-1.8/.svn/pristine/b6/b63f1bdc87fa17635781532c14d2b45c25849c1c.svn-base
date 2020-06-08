//
//  CYTCoinCardView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicView.h"

typedef NS_ENUM(NSInteger, CYTCoinCardType) {
    CYTCoinCardTypeSignSuccess = 0,//签到成功
    CYTCoinCardTypeExchangeSuccess,//兑换成功
    CYTCoinCardTypeGetSuccess,//领取成功
    CYTCoinCardTypeTaskSpecification,//任务说明
    CYTCoinCardTypeTaskCompletion,//任务完成/申请成功
    CYTCoinCardTypeExpiredDesc,//易车币过期说明
};

@interface CYTCoinCardView : CYTBasicView

/** 结束的回调 */
@property(copy, nonatomic)  void(^completion)();

+ (instancetype)showSuccessWithType:(CYTCoinCardType)coinCardType model:(id)model;

@end
