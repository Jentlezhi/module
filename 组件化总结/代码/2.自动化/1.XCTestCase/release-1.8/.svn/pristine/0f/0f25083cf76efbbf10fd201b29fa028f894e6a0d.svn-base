//
//  CYTFinishResetPwdViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTFinishResetPwdViewController.h"

@interface CYTFinishResetPwdViewController ()

@end

@implementation CYTFinishResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self finishResetPwdBasicConfig];
    [self initFinishResetPwdmComponents];
}

/**
 *  基本配置
 */
- (void)finishResetPwdBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"重置完成"];
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initFinishResetPwdmComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.view addSubview:topBar];
    [topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(CYTViewOriginY);
        make.left.right.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];

    //提示信息
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = CYTHexColor(@"#333333");
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = CYTFontWithPixel(24);
    tipLabel.text = [NSString stringWithFormat:@"您已经使用手机号%@重置成功",self.registerPhoneNum];
    [self.view addSubview:tipLabel];
    
    [tipLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topBar.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(292));
    }];
    
    //返回首页按钮
    UIButton *backToHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backToHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backToHomeBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
    backToHomeBtn.layer.cornerRadius = 6;
    backToHomeBtn.layer.masksToBounds = YES;
    backToHomeBtn.titleLabel.font = CYTFontWithPixel(38.f);
    [self.view addSubview:backToHomeBtn];
    [backToHomeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTMarginH);
        make.right.equalTo(self.view).offset(-CYTMarginH);
        make.top.equalTo(tipLabel.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    
    [[backToHomeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id result) {
        [kAppdelegate goHomeView];
    }];
}


@end
