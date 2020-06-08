//
//  CYTYiCheCoinInfoView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicView.h"

@class CYTCoinSignResultModel;

@interface CYTYiCheCoinInfoView : CYTBasicView

/** 签到模型 */
@property(strong, nonatomic) CYTCoinSignResultModel *signResultModel;
/** 签到按钮的点击 */
@property(copy, nonatomic) void(^signBtnClick)();
/** 金币的点击 */
@property(copy, nonatomic) void(^amountClick)();

@end
