//
//  CYTGetCashNextView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashNextView.h"

@implementation CYTGetCashNextView

- (void)ff_initWithViewModel:(id)viewModel {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleLabel];
    [self addSubview:self.textFiled];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTMarginH);
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTMarginH);
        make.left.equalTo(self.titleLabel.mas_right);
    }];
}

#pragma mark- get
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = CYTFontWithPixel(30);
        _titleLabel.textColor = kFFColor_title_L1;
    }
    return _titleLabel;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.font = CYTFontWithPixel(28);
        _textFiled.textColor = kFFColor_title_L1;
        _textFiled.keyboardType = UIKeyboardTypeDecimalPad;
        _textFiled.textAlignment = NSTextAlignmentRight;
    }
    return _textFiled;
}

@end
