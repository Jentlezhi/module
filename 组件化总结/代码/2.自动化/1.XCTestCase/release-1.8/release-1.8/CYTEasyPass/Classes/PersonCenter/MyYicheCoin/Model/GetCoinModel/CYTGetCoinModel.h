//
//  CYTGetCoinModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTGetCoinModel : NSObject

/** 领取的奖励值 */
@property(copy, nonatomic) NSString *rewardValue;
/** 是否全部完成新手任务 */
@property(assign, nonatomic) BOOL isAllFinished;
/** 任务状态 */
@property(assign, nonatomic) NSInteger status;
/** 易车币数量 */
@property(copy, nonatomic) NSString *amount;

@end
