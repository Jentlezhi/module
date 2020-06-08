//
//  CYTTaskModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTTaskModel : NSObject

/** 任务Id */
@property(copy, nonatomic) NSString *taskId;
/** 任务标题 */
@property(copy, nonatomic) NSString *title;
/** 任务奖励值 */
@property(copy, nonatomic) NSString *rewardValue;
/** 任务状态（1去完成 ，2待领取，3任务说明，4已结束，5已完成，6结果链接） */
@property(assign, nonatomic) NSInteger taskStatus;
/** 1、新手任务，3、活动任务 */
@property(assign, nonatomic) NSInteger taskType;
/** 跳转链接（cxt://...；http://xxx;cxt://dialog/xxx?descirption=xxx） */
@property(copy, nonatomic) NSString *scheme;
/** 常规奖励内容 */
@property(copy, nonatomic) NSString *rewardContent;

@end
