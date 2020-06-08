//
//  CYTCoinTaskCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

@class CYTTaskModel;

@class CYTGetCoinModel;

@interface CYTCoinTaskCell : CYTBasicTableViewCell

/** 任务模型 */
@property(strong, nonatomic) CYTTaskModel *taskModel;
/** 领取 */
@property(copy, nonatomic) void(^receiveAward)(CYTGetCoinModel *getCoinModel);

@end
