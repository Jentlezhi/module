//
//  CYTSetPwdViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSetPwdViewController.h"
#import "CYTSetPwdView.h"
#import "CYTCompleteUserInfoViewController.h"
#import "CYTUsersInfoModel.h"

@interface CYTSetPwdViewController ()

/** 设置密码视图 */
@property(strong, nonatomic) CYTSetPwdView *setPwdView;
;

@end

@implementation CYTSetPwdViewController

- (void)loadView{
    CYTSetPwdView *setPwdView = [[CYTSetPwdView alloc] init];
    _setPwdView = setPwdView;
    self.view = setPwdView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPwdBasicConfig];
    [self initRSetPwdViewComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _setPwdView.showKeyboard = YES;
}
/**
 *  基本配置
 */
- (void)setPwdBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"设置密码"];
    self.interactivePopGestureEnable = NO;
}

/**
 *  初始化子控件
 */
- (void)initRSetPwdViewComponents{
    //已注册手机号赋值
    self.setPwdView.registerPhoneNum = self.registerPhoneNum;
    //设置密码下一步
    CYTWeakSelf
    self.setPwdView.setPwdNextStep = ^(CYTNetworkResponse *responseObject){
        CYTCompleteUserInfoViewController *completeUserInfoVC = [[CYTCompleteUserInfoViewController alloc] init];
        [[NSNotificationCenter defaultCenter] postNotificationName:kResiterSuccessKey object:nil];
        //保存用户信息到本地
        [CYTAccountManager sharedAccountManager].userKeyInfoModel = [CYTUserKeyInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
        [[CYTMessageCenterVM manager] uploadJPUSHID];
        [weakSelf.navigationController pushViewController:completeUserInfoVC animated:YES];
    };
    
}
/*
 * 返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    [CYTAlertView alertViewWithTitle:@"提示" message:@"返回后注册将中断，是否确认返回？" confirmAction:^{
        [super backButtonClick:backButton];
    } cancelAction:nil];
}

@end
