//
//  CYTLoginView.m
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAccountLoginView.h"
#import "CYTLoginViewModel.h"
#import "CYTLoginResult.h"
#import "CYTUsersInfoModel.h"

NSString *const CYTKeyboardSwitchNot = @"KeyboardSwitchNot";

@interface CYTAccountLoginView()

/** 账号输入框 */
@property(weak, nonatomic) UITextField *accountTF;
/** 密码输入框 */
@property(weak, nonatomic) UITextField *pwdTF;
/** 登录按钮 */
@property(weak, nonatomic) UIButton *loginBtn;
/** 登录逻辑 */
@property(strong, nonatomic) CYTLoginViewModel *loginViewModel;

@end

@implementation CYTAccountLoginView

- (CYTLoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[CYTLoginViewModel alloc] init];
    }
    return _loginViewModel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loginAccontBasicConfig];
        [self initLoginAccontComponents];
        [self bindLoginViewModel];
        [self handelTextFieldAndLoginBtn];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)loginAccontBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initLoginAccontComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTViewOriginY);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    
    //账号
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.textColor = CYTHexColor(@"#333333");
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.font = CYTFontWithPixel(30);
    accountLabel.text = @"账号";
    [self addSubview:accountLabel];
    
    [accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(topBar.mas_bottom).offset(CYTAutoLayoutV(172));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(34*5), CYTAutoLayoutV(84)));
    }];
    
    //账号输入框
    UITextField *accountTF = [[UITextField alloc] init];
    accountTF.placeholder = @"请输入手机号";
    accountTF.keyboardType = UIKeyboardTypeNumberPad;
    accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountTF.textColor = CYTHexColor(@"#333333");
    accountTF.font = CYTFontWithPixel(30);
    [self addSubview:accountTF];
    _accountTF = accountTF;
    [accountTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLabel.mas_right);
        make.centerY.equalTo(accountLabel);
        make.height.equalTo(accountLabel);
        make.right.equalTo(self).offset(-CYTMarginH);
    }];
    
    //账号分割线
    UILabel *accountLineLabel = [[UILabel alloc] init];
    accountLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:accountLineLabel];
    [accountLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountLabel.mas_bottom);
        make.left.equalTo(accountLabel);
        make.right.equalTo(accountTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    
    //密码
    UILabel *pwdLabel = [[UILabel alloc] init];
    pwdLabel.textColor = CYTHexColor(@"#333333");
    pwdLabel.textAlignment = NSTextAlignmentLeft;
    pwdLabel.font = CYTFontWithPixel(30);
    pwdLabel.text = @"登录密码";
    [self addSubview:pwdLabel];
    
    [pwdLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(accountLineLabel.mas_bottom).offset(CYTAutoLayoutV(22));
        make.size.equalTo(accountLabel);
    }];
    
    //密码输入框
    UITextField *pwdTF = [[UITextField alloc] init];
    pwdTF.placeholder = @"请输入密码";
    pwdTF.keyboardType = UIKeyboardTypeASCIICapable;
    pwdTF.secureTextEntry = YES;
    pwdTF.textColor = CYTHexColor(@"#333333");
    pwdTF.font = CYTFontWithPixel(30);
    [self addSubview:pwdTF];
    _pwdTF = pwdTF;
    [pwdTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdLabel.mas_right);
        make.top.height.equalTo(pwdLabel);
        make.right.equalTo(self).offset(-CYTDefaultMarigin);
    }];
    
    //密码分割线
    UILabel *pwdLineLabel = [[UILabel alloc] init];
    pwdLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:pwdLineLabel];
    [pwdLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdLabel.mas_bottom);
        make.left.equalTo(pwdLabel);
        make.right.equalTo(pwdTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //隐藏密码按钮
    UIImageView *hiddenPwd = [[UIImageView alloc] init];
    hiddenPwd.userInteractionEnabled = YES;
    hiddenPwd.image = [UIImage imageNamed:@"look_h_"];
    [self addSubview:hiddenPwd];
    [hiddenPwd makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(40), CYTAutoLayoutV(40)));
        make.right.equalTo(self).offset(-(CYTAutoLayoutV(50)+CYTMarginH));
        make.centerY.equalTo(pwdLabel);
    }];
    
    UITapGestureRecognizer *hiddenPwdTap = [[UITapGestureRecognizer alloc] init];
    [[hiddenPwdTap rac_gestureSignal] subscribeNext:^(id x) {
        //密码输入框调出键盘
        [self.pwdTF becomeFirstResponder];
        self.pwdTF.secureTextEntry = !self.pwdTF.secureTextEntry;
        NSString *hiddenImage = self.pwdTF.secureTextEntry?@"look_h_":@"look_";
        hiddenPwd.image = [UIImage imageNamed:hiddenImage];
        [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(self.pwdTF.secureTextEntry)];
    }];
    [hiddenPwd addGestureRecognizer:hiddenPwdTap];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithTitle:@"登录" enabled:NO];
    [self addSubview:loginBtn];
    _loginBtn = loginBtn;
    [loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(pwdLineLabel.mas_bottom).offset(CYTAutoLayoutH(58));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    CYTWeakSelf
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(CYTLoginResult *result) {
        //退出键盘
        [self endEditing:YES];
        loginBtn.enabled = NO;
        [[weakSelf.loginViewModel.loginCommand execute:nil] subscribeNext:^(CYTNetworkResponse *response) {
            loginBtn.enabled = YES;
            if (!response.resultEffective) {
                return;
            }
           !weakSelf.loginSuccess?:weakSelf.loginSuccess(response);
            
        }];
    }];
    
    //忘记密码
    UILabel *forgetPwdBtn = [[UILabel alloc] init];
    forgetPwdBtn.userInteractionEnabled = YES;
    forgetPwdBtn.textColor = CYTHexColor(@"#999999");
    forgetPwdBtn.textAlignment = NSTextAlignmentRight;
    forgetPwdBtn.font = CYTFontWithPixel(26);
    forgetPwdBtn.text = @"忘记密码？";
    [self addSubview:forgetPwdBtn];
    
    [forgetPwdBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).offset(CYTAutoLayoutH(30));
        make.right.equalTo(loginBtn);
    }];
    
    UITapGestureRecognizer *forgrtPwdTap = [[UITapGestureRecognizer alloc] init];
    [[forgrtPwdTap rac_gestureSignal] subscribeNext:^(id x) {
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        appManager.setPwdType = CYTSetPwdTypeReset;
        !self.forgetPwd?:self.forgetPwd();
    }];
    [forgetPwdBtn addGestureRecognizer:forgrtPwdTap];
    
    //注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:CYTHexColor(@"#2cb73f") forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [registerBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#2cb73f")] forState:UIControlStateHighlighted];
    registerBtn.layer.borderWidth = 1.0f;
    registerBtn.layer.borderColor = [UIColor colorWithHexColor:@"#2cb73f"].CGColor;
    registerBtn.layer.cornerRadius = 6;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.titleLabel.font = CYTFontWithPixel(30.f);
    [self addSubview:registerBtn];
    [registerBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(184), CYTAutoLayoutV(54)));
        make.top.equalTo(loginBtn.mas_bottom).offset(CYTAutoLayoutV(100));
        make.centerX.equalTo(self);
    }];
    
    [[registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        appManager.setPwdType = CYTSetPwdTypeSet;
      !self.registerAccount?:self.registerAccount();
    }];

}
/**
 *  绑定viewModel
 */
- (void)bindLoginViewModel{
    RAC(self.loginViewModel,account) = _accountTF.rac_textSignal;
    RAC(self.loginViewModel,pwd) = _pwdTF.rac_textSignal;
}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    [self.accountTF becomeFirstResponder];
}

/**
 *  处理输入框和登录按钮
 */
- (void)handelTextFieldAndLoginBtn{
    //限制账号的输入位数
    [_accountTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTAccountLengthMax) {
            _accountTF.text = [inputString substringToIndex:CYTAccountLengthMax];
        }
    }];
    
    //限制密码的输入位数
    [_pwdTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTPwdLengthMax) {
            _pwdTF.text = [inputString substringToIndex:CYTPwdLengthMax];
        }
    }];
    
    //登录按钮是否可点击
    RAC(_loginBtn,enabled) = self.loginViewModel.loginEnableSiganl;
}


@end
