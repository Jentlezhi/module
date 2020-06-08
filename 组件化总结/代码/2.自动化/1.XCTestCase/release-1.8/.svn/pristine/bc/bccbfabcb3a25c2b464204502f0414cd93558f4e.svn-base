//
//  CYTGetCashAccessCountView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashAccessCountView.h"

@implementation CYTGetCashAccessCountView

- (void)ff_initWithViewModel:(id)viewModel {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.imageView];
    [self addSubview:self.accessCountLabel];
    [self addSubview:self.contentLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTAutoLayoutH(30));
    }];
    [self.accessCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imageView.mas_right).offset(CYTAutoLayoutH(22));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.accessCountLabel.mas_right);
    }];
}

#pragma mark- get

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"me_getCash_icon"];
    }
    return _imageView;
}

- (UILabel *)accessCountLabel {
    if (!_accessCountLabel) {
        _accessCountLabel = [UILabel new];
        _accessCountLabel.font = CYTFontWithPixel(26);
        _accessCountLabel.textColor = kFFColor_title_L3;
        _accessCountLabel.text = @"可提现金额:";
    }
    return _accessCountLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = CYTFontWithPixel(26);
        _contentLabel.textColor = kFFColor_title_L3;
    }
    return _contentLabel;
}

@end
