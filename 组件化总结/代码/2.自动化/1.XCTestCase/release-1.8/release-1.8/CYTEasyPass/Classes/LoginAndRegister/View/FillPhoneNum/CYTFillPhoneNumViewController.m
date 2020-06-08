//
//  CYTFillPhoneNumViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFillPhoneNumViewController.h"
#import "CYTFillPhoneNumView.h"
#import "CYTFillCodeViewController.h"
#import "CYTRegisterAccountViewController.h"


@interface CYTFillPhoneNumViewController ()

/** 填写手机号视图 */
@property(weak, nonatomic) CYTFillPhoneNumView *fillPhoneNumView;

@end

@implementation CYTFillPhoneNumViewController

- (void)loadView{
    CYTFillPhoneNumView *fillPhoneNumView = [[CYTFillPhoneNumView alloc] init];
    _fillPhoneNumView = fillPhoneNumView;
    self.view = fillPhoneNumView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillPhoneNumBasicConfig];
    [self initFillPhoneNumComponents];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _fillPhoneNumView.showKeyboard = YES;
}

/**
 *  基本配置
 */
- (void)fillPhoneNumBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"忘记密码"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.interactivePopGestureEnable = NO;
}

/**
 *  初始化子控件
 */
- (void)initFillPhoneNumComponents{
    //若上个页面填写手机号，则填写
    [_fillPhoneNumView setValue:_registerPhoneNum forKeyPath:@"accountTF.text"];
    //继续按钮
    CYTWeakSelf
    _fillPhoneNumView.nextStepClick = ^(NSString *phoneNum,CYTNetworkResponse *responseObject){
        //ErrorCode:3000002代表手机号未注册
        if (responseObject.resultEffective) {
            CYTFillCodeViewController *fillCodeVC = [[CYTFillCodeViewController alloc] init];
            fillCodeVC.registerPhoneNum = phoneNum;
            [weakSelf.navigationController pushViewController:fillCodeVC animated:YES];
        }else if(responseObject.httpCode == 3000002){
            [CYTAlertView alertViewWithTitle:@"提示" message:@"该手机号未注册，是否前往注册？" confirmAction:^{
                CYTAppManager *appManager = [CYTAppManager sharedAppManager];
                appManager.setPwdType = CYTSetPwdTypeSet;
                CYTRegisterAccountViewController *registerAccountVC = [[CYTRegisterAccountViewController alloc] init];
                registerAccountVC.registerPhoneNum = phoneNum;
                [weakSelf.navigationController pushViewController:registerAccountVC animated:YES];
            } cancelAction:nil];
        }else{
            [CYTToast errorToastWithMessage:responseObject.resultMessage];
        }

    };
}


@end
