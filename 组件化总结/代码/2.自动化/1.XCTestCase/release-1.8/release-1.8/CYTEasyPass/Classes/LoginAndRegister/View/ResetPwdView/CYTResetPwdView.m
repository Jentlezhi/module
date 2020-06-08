//
//  CYTResetPwdView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTResetPwdView.h"
#import "CYTResetPwdViewModel.h"
#import "CYTResetPwdResult.h"

@interface CYTResetPwdView()

/** 密码输入框 */
@property(weak, nonatomic) UITextField *pwdTF;
/** 确认密码输入框 */
@property(weak, nonatomic) UITextField *confirmPwdTF;
/** 重置密码逻辑 */
@property(strong, nonatomic) CYTResetPwdViewModel *resetPwdViewModel;
/** 下一步按钮 */
@property(weak, nonatomic) UIButton *nextStepBtn;


@end

@implementation CYTResetPwdView

- (CYTResetPwdViewModel *)resetPwdViewModel{
    if (!_resetPwdViewModel) {
        _resetPwdViewModel = [[CYTResetPwdViewModel alloc] init];
    }
    return _resetPwdViewModel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self resetPwdBasicConfig];
        [self initResetPwdComponents];
        [self bindResetPwdViewModel];
        [self handelTextField];
    }
    return  self;
}

/**
 *  基本配置
 */
- (void)resetPwdBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initResetPwdComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTViewOriginY);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    
    //密码
    UILabel *pwdTipLabel = [[UILabel alloc] init];
    pwdTipLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    pwdTipLabel.textAlignment = NSTextAlignmentLeft;
    pwdTipLabel.font = CYTFontWithPixel(30);
    pwdTipLabel.text = @"请输入密码";
    [self addSubview:pwdTipLabel];
    [pwdTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(topBar.mas_bottom).offset(CYTAutoLayoutV(174));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(34*6), CYTAutoLayoutV(34)));
    }];
    
    //密码输入框
    UITextField *pwdTF = [[UITextField alloc] init];
    pwdTF.placeholder = @"输入新密码";
    pwdTF.keyboardType = UIKeyboardTypeASCIICapable;
    pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    pwdTF.secureTextEntry = YES;
    //    codeTF.tintColor = CYTGrayColor(51);
    pwdTF.textColor = [UIColor colorWithHexColor:@"#999999"];
    pwdTF.font = CYTFontWithPixel(30);
    [self addSubview:pwdTF];
    _pwdTF = pwdTF;
    [pwdTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdTipLabel.mas_right);
        make.centerY.equalTo(pwdTipLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(self).offset(-CYTMarginH);
    }];
    
    //分割线
    UILabel *upLineLabel = [[UILabel alloc] init];
    upLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:upLineLabel];
    [upLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdTipLabel);
        make.top.equalTo(pwdTipLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.right.equalTo(pwdTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //再次输入密码
    UILabel *confirmPwdTipLabel = [[UILabel alloc] init];
    confirmPwdTipLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    confirmPwdTipLabel.textAlignment = NSTextAlignmentLeft;
    confirmPwdTipLabel.font = CYTFontWithPixel(30);
    confirmPwdTipLabel.text = @"确认新密码";
    [self addSubview:confirmPwdTipLabel];
    [confirmPwdTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdTipLabel);
        make.top.equalTo(upLineLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(34*6), CYTAutoLayoutV(34)));
    }];
    
    //再次输入密码输入框
    UITextField *confirmPwdTF = [[UITextField alloc] init];
    confirmPwdTF.placeholder = @"确认新密码";
    confirmPwdTF.keyboardType = UIKeyboardTypeASCIICapable;
    confirmPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    confirmPwdTF.secureTextEntry = YES;
    //    codeTF.tintColor = CYTGrayColor(51);
    confirmPwdTF.textColor = [UIColor colorWithHexColor:@"#999999"];
    confirmPwdTF.font = CYTFontWithPixel(30);
    [self addSubview:confirmPwdTF];
    _confirmPwdTF = confirmPwdTF;
    [confirmPwdTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(confirmPwdTipLabel.mas_right);
        make.centerY.equalTo(confirmPwdTipLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(pwdTF);
    }];
    
    //分割线
    UILabel *downLineLabel = [[UILabel alloc] init];
    downLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:downLineLabel];
    [downLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(confirmPwdTipLabel);
        make.top.equalTo(confirmPwdTipLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.right.equalTo(confirmPwdTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //提示信息
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font = CYTFontWithPixel(22);
    tipLabel.text = @"密码由6-20位英文字母或数字组成";
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(downLineLabel.mas_bottom).offset(CYTAutoLayoutV(30));
        make.right.equalTo(downLineLabel);
        make.height.equalTo(tipLabel.font.pointSize);
    }];
    
    //显示密码
    UIView *showPwd = [[UIView alloc] init];
    [self addSubview:showPwd];
    [showPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(tipLabel.mas_bottom).offset(CYTAutoLayoutV(20));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(50)));
    }];
    //@"look_h_":@"look_";
    UIImageView *showIcon = [[UIImageView alloc] init];
    NSString *showIconName = @"look_";
    showIcon.image = [UIImage imageNamed:showIconName];
    showIcon.userInteractionEnabled = YES;
    [showPwd addSubview:showIcon];
    [showIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showPwd);
        make.centerY.equalTo(showPwd);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(40), CYTAutoLayoutV(40)));
    }];
    
    UITapGestureRecognizer *hiddenPwdTap = [[UITapGestureRecognizer alloc] init];
    [[hiddenPwdTap rac_gestureSignal] subscribeNext:^(id x) {
        self.pwdTF.secureTextEntry = !self.pwdTF.secureTextEntry;
        self.confirmPwdTF.secureTextEntry = !self.confirmPwdTF.secureTextEntry;
        NSString *hiddenImage = self.pwdTF.secureTextEntry?@"look_h_":@"look_";
        showIcon.image = [UIImage imageNamed:hiddenImage];
        extern NSString *CYTKeyboardSwitchNot;
        [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(self.pwdTF.secureTextEntry)];
    }];
    [showIcon addGestureRecognizer:hiddenPwdTap];
    
    UILabel *showPwdLabel = [[UILabel alloc] init];
    showPwdLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    showPwdLabel.textAlignment = NSTextAlignmentLeft;
    showPwdLabel.font = CYTFontWithPixel(22);
    showPwdLabel.text = @"显示密码";
    [showPwd addSubview:showPwdLabel];
    [showPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showIcon.mas_right).offset(CYTAutoLayoutH(10));
        make.centerY.equalTo(showPwd);
        make.right.equalTo(downLineLabel);
    }];
    
    //下一步按钮
    UIButton *nextStepBtn = [UIButton buttonWithTitle:@"下一步" enabled:NO];
    [self addSubview:nextStepBtn];
    _nextStepBtn = nextStepBtn;
    [nextStepBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(showPwd.mas_bottom).offset(CYTAutoLayoutV(90));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    CYTWeakSelf
    [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id result) {
        nextStepBtn.enabled = NO;
        [[weakSelf.resetPwdViewModel.nextStepCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
            nextStepBtn.enabled = YES;
            if (responseObject.resultEffective) {
                !weakSelf.resetPwdNextStep?:weakSelf.resetPwdNextStep(responseObject);
            }
        }];
    }];

}

/**
 *  绑定viewModel
 */
- (void)bindResetPwdViewModel{
    RAC(self.resetPwdViewModel,firstPwd) = _pwdTF.rac_textSignal;
    RAC(self.resetPwdViewModel,secondPwd) = _confirmPwdTF.rac_textSignal;
}

/**
 *  处理输入框和登录按钮
 */
- (void)handelTextField{
    //限制密码的输入位数
    [_pwdTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTPwdLengthMax) {
            _pwdTF.text = [inputString substringToIndex:CYTPwdLengthMax];
        }
    }];

    [_confirmPwdTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTPwdLengthMax) {
            _confirmPwdTF.text = [inputString substringToIndex:CYTPwdLengthMax];
        }
    }];
    
    RAC(_nextStepBtn,enabled) = self.resetPwdViewModel.nextStepEnableSiganl;
}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    [self.pwdTF becomeFirstResponder];
}


@end
