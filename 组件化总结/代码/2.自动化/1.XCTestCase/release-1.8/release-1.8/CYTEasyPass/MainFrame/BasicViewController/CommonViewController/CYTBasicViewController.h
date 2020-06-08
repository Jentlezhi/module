//
//  CYTBasicViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTNoNetworkView.h"
#import "CYTNoDataView.h"

typedef enum : NSUInteger {
    CYTStatusBarStyleLightContent,
    CYTStatusBarStyleDefault,
} CYTStatusBarStyle;

@interface CYTBasicViewController : UIViewController
/** 状态栏样式 */
@property(assign, nonatomic) CYTStatusBarStyle statusBarStyle;
/** 状态栏颜色 */
@property(strong, nonatomic) UIColor *statusBarColor;
/** 导航栏颜色 */
@property(strong, nonatomic) UIColor *navigationBarColor;
/** 状态栏 */
@property(strong, nonatomic) UIImageView *statusBar;
/** 导航栏 */
@property(strong, nonatomic) UIImageView *navigationBar;
/** 导航区域 */
@property(weak, nonatomic) UIImageView *navigationZone;
/** 导航栏标题 */
@property(copy, nonatomic) NSString *navTitle;
/** 导航栏标题颜色 */
@property(copy, nonatomic) UIColor *navTitleColor;
/** 是否隐藏导航栏分割线 */
@property(assign, nonatomic) BOOL hiddenNavigationBarLine;
/** 网络请求 */
@property(strong, nonatomic) NSURLSessionDataTask *sessionDataTask;
/** 手势返回是否允许 */
@property(assign, nonatomic) BOOL interactivePopGestureEnable;
/** 导航栏状态 */
@property(assign, nonatomic, getter=isHiddenNavigationBar) BOOL hiddeNnavigationBar;
/** 视图将要消失 */
@property(assign, nonatomic,getter=isViewWillDisappear) BOOL viewWillDisappear;
/** 右按钮 */
@property(strong, nonatomic) UIButton *rightItemButton;
/** 右按钮标题 */
@property(copy, nonatomic) NSString *rightButtonTitle;
/** 状态栏的显示与隐藏 */
@property(assign, nonatomic,getter=isShowStatusBar) BOOL showStatusBar;
/** 设置返回按钮的颜色 */
@property(strong, nonatomic) UIColor *backBtnColor;
/** 无数据提示文字 */
@property(copy, nonatomic) NSString *noDataViewText;
/** 无数据界面 */
@property(strong, nonatomic) CYTNoDataView *noDataView;
/** 无网络界面 */
@property(strong, nonatomic) CYTNoNetworkView *noNetworkView;
/** 当前页面点击tabBar的回调 */
@property(copy, nonatomic) void(^doubleClickTabBarBlock)();
/** 滚动视图 */
@property(strong, nonatomic) UITableView *basicTableView;
///增加初始化方法，传递基础参数
- (instancetype)initWithViewModel:(id)viewModel;

/**
 *  设置导航栏标题
 *
 *  @param title     标题
 *  @param fontSize  字体大小
 *  @param textColor 字体颜色
 */
- (void)settingNavTitleWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor;
/**
 *  自定义标题导航栏
 *
 *  @param tittle           导航栏标题
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮的标题（传空默认不显示）
 */
- (void)createNavBarWithTitle:(NSString *)tittle andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle;
/**
 *  创建隐藏左、右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithTitle:(NSString *)tittle;
/**
 *  创建隐藏右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitle:(NSString *)tittle;
/**
 *  创建图片导航栏
 *
 *  @param tittleImage      导航栏图片
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮标题（传空默认不显示）
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle;
/**
 *  创建隐藏左、右按钮的图片导航栏
 *
 *  @param tittleImage 标题图片
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage;
/**
 *  创建隐藏右按钮的图片导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitleView:(UIImage *)tittleImage;
/**
 *  创建自定义按钮的导航栏
 *
 *  @param leftButton  左按钮
 *  @param titleButton 标题按钮
 *  @param rightButton 右按钮
 */
- (void)createNavBarWithLeftButton:(UIButton *)leftButton titleView:(UIView *)titleView andRightButton:(UIButton *)rightButton;
/**
 *  显示导航栏的
 */
- (void)showNavigationBarWithAnimation:(BOOL)animation;
/**
 *  隐藏导航栏
 */
- (void)hideNavigationBarWithAnimation:(BOOL)animation;
/**
 *  导航栏的显示与隐藏
 */
- (void)showOrHiddenNavigationBarWithAnimation:(BOOL)animation;
/**
 *  返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton;

/**
 *  左边按钮的点击
 */
- (void)leftButtonClick:(UIButton *)rightButton;

/**
 *  标题按钮的点击
 */
- (void)titleButtonClick:(UIButton *)rightButton;

/**
 *  右边按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton;

/**
 *  取消网络请求任务
 */
- (void)cancelRequest;
/**
 *  显示无网络界面
 */
- (void)showNoNetworkView;
/**
 *  显示无网络界面到指定界面
 */
- (void)showNoNetworkViewInView:(UIView *)view;
/**
 *  移除无网络界面
 */
- (void)dismissNoNetworkView;
/**
 *  重新加载
 */
- (void)reloadData;
/**
 *  显示无数据界面
 */
- (void)showNoDataView;
/**
 *  移除无数据界面
 */
- (void)dismissNoDataView;

@end
