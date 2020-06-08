//
//  CYTSetPwdView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSetPwdView.h"
#import "CYTSetPwdViewModel.h"
#import "CYTSetPwdResult.h"
#import "CYTUsersInfoModel.h"

@interface CYTSetPwdView()

/** 密码输入框 */
@property(weak, nonatomic) UITextField *pwdTF;
/** 设置密码逻辑 */
@property(strong, nonatomic) CYTSetPwdViewModel *setPwdViewModel;
/** 下一步按钮 */
@property(weak, nonatomic) UIButton *nextStepBtn;

@end

@implementation CYTSetPwdView

- (CYTSetPwdViewModel *)setPwdViewModel{
    if (!_setPwdViewModel) {
        _setPwdViewModel = [[CYTSetPwdViewModel alloc] init];
    }
    return _setPwdViewModel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setPwdBasicConfig];
        [self initSetPwdComponents];
        [self bindSetPwdViewModel];
        [self handelTextField];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)setPwdBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initSetPwdComponents{
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
    pwdTipLabel.text = @"密码";
    [self addSubview:pwdTipLabel];
    [pwdTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(topBar.mas_bottom).offset(CYTAutoLayoutV(174));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(34*4), pwdTipLabel.font.pointSize));
    }];
    
    //密码输入框
    UITextField *pwdTF = [[UITextField alloc] init];
    pwdTF.placeholder = @"请输入新密码";
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
    UILabel *dividerLineLabel = [[UILabel alloc] init];
    dividerLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:dividerLineLabel];
    [dividerLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdTipLabel);
        make.top.equalTo(pwdTipLabel.mas_bottom).offset(CYTAutoLayoutV(34));
        make.right.equalTo(pwdTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //提示信息
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font = CYTFontWithPixel(22);
    tipLabel.text = @"密码由6-20位英文字母，数字或符号组成";
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(dividerLineLabel.mas_bottom).offset(CYTAutoLayoutV(58));
        make.right.equalTo(dividerLineLabel);
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
        make.right.equalTo(-CYTItemMarginH);
        make.centerY.equalTo(showPwd);
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
    
    [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        nextStepBtn.enabled = NO;
        [[self.setPwdViewModel.nextStepCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
            nextStepBtn.enabled = YES;
            if (responseObject.resultEffective) {
                !self.setPwdNextStep?:self.setPwdNextStep(responseObject);
            }

        }];
    }];
    

}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    if (showKeyboard) {
        [self.pwdTF becomeFirstResponder];
    }
    
}

/**
 *  处理输入框
 */
- (void)handelTextField{
    //限制密码的输入位数
    [_pwdTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTPwdLengthMax) {
            _pwdTF.text = [inputString substringToIndex:CYTPwdLengthMax];
        }
    }];
}

/**
 *  绑定viewModel
 */
- (void)bindSetPwdViewModel{
    RAC(self.setPwdViewModel,pwd) = _pwdTF.rac_textSignal;

    //登录按钮是否可点击
    RAC(_nextStepBtn,enabled) = self.setPwdViewModel.nextStepEnableSiganl;
}




@end
