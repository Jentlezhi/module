//
//  CYTComonRewardCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

@class CYTTaskModel;

@interface CYTComonRewardCell : CYTBasicTableViewCell

/** 任务模型 */
@property(strong, nonatomic) CYTTaskModel *taskModel;

@end
