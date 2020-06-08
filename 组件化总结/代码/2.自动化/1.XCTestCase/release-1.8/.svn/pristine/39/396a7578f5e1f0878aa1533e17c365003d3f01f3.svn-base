//
//  CYTFinishRegisterViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFinishRegisterViewController.h"
#import "CYTFinishRegisterView.h"
#import "CYTPersonalCertificateViewController.h"

@interface CYTFinishRegisterViewController ()

/** 注册完成视图 */
@property(weak, nonatomic) CYTFinishRegisterView *finishRegisterView;


@end

@implementation CYTFinishRegisterViewController

- (void)loadView{
    CYTFinishRegisterView *finishRegisterView = [[CYTFinishRegisterView alloc] init];
    _finishRegisterView = finishRegisterView;
    self.view = finishRegisterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self finishRegisterBasicConfig];
    [self initFinishRegisterComponents];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
/**
 *  基本配置
 */
- (void)finishRegisterBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"注册完成"];
    self.interactivePopGestureEnable = NO;
}

/**
 *  初始化子控件
 */
- (void)initFinishRegisterComponents{
    //继续按钮
    CYTWeakSelf
    self.finishRegisterView.continueOperation = ^{
        CYTPersonalCertificateViewController *personalCertificateVC = [[CYTPersonalCertificateViewController alloc] init];
        personalCertificateVC.backType = CYTBackTypeGoHome;
        [weakSelf.navigationController pushViewController:personalCertificateVC animated:YES];
    };
    //先逛逛按钮
    self.finishRegisterView.notContinueOperation = ^{
        [kAppdelegate goHomeView];
    };
    
    //已注册手机号赋值
    self.finishRegisterView.registerPhoneNum = self.registerPhoneNum;
}

@end
