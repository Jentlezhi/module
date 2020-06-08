//
//  CYTFillCodeViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFillCodeViewController.h"
#import "CYTFillCodeView.h"
#import "CYTSetPwdViewController.h"
#import "CYTResetPwdViewController.h"

@interface CYTFillCodeViewController ()

/** 滚动视图 */
@property(weak, nonatomic) UITableView *mainView;

/** 填写验证码视图 */
@property(weak, nonatomic) CYTFillCodeView *fillCodeView;

@end

@implementation CYTFillCodeViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _fillCodeView.showKeyboard = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillCodeBasicConfig];
    [self initFillCodeComponents];
}
/**
 *  基本配置
 */
- (void)fillCodeBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"填写验证码"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.interactivePopGestureEnable = NO;
}

/**
 *  初始化子控件
 */
- (void)initFillCodeComponents{
    //滚动视图
    UITableView *mainView = [[UITableView alloc] init];
    if (@available(iOS 11.0, *)) {
        mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        mainView.estimatedSectionFooterHeight = 0;
        mainView.estimatedSectionHeaderHeight = 0;
    }
    mainView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight-CYTViewOriginY);
    [self.view addSubview:mainView];
    _mainView = mainView;
    mainView.tableFooterView = [[UIView alloc] init];
    CYTFillCodeView *fillCodeView = [[CYTFillCodeView alloc] init];
    fillCodeView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-CYTViewOriginY);
    [_mainView addSubview:fillCodeView];
    [self.view layoutIfNeeded];
    _fillCodeView = fillCodeView;
    //已注册手机号赋值
    self.fillCodeView.registerPhoneNum = self.registerPhoneNum;
    //验证码视图的下一步点击
    CYTWeakSelf
    self.fillCodeView.fillCodeNextStep = ^{
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        if (appManager.setPwdType == CYTSetPwdTypeReset) {
            CYTResetPwdViewController *resetPwdVC = [[CYTResetPwdViewController alloc] init];
            resetPwdVC.registerPhoneNum = weakSelf.registerPhoneNum;
            [weakSelf.navigationController pushViewController:resetPwdVC animated:YES];
        }else{
            CYTSetPwdViewController *setPwdVC = [[CYTSetPwdViewController alloc] init];
            setPwdVC.registerPhoneNum = weakSelf.registerPhoneNum;
            [weakSelf.navigationController pushViewController:setPwdVC animated:YES];
        }
    };
}



@end
