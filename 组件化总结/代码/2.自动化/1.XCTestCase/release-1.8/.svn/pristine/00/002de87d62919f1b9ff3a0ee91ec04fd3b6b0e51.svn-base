//
//  CYTRegisterAccountViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  

#import "CYTRegisterAccountViewController.h"
#import "CYTUnbindView.h"
#import "CYTBindView.h"
#import "CYTFillCodeViewController.h"

@interface CYTRegisterAccountViewController()

/** 用户已绑定 */
@property(strong, nonatomic) CYTBindView *bindView;
/** 用户未绑定 */
@property(strong, nonatomic) CYTUnbindView *unBindView;

@end

@implementation CYTRegisterAccountViewController

- (CYTBindView *)bindView{
    if (!_bindView) {
        _bindView = [[CYTBindView alloc] init];
        [self.view addSubview:_bindView];
        [_bindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(CYTViewOriginY);
        }];
    }
    return _bindView;
}

- (CYTUnbindView *)unBindView{
    if (!_unBindView) {
        _unBindView = [[CYTUnbindView alloc] init];
        [self.view addSubview:_unBindView];
        [_unBindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(CYTViewOriginY);
        }];
    }
    return _unBindView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerAccountnBasicConfig];
    [self initRegisterAccountComponents];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _unBindView.showKeyboard = !_unBindView.hidden;
}
/**
 *  基本配置
 */
- (void)registerAccountnBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"注册"];
    self.view.backgroundColor = kFFColor_bg_nor;
    self.interactivePopGestureEnable = NO;
    //添加视图
    [self.view addSubview:self.unBindView];
    [self.view addSubview:self.bindView];
}

/**
 *  初始化子控件
 */
- (void)initRegisterAccountComponents{
    //显示未注册视图
    self.unBindView.hidden = NO;
    self.bindView.hidden = !self.unBindView.isHidden;
    //注册页面手机号赋值
    self.unBindView.registerPhoneNum = self.registerPhoneNum;
    //下一步按钮的回调
    CYTWeakSelf
    self.unBindView.nextStepClick = ^(CYTUserStatus userStatus,NSString *registerPhoneNum){
        if (userStatus == CYTUserStatusUnRegister) {//未注册
            CYTFillCodeViewController *fillCodeVC = [[CYTFillCodeViewController alloc] init];
            fillCodeVC.registerPhoneNum = registerPhoneNum;
            [weakSelf.navigationController pushViewController:fillCodeVC animated:YES];
        }else{
            [weakSelf.view endEditing:YES];
            weakSelf.unBindView.hidden = YES;
            weakSelf.bindView.registerPhoneNum = registerPhoneNum;
            weakSelf.bindView.hidden = !weakSelf.unBindView.isHidden;
        }


    };
    
    //用户注册协议的回调
    self.unBindView.userProtocolClick = ^{
        CYTH5WithInteractiveCtr *protocolVC = [[CYTH5WithInteractiveCtr alloc] init];
        protocolVC.requestURL = kURL.kUserProtocolUrl;
        [weakSelf.navigationController pushViewController:protocolVC animated:YES];
        
    };
    
    //已注册用户的交互
    
    //返回登录
    self.bindView.backToLogin = ^(NSString *account){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    //找回密码
    self.bindView.findPwd = ^{
        CYTFillCodeViewController *fillCodeVC = [[CYTFillCodeViewController alloc] init];
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        appManager.setPwdType = CYTSetPwdTypeReset;
        fillCodeVC.registerPhoneNum = appManager.userPhoneNum;
        [weakSelf.navigationController pushViewController:fillCodeVC animated:YES];
    };
    
    //使用其他手机号注册
    self.bindView.useOtherLogin = ^{
        weakSelf.unBindView.showKeyboard = YES;
        weakSelf.bindView.hidden = YES;
        weakSelf.unBindView.hidden = !weakSelf.bindView.isHidden;
        weakSelf.unBindView.registerPhoneNum = @"";
    };
}
/*
 * 返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    if (self.bindView.isHidden) {
        [CYTAlertView alertViewWithTitle:@"提示" message:@"返回后注册将中断，是否确认返回？" confirmAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        } cancelAction:nil];
    }else{
        [super backButtonClick:backButton];
    }

}

@end
