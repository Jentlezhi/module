//
//  CYTFillCodeView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFillCodeView.h"
#import "CYTFillCodeViewModel.h"
#import "CYTFillCodeResult.h"
#import "CYTVerifyCodeResult.h"

#define CYTGetCodeWatingMsg @"%lds后可重发"

@interface CYTFillCodeView()

/** 提示信息 */
@property(weak, nonatomic) UIView *tipNotView;
/** 验证码输入框 */
@property(weak, nonatomic) UITextField *codeTF;
/** 获取验证码 */
@property(weak, nonatomic) UIButton *getCodeBtn;
/** 倒计时 */
@property(strong, nonatomic) NSTimer *timer;
/** 验证时间 */
@property(assign, nonatomic) NSInteger seconds;
/** 注册手机号 */
@property(weak, nonatomic) UILabel *registerPhoneNumLabel;
/** 获取验证码逻辑 */
@property(strong, nonatomic) CYTFillCodeViewModel *fillCodeViewModel;
/** 验证码输入框 */
@property(weak, nonatomic) UITextField *otherPhoneTF;
/** 下一步按钮 */
@property(weak, nonatomic) UIButton *nextStepBtn;

@end

@implementation CYTFillCodeView
{
    //验证码： 提示
    UILabel *_codeInputTipLabel;
}

- (CYTFillCodeViewModel *)fillCodeViewModel{
    if (!_fillCodeViewModel) {
        _fillCodeViewModel = [[CYTFillCodeViewModel alloc] init];
    }
    return _fillCodeViewModel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCodeBasicConfig];
        [self initFillCodeComponents];
        [self bindFillCodeViewModel];
        [self handelTextFieldAndNextStepBtn];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)fillCodeBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    
    //获取验证码
    [self getPhoneCode];
}

/**
 *  初始化子控件
 */
- (void)initFillCodeComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    //提示信息
    UIView *tipNotView = [[UIView alloc] init];
    [self addSubview:tipNotView];
    _tipNotView = tipNotView;
    [tipNotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBar.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(290));
    }];
    //已发送验证码提示文字
    UILabel *codeTipLabel = [[UILabel alloc] init];
    codeTipLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    codeTipLabel.textAlignment = NSTextAlignmentCenter;
    codeTipLabel.font = CYTFontWithPixel(24);
    codeTipLabel.text = @"我们已经发送了验证码到您的手机：";
    [tipNotView addSubview:codeTipLabel];
    [codeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipNotView).offset(CYTAutoLayoutV(112));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //注册手机号
    UILabel *registerPhoneNumLabel = [[UILabel alloc] init];
    registerPhoneNumLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    registerPhoneNumLabel.textAlignment = NSTextAlignmentCenter;
    registerPhoneNumLabel.font = CYTFontWithPixel(30);
    [tipNotView addSubview:registerPhoneNumLabel];
    _registerPhoneNumLabel = registerPhoneNumLabel;
    [registerPhoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeTipLabel.mas_bottom).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //验证码输入区域
    UIView *codeInputAreaView = [[UIView alloc] init];
    codeInputAreaView.backgroundColor = [UIColor clearColor];
    [self addSubview:codeInputAreaView];
    [codeInputAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipNotView.mas_bottom);
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(100));
    }];
    
    //分割线
    UILabel *codeInputUpLineLabel = [[UILabel alloc] init];
    codeInputUpLineLabel.backgroundColor = CYTHexColor(@"#efefef");
    [codeInputAreaView addSubview:codeInputUpLineLabel];
    [codeInputUpLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(codeInputAreaView);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    UILabel *codeInputDownLineLabel = [[UILabel alloc] init];
    codeInputDownLineLabel.backgroundColor = CYTHexColor(@"#efefef");
    [codeInputAreaView addSubview:codeInputDownLineLabel];
    [codeInputDownLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(codeInputAreaView);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    UILabel *codeInputCenterLineLabel = [[UILabel alloc] init];
    codeInputCenterLineLabel.backgroundColor = CYTHexColor(@"#efefef");
    [codeInputAreaView addSubview:codeInputCenterLineLabel];
    [codeInputCenterLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeInputUpLineLabel);
        make.bottom.equalTo(codeInputDownLineLabel);
        make.right.equalTo(codeInputAreaView).offset(-CYTAutoLayoutH(210));
        make.width.equalTo(CYTDividerLineWH);
    }];
    
    //验证码： 提示
    UILabel *codeInputTipLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    [codeInputAreaView addSubview:codeInputTipLabel];
    _codeInputTipLabel = codeInputTipLabel;
    [codeInputTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(codeInputAreaView);
    }];
    //验证码输入框
    UITextField *codeTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#999999") fontPixel:30 textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeNumberPad clearButtonMode:UITextFieldViewModeWhileEditing placeholder:@"请输入验证码"];
    codeTF.backgroundColor  = [UIColor clearColor];
    [codeInputAreaView addSubview:codeTF];
    _codeTF = codeTF;
    [codeTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.height.equalTo(codeInputAreaView);
        make.right.equalTo(codeInputCenterLineLabel);
    }];
    
    //获取验证码按钮
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeBtn setEnabled:NO];
    [getCodeBtn setTitle:@"60s后可重发" forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = CYTFontWithPixel(30);
    [getCodeBtn setTitleColor:CYTHexColor(@"#2cb73f") forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:CYTBtnDisableColor forState:UIControlStateDisabled];
    CYTWeakSelf
    [[getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self getPhoneCode];
    }];
    [codeInputAreaView addSubview:getCodeBtn];
    _getCodeBtn = getCodeBtn;
    [getCodeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeInputCenterLineLabel.mas_right);
        make.right.equalTo(codeInputAreaView);
        make.height.equalTo(codeTF.font.pointSize);
        make.centerY.equalTo(codeInputAreaView);
    }];
    
    //邀请人手机号输入区域
    UIView *otherPhoneInputAreaView = [[UIView alloc] init];
    otherPhoneInputAreaView.backgroundColor = [UIColor clearColor];
    [self addSubview:otherPhoneInputAreaView];
    [otherPhoneInputAreaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeInputAreaView.mas_bottom);
        make.left.right.equalTo(codeInputAreaView);
        make.height.equalTo(CYTAutoLayoutV(100));
    }];
    
    //邀请人手机号输入框
    UITextField *otherPhoneTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#999999") fontPixel:30 textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeNumberPad clearButtonMode:UITextFieldViewModeWhileEditing placeholder:@"请输入邀请人手机号（非必填）"];
    [otherPhoneInputAreaView addSubview:otherPhoneTF];
    _otherPhoneTF = otherPhoneTF;
    [otherPhoneTF makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    UILabel *otherPhonetDownLineLabel = [[UILabel alloc] init];
    otherPhonetDownLineLabel.backgroundColor = CYTHexColor(@"#efefef");
    [otherPhoneInputAreaView addSubview:otherPhonetDownLineLabel];
    [otherPhonetDownLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(otherPhoneInputAreaView);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    CYTAppManager *appManager = [CYTAppManager sharedAppManager];
    otherPhoneInputAreaView.hidden = appManager.setPwdType==CYTSetPwdTypeReset;
    
    //下一步按钮
    UIButton *nextStepBtn = [UIButton buttonWithTitle:@"下一步" enabled:NO];
    [self addSubview:nextStepBtn];
    _nextStepBtn = nextStepBtn;
    [nextStepBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        if (appManager.setPwdType==CYTSetPwdTypeReset) {
            make.top.equalTo(codeInputAreaView.mas_bottom).offset(CYTAutoLayoutV(60));
        }else{
            make.top.equalTo(otherPhoneInputAreaView.mas_bottom).offset(CYTAutoLayoutV(60));
        }
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    
    [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        nextStepBtn.enabled = NO;
        [[weakSelf.fillCodeViewModel.verifyCodeCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
            nextStepBtn.enabled = YES;
            if (responseObject.resultEffective) {
                !self.fillCodeNextStep?:self.fillCodeNextStep();
            }
            
        }];
    }];
}
/**
 *  获取手机验证码
 */
- (void)getPhoneCode{
    CYTWeakSelf
    //调起键盘
    [_codeTF becomeFirstResponder];
    //倒计时
    self.seconds = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    //发起命令
    [[weakSelf.fillCodeViewModel.getCodeCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
#ifdef DEBUG
        [self debugGetCode];

#endif
    }];

}

- (void)debugGetCode{
    //模拟获取验证码操作
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    CYTAppManager *appManager = [CYTAppManager sharedAppManager];
    if (appManager.setPwdType == CYTSetPwdTypeReset) {
        [par setValue:[NSNumber numberWithInt:2] forKey:@"sendType"];
    }else{
        [par setValue:[NSNumber numberWithInt:1] forKey:@"sendType"];
    }
    [par setValue:self.registerPhoneNum forKey:@"telPhone"];
    [CYTNetworkManager POST:@"http://dev.oldapi.biz/account/getTelCode" parameters:par.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [responseObject.responseObject valueForKey:@"Data"];
        CYTLog(@"**验证码** = %@",[CYTCommonTool jsonStringWithDict:responseObject.responseObject]);
    }];
}

- (void)setRegisterPhoneNum:(NSString *)registerPhoneNum{
    _registerPhoneNum = registerPhoneNum;
    _registerPhoneNumLabel.text = registerPhoneNum;
}

/**
 *  绑定viewModel
 */
- (void)bindFillCodeViewModel{
    RAC(self.fillCodeViewModel,code) = _codeTF.rac_textSignal;
    RAC(self.fillCodeViewModel,otherPhoneNum) = _otherPhoneTF.rac_textSignal;
    self.fillCodeViewModel.account = self.registerPhoneNum;
}


/**
 *  定时器计时
 */
-(void)timerFireMethod:(NSTimer *)theTimer {
    if (_seconds == 1) {
        [theTimer invalidate];
        self.seconds  = 60;
        [_getCodeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
        [_getCodeBtn setEnabled:YES];
    }else{
        NSString *title = [NSString stringWithFormat:CYTGetCodeWatingMsg,(long)_seconds--];
        [_getCodeBtn setEnabled:NO];
        [_getCodeBtn setTitle:title forState:UIControlStateNormal];
    }
}

/**
 *  停止验证码的倒数
 */
- (void)releaseTimer {
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]) {
            if ([_timer isValid]) {
                [_timer invalidate];
                _seconds = 60;
            }
        }
    }
}

/**
 *  处理输入框和下一步按钮
 */
- (void)handelTextFieldAndNextStepBtn{
    //限制验证码的输入位数
    [_codeTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTCodeLengthMax) {
            _codeTF.text = [inputString substringToIndex:CYTCodeLengthMax];
        }
    }];
    
    [_otherPhoneTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTAccountLengthMax) {
            _otherPhoneTF.text = [inputString substringToIndex:CYTAccountLengthMax];
        }
    }];
    
    //下一步按钮是否可点击
    RAC(_nextStepBtn,enabled) = self.fillCodeViewModel.nextStepEnableSignal;
}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    if (showKeyboard) {
        [_codeTF becomeFirstResponder];
    };
    
}



@end
