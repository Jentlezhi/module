//
//  CYTMissionRewardsModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTMissionRewardsModel : NSObject

/** 领取的奖励值 */
@property(copy, nonatomic) NSString *rewardValue;
/** 是否全部完成新手任务 */
@property(assign, nonatomic) BOOL isAllFinished;
/** 任务状态 */
@property(assign, nonatomic) NSInteger status;
@end
