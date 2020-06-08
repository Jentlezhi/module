//
//  CYTCoinHeaderView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicView.h"

@class CYTCoinSectionModel;

@interface CYTCoinHeaderView : CYTBasicView

/** 模型 */
@property(strong, nonatomic) CYTCoinSectionModel *sectionModel;

/** 点击的回调 */
@property(copy, nonatomic) void(^clickCallBack)();

@end
