//
//  CYTCoinSignResultModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCoinSignResultModel : NSObject

/** 今天是否签到 */
@property(assign, nonatomic) BOOL isSignIn;
/** 连续签到天数 */
@property(assign, nonatomic) NSUInteger continuousDays;
/** 基准天（默认值4） */
@property(copy, nonatomic) NSString *baseDay;
/** 小于基准天奖励数 */
@property(copy, nonatomic) NSString *preBaseCoins;
/** 大于等于基准天奖励数 */
@property(copy, nonatomic) NSString *sufBaseCoins;
/** 易车币数量 */
@property(copy, nonatomic) NSString *amount;
/** 预期签到奖励 */
@property(copy, nonatomic) NSString *nextRewardValue;
/** 当次奖励值 */
@property(copy, nonatomic) NSString *rewardValue;

//以下为自定义属性
/** 突出金币 */
@property(assign, nonatomic) BOOL keyCoinValue;
/** 网络正常 */
@property(assign, nonatomic) BOOL netWorkError;

@end
