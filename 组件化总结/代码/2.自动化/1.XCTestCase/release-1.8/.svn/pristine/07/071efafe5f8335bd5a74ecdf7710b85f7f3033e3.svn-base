//
//  CYTResetPwdViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTResetPwdViewController.h"
#import "CYTResetPwdView.h"
#import "CYTFinishResetPwdViewController.h"
#import "CYTResetPwdResult.h"
#import "CYTUsersInfoModel.h"

@interface CYTResetPwdViewController ()

/** 登录视图 */
@property(strong, nonatomic) CYTResetPwdView *resetPwdView;

@end

@implementation CYTResetPwdViewController

- (void)loadView{
    CYTResetPwdView *resetPwdView = [[CYTResetPwdView alloc] init];
    _resetPwdView = resetPwdView;
    self.view = resetPwdView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetPwdBasicConfig];
    [self initResetPwdnComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _resetPwdView.showKeyboard = YES;
}

/**
 *  基本配置
 */
- (void)resetPwdBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"重置密码"];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

/**
 *  初始化子控件
 */
- (void)initResetPwdnComponents{
    //下一步按钮的点击
    CYTWeakSelf
    _resetPwdView.resetPwdNextStep = ^(CYTNetworkResponse *responseObject){
        CYTFinishResetPwdViewController *finishResetPwdVC = [[CYTFinishResetPwdViewController alloc] init];
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        finishResetPwdVC.registerPhoneNum = appManager.userPhoneNum;
        CYTUserKeyInfoModel *userKeyInfoModel = [CYTUserKeyInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
        [CYTAccountManager sharedAccountManager].userKeyInfoModel = userKeyInfoModel;
        [[NSNotificationCenter defaultCenter] postNotificationName:kResetPwdSucceedKey object:nil];
        [[CYTMessageCenterVM manager] uploadJPUSHID];
        [weakSelf.navigationController pushViewController:finishResetPwdVC animated:YES];
    };
}






@end
