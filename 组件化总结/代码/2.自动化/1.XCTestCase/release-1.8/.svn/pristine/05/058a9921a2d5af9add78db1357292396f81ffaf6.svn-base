//
//  CYTGetCashNextCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashNextCtr.h"
#import "CYTGetCashBottomView.h"
#import "CYTGetCashNextView.h"
#import "CYTWithdrawFinishedTableController.h"
#import "CYTGetCashPwdInputView.h"

@interface CYTGetCashNextCtr ()
@property (nonatomic, strong) CYTGetCashNextView *userNameView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) CYTGetCashNextView *accountView;
@property (nonatomic, strong) UILabel *descriptLabel;
@property (nonatomic, strong) CYTGetCashBottomView *bottomView;
@property (nonatomic, strong) CYTGetCashPwdInputView *inputView;


@end

@implementation CYTGetCashNextCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithBackButtonAndTitle:@"提现至支付宝账户"];
    self.view.backgroundColor = kFFColor_bg_nor;
    [self bindViewModel];
    [self loadUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    extern NSString *CYTKeyboardSwitchNot;
    [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(NO)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.accountView.textFiled becomeFirstResponder];
}

///关闭手势返回功能---------------------->>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.interactivePopGestureEnable = NO;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.interactivePopGestureEnable = YES;
}
///<<<------------------------------------

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        }else{
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        @strongify(self);
        //如果成功则跳转页面
        //失败则提示，并清空点
        if (model.resultEffective) {
            self.viewModel.poundage = model.dataDictionary[@"fee"];
            CYTWithdrawFinishedTableController *ctr = [CYTWithdrawFinishedTableController new];
            ctr.accountString = self.viewModel.account;
            ctr.cashMount = self.viewModel.totalCash;
            ctr.poundage = self.viewModel.poundage;
            [self.navigationController pushViewController:ctr animated:YES]; 
        }else{
            if (self.inputView) {
                self.inputView.error = model.resultMessage;
            }
        }
    }];
}

- (void)loadUI {
    [self.view addSubview:self.userNameView];
    [self.view addSubview:self.line];
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.descriptLabel];
    [self.view addSubview:self.bottomView];
    
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY+10);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userNameView);
        make.height.equalTo(CYTLineH);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
    }];
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.userNameView.bottom);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.accountView.mas_bottom).offset(10);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.top.equalTo(self.accountView.mas_bottom).offset(CYTAutoLayoutV(170));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
}

#pragma mark- handle alert
///显示alert
- (void)handleAlertView {
    CYTGetCashPwdInputView *alertView = [CYTGetCashPwdInputView new];
    alertView.cashWillGet = self.viewModel.totalCash;
    alertView.alertView.titleLabel.text = @"请输入交易密码";
    alertView.alertView.desLabel.text = @"交易手续费平台已全额垫付";
    
    @weakify(self);
    [alertView setFinishedBlock:^(NSString *pwd) {
        @strongify(self);
        self.viewModel.pwdString = pwd;
        [self.viewModel.requestCommand execute:nil];
    }];
    
    [alertView showInView:self.view];
    self.inputView = alertView;
}

#pragma mark- get
- (CYTGetCashNextView *)userNameView {
    if (!_userNameView) {
        _userNameView = [CYTGetCashNextView new];
        _userNameView.textFiled.placeholder = @"请输入真实姓名";
        _userNameView.titleLabel.text = @"真实姓名";
        _userNameView.textFiled.keyboardType = UIKeyboardTypeDefault;
        NSString *userName = [CYTAccountManager sharedAccountManager].userAuthenticateInfoModel.userName;
        userName = (userName)?:@"";
        self.viewModel.accountName = userName;
        _userNameView.textFiled.text = userName;
        @weakify(self);
        [[_userNameView.textFiled rac_textSignal] subscribeNext:^(NSString *x) {
            @strongify(self);
            self.viewModel.accountName = x;
            self.bottomView.actionEnable = self.viewModel.canSubmit;
        }];
    }
    return _userNameView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (CYTGetCashNextView *)accountView {
    if (!_accountView) {
        _accountView = [CYTGetCashNextView new];
        _accountView.textFiled.placeholder = @"请输入手机号或支付宝账号";
        _accountView.titleLabel.text = @"支付宝账户";
        _accountView.textFiled.keyboardType = UIKeyboardTypeDefault;
        @weakify(self);
        [[_accountView.textFiled rac_textSignal] subscribeNext:^(NSString *x) {
            @strongify(self);
            self.viewModel.account = x;
            self.bottomView.actionEnable = self.viewModel.canSubmit;
        }];
    }
    return _accountView;
}

- (UILabel *)descriptLabel {
    if (!_descriptLabel) {
        _descriptLabel = [UILabel new];
        _descriptLabel.hidden = YES;
        _descriptLabel.font = CYTFontWithPixel(24);
        _descriptLabel.textColor = CYTRedColor;
        _descriptLabel.text = @"只能提现至自己的支付宝账户，提现成功则无法退款";
    }
    return _descriptLabel;
}

- (CYTGetCashBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CYTGetCashBottomView new];
        [_bottomView.actionButton setTitle:@"下一步" forState:UIControlStateNormal];
        _bottomView.actionEnable = NO;
        @weakify(self);
        [_bottomView setClickedBlock:^{
            @strongify(self);
            [self handleAlertView];
        }];
    }
    return _bottomView;
}

@end
