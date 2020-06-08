//
//  CYTLoginViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  用户登录模块

#import "CYTBasicViewController.h"
#import "CYTUserKeyInfoModel.h"

@interface CYTLoginViewController : CYTBasicViewController

/** 是否显示返回按钮 */
@property(assign, nonatomic, getter=isShowBackButton) BOOL showBackButton;

@property (nonatomic, copy) void (^loginStateBlock) (BOOL);

- (void)backMethod;

@end
