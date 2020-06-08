//
//  CYTDealerNavView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerNavView.h"

@implementation CYTDealerNavView

- (void)ff_addSubViewAndConstraints {
    self.layer.shadowOffset = CGSizeMake(0, 0.2);
    self.layer.shadowOpacity = 0.2;
    
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
    
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(-CYTAutoLayoutH(10));
        make.top.equalTo(CYTStatusBarHeight);
        make.width.height.equalTo(44);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTStatusBarHeight);
        make.centerX.equalTo(self);
        make.height.equalTo(44);
        
    }];
}

- (void)updateViewWithOffset:(float)offset {

    float alp = (offset*1.0/44);
    alp = (alp>0.98)?0.98:alp;
    UIColor *backColor = kFFColor_title_L3;
    UIColor *titleColor = kFFColor_title_L1;
    if (offset<=0) {
        backColor = [UIColor whiteColor];
        titleColor = [UIColor clearColor];
    }
    
    UIImage *image = [UIImage imageNamed:@"dealer_hom_back"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.backButton.imageView.image = image;
    self.backButton.imageView.tintColor = backColor;
    self.titleLabel.textColor = titleColor;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:alp];
}

- (void)updateViewWithDefault {
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = kFFColor_title_L1;
    UIImage *image = [UIImage imageNamed:@"dealer_hom_back"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.backButton.imageView.image = image;
    self.backButton.imageView.tintColor = kFFColor_title_L3;
}

#pragma mark- get
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"dealer_hom_back"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            if (self.backBlock) {
                self.backBlock();
            }

        }];
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:34 textColor:kFFColor_title_L1];
        _titleLabel.text = @"主页";
        _titleLabel.textColor = [UIColor clearColor];
    }
    return _titleLabel;
}

@end
