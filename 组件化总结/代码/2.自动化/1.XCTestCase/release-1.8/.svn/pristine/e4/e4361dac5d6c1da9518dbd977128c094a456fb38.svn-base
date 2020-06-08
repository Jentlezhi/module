//
//  FFBasicViewController.h
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//
/*
 */
#import <UIKit/UIKit.h>
#import "FFNavigationView.h"
#import "FFBasicEnum.h"
#import "FFDZNSupernatant.h"

@interface FFBasicViewController : UIViewController
///导航view
@property (nonatomic, strong) FFNavigationView *ffNavigationView;
///contentView
@property (nonatomic, strong) FFExtendView *ffContentView;
///dzn
@property (nonatomic, strong) FFDZNSupernatant *ffDZNControl;

///设置title
@property (nonatomic, copy) NSString *ffTitle;
///是否显示导航
@property (nonatomic, assign) BOOL showNavigationView;
///是否显示导航底部阴影
@property (nonatomic, assign) BOOL showNavigationBottomLine;

///普通变量
@property (nonatomic, strong) id ffobj;

///是否允许当前页面右滑手势返回操作
@property (nonatomic, assign) BOOL interactivePopGestureEnable;
///设置statusBar样式
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

#pragma mark- 流程控制
///流程控制
- (void)ff_initWithViewModel:(id)viewModel;
- (void)ff_bindViewModel;
- (void)ff_addSubViewAndConstraints;

///使用viewModel初始化控制器(对rac的支持)
- (instancetype)initWithViewModel:(FFExtendViewModel *)viewModel;

#pragma mark- 导航点击方法
- (void)ff_leftClicked:(FFNavigationItemView *)backView;
- (void)ff_titleClicked:(FFNavigationItemView *)titleView;
- (void)ff_rightClicked:(FFNavigationItemView *)rightView;

#pragma mark- 处理空数据和加载失败情况


/**
 显示空/失败页面

 @param type dzn样式
 @param insets insets设置
 */
- (void)showResultViewWithType:(DZNViewType)type andInsets:(UIEdgeInsets)insets;
///隐藏
- (void)hideResultView;

@end
