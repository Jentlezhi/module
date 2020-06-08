//
//  CYTYiCheCoinSignView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicView.h"

@class CYTCoinSignResultModel;

@interface CYTYiCheCoinSignView : CYTBasicView

/** 签到模型 */
@property(strong, nonatomic) CYTCoinSignResultModel *signResultModel;

@end
