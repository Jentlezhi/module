//
//  CYTUnbindView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUnbindView.h"
#import "CYTRegisterViewModel.h"

@interface CYTUnbindView()<TTTAttributedLabelDelegate,UIGestureRecognizerDelegate>

/** 账号输入框 */
@property(weak, nonatomic) UITextField *accountTF;
/** 下一步按钮 */
@property(weak, nonatomic) UIButton *nextStepBtn;
/** 是否同意协议 */
@property(assign, nonatomic,getter=isAgreeProtocal) BOOL agreeProtocal;
/** 登录逻辑 */
@property(strong, nonatomic) CYTRegisterViewModel *registerViewModel;

@end

@implementation CYTUnbindView

- (CYTRegisterViewModel *)registerViewModel{
    if (!_registerViewModel) {
        _registerViewModel = [[CYTRegisterViewModel alloc] init];
    }
    return _registerViewModel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self unbindViewBasicConfig];
        [self initUnbindViewComponents];
        [self bindRegisterViewModel];
        [self handelTextFieldAndNextStepBtn];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)unbindViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.agreeProtocal = YES;
}

/**
 *  初始化子控件
 */
- (void)initUnbindViewComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    //账号
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.textColor = CYTHexColor(@"#333333");
    accountLabel.textAlignment = NSTextAlignmentLeft;
    accountLabel.font = CYTFontWithPixel(30);
    accountLabel.text = @"手机号";
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
    
    [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        nextStepBtn.enabled = NO;
        [[self.registerViewModel.nextStepCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
            nextStepBtn.enabled = YES;
            if (!responseObject.resultEffective && responseObject.errorCode != 3000001) {
                [CYTToast errorToastWithMessage:responseObject.resultMessage];
                return;
            }
            //ErrorCode:3000001代表手机号已注册，其余为0
            CYTUserStatus userStatus = CYTUserStatusUnRegister;
            if (responseObject.errorCode == 3000001) {
                userStatus = CYTUserStatusRegister;
            }
            !self.nextStepClick?:self.nextStepClick(userStatus,accountTF.text);
        }];
    }];
    //用户协议
    UIImageView *protocalIcon = [[UIImageView alloc] init];
    __block NSString *currentSelectIcon = @"m_select_";
    protocalIcon.image = [UIImage imageNamed:currentSelectIcon];
    [self addSubview:protocalIcon];
    [protocalIcon makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).equalTo(CYTDefaultMarigin);
        make.top.equalTo(nextStepBtn.mas_bottom).offset(CYTAutoLayoutH(58));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(30), CYTAutoLayoutV(30)));
    }];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:protocolBtn];
    [protocolBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(protocalIcon);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(45), CYTAutoLayoutV(45)));
    }];
    [[protocolBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([currentSelectIcon isEqualToString:@"m_seleectable_"]) {
            currentSelectIcon = @"m_select_";
        }else{
            currentSelectIcon = @"m_seleectable_";
        }
        protocalIcon.image = [UIImage imageNamed:currentSelectIcon];
        self.agreeProtocal = [currentSelectIcon isEqualToString:@"m_select_"];
    }];
    
    //协议声明
    TTTAttributedLabel *protocolLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    protocolLabel.delegate = self;
    protocolLabel.textColor = CYTHexColor(@"#3333333");
    protocolLabel.font = CYTFontWithPixel(24);
    protocolLabel.numberOfLines = 0;
    NSString *content = @"已阅读并同意以下《车销通用户注册协议》，接受免除或限制责任、诉讼管辖约定，愿意创建车销通账户。";
    protocolLabel.text = content;
    NSString *keyword = @"《车销通用户注册协议》";
    protocolLabel.activeLinkAttributes = [NSDictionary dictionaryWithObject:CYTGreenNormalColor forKey:(NSString *)kCTForegroundColorAttributeName];
    [protocolLabel setText:content afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:keyword options:NSCaseInsensitiveSearch];
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:CYTAutoLayoutV(24)];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[CYTGreenNormalColor CGColor] range:boldRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
    [linkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    [linkAttributes setValue:(__bridge id)CYTGreenNormalColor.CGColor forKey:(NSString *)kCTForegroundColorAttributeName];
    protocolLabel.linkAttributes = linkAttributes;
    NSRange linkRange = [content rangeOfString:keyword];
    NSURL *url = [NSURL URLWithString:@""];
    [protocolLabel addLinkToURL:url withRange:linkRange];
    
    [self addSubview:protocolLabel];
    
    [protocolLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(protocalIcon.mas_right).offset(CYTAutoLayoutH(10));
        make.top.equalTo(nextStepBtn.mas_bottom).offset(CYTAutoLayoutH(58));
        make.right.equalTo(nextStepBtn);
    }];

}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    if (showKeyboard) {
        [self.accountTF becomeFirstResponder];
    }
    
}

- (void)setAgreeProtocal:(BOOL)agreeProtocal{
    _agreeProtocal = agreeProtocal;
    //下一步按钮是否可点击
    [self.registerViewModel setValue:[NSNumber numberWithBool:self.isAgreeProtocal] forKeyPath:@"agreeProtocal"];
}

/**
 *  绑定viewModel
 */
- (void)bindRegisterViewModel{
    RAC(self.registerViewModel,account) = _accountTF.rac_textSignal;
}


/**
 *  处理输入框和下一步按钮
 */
- (void)handelTextFieldAndNextStepBtn{
    //限制账号的输入位数
    [_accountTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTAccountLengthMax) {
            _accountTF.text = [inputString substringToIndex:CYTAccountLengthMax];
        }
    }];
    
    RAC(_nextStepBtn,enabled) = self.registerViewModel.nextStepEnableSiganl;
}

#pragma mark - <TTTAttributedLabelDelegate>

- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
   !self.userProtocolClick?:self.userProtocolClick();
}

- (void)setRegisterPhoneNum:(NSString *)registerPhoneNum{
    _registerPhoneNum = registerPhoneNum;
    _accountTF.text = registerPhoneNum;
    _nextStepBtn.enabled = registerPhoneNum.length;
}


@end
