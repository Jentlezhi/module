//
//  CYTBindView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBindView.h"

@interface CYTBindView()

/** 手机号已注册提示 */
@property(weak, nonatomic) UILabel *registerTipLabel;

@end

@implementation CYTBindView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self bindViewBasicConfig];
        [self initBindViewComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)bindViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initBindViewComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    //手机号已注册提示
    UILabel *registerTipLabel = [[UILabel alloc] init];
    registerTipLabel.textColor = CYTHexColor(@"#666666");
    registerTipLabel.textAlignment = NSTextAlignmentCenter;
    registerTipLabel.numberOfLines = 0;
    registerTipLabel.font = CYTFontWithPixel(24);
    [self addSubview:registerTipLabel];
    _registerTipLabel = registerTipLabel;
    [registerTipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBar);
        make.height.equalTo(CYTAutoLayoutV(292));
        make.centerX.equalTo(topBar);
    }];
    
    
    //返回登录按钮
    UIButton *backToLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backToLoginBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    [backToLoginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
    backToLoginBtn.layer.cornerRadius = 6;
    backToLoginBtn.layer.masksToBounds = YES;
    backToLoginBtn.titleLabel.font = CYTFontWithPixel(38.f);
    [self addSubview:backToLoginBtn];
    [backToLoginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(registerTipLabel.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    
    [[backToLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.backToLogin?:self.backToLogin(self.registerPhoneNum);
    }];
    
    //找回密码按钮
    UIButton *findPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [findPwdBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPwdBtn setTitleColor:CYTHexColor(@"#2cb73f") forState:UIControlStateNormal];
    [findPwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [findPwdBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#2cb73f")] forState:UIControlStateHighlighted];
    findPwdBtn.layer.borderWidth = 1.0f;
    findPwdBtn.layer.borderColor = [UIColor colorWithHexColor:@"#2cb73f"].CGColor;
    findPwdBtn.layer.cornerRadius = 6;
    findPwdBtn.layer.masksToBounds = YES;
    findPwdBtn.titleLabel.font = CYTFontWithPixel(30.f);
    [self addSubview:findPwdBtn];
    [findPwdBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(backToLoginBtn);;
        make.top.equalTo(backToLoginBtn.mas_bottom).offset(CYTAutoLayoutV(58));
    }];
    
    [[findPwdBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //设置请求类型
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        appManager.setPwdType = CYTSetPwdTypeReset;
        !self.findPwd?:self.findPwd();
    }];
    
    //使用其他手机号注册
    UIButton *useOtherLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [useOtherLoginBtn setTitle:@"使用其他手机号码注册" forState:UIControlStateNormal];
    [useOtherLoginBtn setTitleColor:CYTHexColor(@"#2cb73f") forState:UIControlStateNormal];
    [useOtherLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [useOtherLoginBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#2cb73f")] forState:UIControlStateHighlighted];
    useOtherLoginBtn.layer.borderWidth = 1.0f;
    useOtherLoginBtn.layer.borderColor = [UIColor colorWithHexColor:@"#2cb73f"].CGColor;
    useOtherLoginBtn.layer.cornerRadius = 6;
    useOtherLoginBtn.layer.masksToBounds = YES;
    useOtherLoginBtn.titleLabel.font = CYTFontWithPixel(30.f);
    [self addSubview:useOtherLoginBtn];
    [useOtherLoginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(findPwdBtn);;
        make.top.equalTo(findPwdBtn.mas_bottom).offset(CYTAutoLayoutV(58));
    }];
    
    [[useOtherLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.useOtherLogin?:self.useOtherLogin();
    }];

    
}

- (void)setRegisterPhoneNum:(NSString *)registerPhoneNum{
    _registerPhoneNum = registerPhoneNum;
    NSString *partContent = @"已注册\n你可以使用此手机号直接登录";
    _registerTipLabel.text = [NSString stringWithFormat:@"手机号：%@%@",registerPhoneNum,partContent];
}

@end
