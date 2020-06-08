//
//  CYTLoadingView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTLoadingViewConfig.h"

@interface CYTLoadingView : UIView
/*
 * 显示加载动画透明背景（自动获取当前控制器视图）
 */
+ (void)showLoadingWithType:(CYTLoadingViewType)loadingViewType;
/*
 * 显示加载动画透明背景（添加到指定视图）
 */
+ (void)showLoadingWithType:(CYTLoadingViewType)loadingViewType inView:(UIView *)view;
/*
 * 显示加载动画非透明背景（自动获取当前控制器视图）
 */
+ (void)showBackgroundLoadingWithType:(CYTLoadingViewType)loadingViewType;
/*
 * 显示加载动画非透明背景（添加到指定视图）
 */
+ (void)showBackgroundLoadingWithType:(CYTLoadingViewType)loadingViewType inView:(UIView *)view;
/*
 * 隐藏加载动画
 */
+ (void)hideLoadingView;
/*
 * 指定间隔隐藏加载动画
 */
+ (void)hideLoadingViewWithDuration:(CGFloat)duration;

@end
