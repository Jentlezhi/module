//
//  CYTDealerCommentPublishView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 使用注意；
 在使用页面需要关闭iqkeyboard功能（造成监听键盘尺寸错误）
 - (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
 }
 
 - (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
 
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
 }
 */
#import "FFExtendView.h"
#import "CYTDealerCommentPublishContentView.h"

@interface CYTDealerCommentPublishView : FFExtendView

@property (nonatomic, strong) CYTDealerCommentPublishVM *viewModel;
///设置title
@property (nonatomic, copy) NSString *title;
///立刻显示
- (void)showNow;

- (void)config;

@end
