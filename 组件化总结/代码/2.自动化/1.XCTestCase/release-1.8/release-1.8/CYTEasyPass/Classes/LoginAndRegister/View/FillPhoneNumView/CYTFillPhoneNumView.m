//
//  CYTFillPhoneNumView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFillPhoneNumView.h"
#import "CYTFillPhoneNumViewModel.h"

@interface CYTFillPhoneNumView()

/** 账号输入框 */
@property(weak, nonatomic) UITextField *accountTF;
/** 下一步按钮 */
@property(weak, nonatomic) UIButton *nextStepBtn;
/** 填写手机号逻辑 */
@property(strong, nonatomic) CYTFillPhoneNumViewModel *fillPhoneNumViewModel;

@end

@implementation CYTFillPhoneNumView

- (CYTFillPhoneNumViewModel *)fillPhoneNumViewModel{
    if (!_fillPhoneNumViewModel) {
        _fillPhoneNumViewModel = [[CYTFillPhoneNumViewModel alloc] init];
    }
    return _fillPhoneNumViewModel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillPhoneNumBasicConfig];
        [self initFillPhoneNumComponents];
        [self bindFillPhoneNumViewModel];
        [self handelTextFieldAndNextStepBtn];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)fillPhoneNumBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initFillPhoneNumComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22)+CYTViewOriginY);
    }];
    //账号
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.textColor = CYTHexColor(@"#333333");
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.font = CYTFontWithPixel(30);
    accountLabel.text = @"手机号：";
    [self addSubview:accountLabel];
    
    [accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(topBar.mas_bottom).offset(CYTAutoLayoutV(172));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(34*5), CYTAutoLayoutV(34)));
    }];
    
    //账号输入框
    UITextField *accountTF = [[UITextField alloc] init];
    accountTF.placeholder = @"请输入手机号码";
    accountTF.keyboardType = UIKeyboardTypeNumberPad;
    accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountTF.textColor = CYTHexColor(@"#333333");
    accountTF.font = CYTFontWithPixel(30);
    [self addSubview:accountTF];
    _accountTF = accountTF;
    [accountTF makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLabel.mas_right);
        make.centerY.equalTo(accountLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(self).offset(-CYTMarginH);
    }];
    
    //账号分割线
    UILabel *accountLineLabel = [[UILabel alloc] init];
    accountLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:accountLineLabel];
    [accountLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.left.equalTo(accountLabel);
        make.right.equalTo(accountTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //下一步按钮
    UIButton *nextStepBtn = [UIButton buttonWithTitle:@"下一步" enabled:NO];
    [self addSubview:nextStepBtn];
    _nextStepBtn = nextStepBtn;
    [nextStepBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(accountLineLabel.mas_bottom).offset(CYTAutoLayoutH(58));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    CYTWeakSelf
    [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        nextStepBtn.enabled = NO;
        [[weakSelf.fillPhoneNumViewModel.nextStepCommand execute:nil] subscribeNext:^(CYTRegisterResult *result) {
            nextStepBtn.enabled = YES;
            !self.nextStepClick?:self.nextStepClick(_accountTF.text,result);
        }];
    }];
}

/**
 *  绑定viewModel
 */
- (void)bindFillPhoneNumViewModel{
    RAC(self.fillPhoneNumViewModel,account) = _accountTF.rac_textSignal;
}


/**
 *  处理账号输入框下一步按钮
 */
- (void)handelTextFieldAndNextStepBtn{
    //限制账号的输入位数
    [_accountTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTAccountLengthMax) {
            _accountTF.text = [inputString substringToIndex:CYTAccountLengthMax];
        }
    }];
    
    RAC(_nextStepBtn,enabled) = self.fillPhoneNumViewModel.nextStepEnableSiganl;
}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    if (showKeyboard) {
        [self.accountTF becomeFirstResponder];
    }
    
}


@end
