//
//  CYTGetCashSetPwdSucceedCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashSetPwdSucceedCtr.h"

@interface CYTGetCashSetPwdSucceedCtr ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *finishedLabel;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation CYTGetCashSetPwdSucceedCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithBackButtonAndTitle:@"设置提款密码"];
    [self loadUI];
}

- (void)backButtonClick:(UIButton *)backButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark-
- (void)loadUI {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.finishedLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(CYTAutoLayoutV(130)+CYTViewOriginY);
    }];
    [self.finishedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(CYTAutoLayoutV(30));
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.finishedLabel.mas_bottom).offset(CYTAutoLayoutV(184));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(330), CYTAutoLayoutV(80)));
    }];
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"me_pwd_finished"];
    }
    return _imageView;
}

- (UILabel *)finishedLabel {
    if (!_finishedLabel) {
        _finishedLabel = [UILabel new];
        _finishedLabel.font = CYTFontWithPixel(34);
        _finishedLabel.textColor = kFFColor_title_L1;
        _finishedLabel.text = @"设置完成";
    }
    return _finishedLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton setBackgroundColor:kFFColor_green];
        [_backButton radius:4 borderWidth:1 borderColor:kFFColor_green];
        _backButton.titleLabel.font = CYTFontWithPixel(34);
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        
        @weakify(self);
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self backButtonClick:nil];
        }];
        
    }
    return _backButton;
}

@end
