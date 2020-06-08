//
//  CYTAboutUsViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAboutUsViewController.h"

#define kCopyrightString    (@"Copyright © 2017 BITAUTO (Xi'an) Information Technology Co., Ltd. All rights Reserved")

@interface CYTAboutUsViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *copyrightLabel;

@end

@implementation CYTAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithBackButtonAndTitle:@"关于"];
    [self loadUI];
    [self loadData];
}

- (void)loadUI {
    self.view.backgroundColor = kFFColor_bg_nor;
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.copyrightLabel];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(CYTAutoLayoutV(180)+CYTViewOriginY);
    }];
    [self.versionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.bottom).offset(CYTAutoLayoutV(60));
    }];
    [self.copyrightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(-CYTAutoLayoutV(60));
        make.left.equalTo(CYTAutoLayoutH(90));
        make.right.equalTo(CYTAutoLayoutH(-90));
    }];
}

- (void)loadData {
    self.copyrightLabel.text = kCopyrightString;
    
    NSMutableString *ver = [NSMutableString stringWithFormat:@"V%@",kFF_APP_VERSION];
    NSString *version = [NSString stringWithFormat:@"%@ for iOS",ver];
    self.versionLabel.text = version;
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"setting_chexiaotong"];
    }
    return _imageView;
}

- (UILabel *)versionLabel {
    if (!_versionLabel) {
        _versionLabel = [UILabel labelWithFontPxSize:32 textColor:UIColorFromRGB(0xa5a5a5)];
    }
    return _versionLabel;
}

- (UILabel *)copyrightLabel {
    if (!_copyrightLabel) {
        _copyrightLabel = [UILabel labelWithFontPxSize:26 textColor:UIColorFromRGB(0xa5a5a5)];
        _copyrightLabel.numberOfLines = 0;
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _copyrightLabel;
}

@end
