//
//  CYTFinishRegisterView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFinishRegisterView.h"

@interface CYTFinishRegisterView()

/** 已注册成功提示文字 */
@property(weak, nonatomic) UILabel *finishRegisterTipLabel;

@end

@implementation CYTFinishRegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self finishRegisterBasicConfig];
        [self initFinishRegisterComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)finishRegisterBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initFinishRegisterComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTViewOriginY);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    //已注册成功提示文字
    UILabel *finishRegisterTipLabel = [[UILabel alloc] init];
    finishRegisterTipLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    finishRegisterTipLabel.textAlignment = NSTextAlignmentCenter;
    finishRegisterTipLabel.numberOfLines = 0;
    finishRegisterTipLabel.font = CYTFontWithPixel(24);
    [self addSubview:finishRegisterTipLabel];
    _finishRegisterTipLabel = finishRegisterTipLabel;
    [finishRegisterTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBar.mas_bottom).offset(CYTAutoLayoutV(114));
        make.height.equalTo(CYTAutoLayoutV(294));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //继续按钮
    UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueBtn setTitle:@"继续" forState:UIControlStateNormal];
    [continueBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
    continueBtn.layer.cornerRadius = 6;
    continueBtn.layer.masksToBounds = YES;
    continueBtn.titleLabel.font = CYTFontWithPixel(38.f);
    [self addSubview:continueBtn];
    [continueBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(finishRegisterTipLabel.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    
    [[continueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.continueOperation?:self.continueOperation();
    }];
    
    //先逛逛按钮
    UIButton *notContinueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notContinueBtn setTitle:@"先逛逛" forState:UIControlStateNormal];
    [notContinueBtn setTitleColor:[UIColor colorWithHexColor:@"#2cb73f"] forState:UIControlStateNormal];
    notContinueBtn.layer.borderWidth = 1.0f;
    notContinueBtn.layer.borderColor = [UIColor colorWithHexColor:@"#2cb73f"].CGColor;
    notContinueBtn.layer.cornerRadius = 6;
    notContinueBtn.layer.masksToBounds = YES;
    notContinueBtn.titleLabel.font = CYTFontWithPixel(38.f);
    [self addSubview:notContinueBtn];
    [notContinueBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(continueBtn.mas_bottom).offset(CYTAutoLayoutV(50));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    
    [[notContinueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.notContinueOperation?:self.notContinueOperation();
    }];
    
}

- (void)setRegisterPhoneNum:(NSString *)registerPhoneNum{
    _registerPhoneNum = registerPhoneNum;
    NSString *partTip = @"成功注册为车销通会员\n请您继续完成资质认证，以便使用车销通功能";
    _finishRegisterTipLabel.text = [NSString stringWithFormat:@"您已经使用手机号%@%@",registerPhoneNum,partTip];
}


@end
