//
//  CYTLoginViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLoginViewController.h"
#import "CYTRegisterAccountViewController.h"
#import "CYTAccountLoginView.h"
#import "CYTFillPhoneNumViewController.h"
#import "CYTResetPwdViewController.h"
#import "CYTUsersInfoModel.h"

@interface CYTLoginViewController()

/** 登录视图 */
@property(strong, nonatomic) CYTAccountLoginView *accountLoginView;

@end

@implementation CYTLoginViewController

- (void)loadView{
    CYTAccountLoginView *accountLoginView = [[CYTAccountLoginView alloc] init];
    _accountLoginView = accountLoginView;
    self.view = accountLoginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self accountLoginBasicConfig];
    [self initAccountLoginComponents];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _accountLoginView.showKeyboard = YES;
}

/**
 *  基本配置
 */
- (void)accountLoginBasicConfig{
    [self createNavBarWithTitle:@"账户登录" andShowBackButton:self.isShowBackButton showRightButtonWithTitle:@"帮助"];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.interactivePopGestureEnable = NO;
}

/**
 *  初始化子控件
 */
- (void)initAccountLoginComponents{
    CYTWeakSelf
    //登录按钮的点击
    _accountLoginView.loginSuccess = ^(CYTNetworkResponse *response) {
        CYTUserKeyInfoModel *userKeyInfoModel = [CYTUserKeyInfoModel mj_objectWithKeyValues:response.dataDictionary];
        [CYTAccountManager sharedAccountManager].userKeyInfoModel = userKeyInfoModel;
        [[CYTAccountManager sharedAccountManager] updateUserInfoCompletion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kloginSucceedKey object:nil];
        [[CYTMessageCenterVM manager] uploadJPUSHID];
        
        [weakSelf.navigationController dismissViewControllerAnimated:NO completion:^{
            !weakSelf.loginStateBlock?:weakSelf.loginStateBlock(YES);
        }];
    };
    //免费注册的点击
    _accountLoginView.registerAccount = ^{
        CYTRegisterAccountViewController *registerAccountVC = [[CYTRegisterAccountViewController alloc] init];
        [weakSelf.navigationController pushViewController:registerAccountVC animated:YES];
        
    };
    
    //忘记密码的点击
    _accountLoginView.forgetPwd = ^{
        CYTFillPhoneNumViewController *fillPhoneNumVC = [[CYTFillPhoneNumViewController alloc] init];
        NSString *phoneNum = [weakSelf.accountLoginView valueForKeyPath:@"_accountTF.text"];
        fillPhoneNumVC.registerPhoneNum = phoneNum==nil?@"":phoneNum;
        [weakSelf.navigationController pushViewController:fillPhoneNumVC animated:YES];
    };
}

- (void)backButtonClick:(UIButton *)backButton{
    [self backMethodAndBlock];
}

- (void)backMethodAndBlock {
    [self backMethod];
}

- (void)backMethod {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  帮助
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kLoginHelpUrl;
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
