//
//  CYTGetCashCountView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashCountView.h"

@implementation CYTGetCashCountView

- (void)ff_initWithViewModel:(id)viewModel {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleLabel];
    [self addSubview:self.symbolLabel];
    [self addSubview:self.textFiled];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.top.equalTo(CYTAutoLayoutV(36));
    }];
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(-CYTAutoLayoutV(36));
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.right.equalTo(-50);
        make.bottom.equalTo(-14);
    }];
}

#pragma mark- get
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = CYTFontWithPixel(26);
        _titleLabel.textColor = kFFColor_title_L1;
        _titleLabel.text = @"提现金额:";
    }
    return _titleLabel;
}

- (UILabel *)symbolLabel {
    if (!_symbolLabel) {
        _symbolLabel = [UILabel new];
        _symbolLabel.font = CYTFontWithPixel(30);
        _symbolLabel.textColor = kFFColor_green;
        _symbolLabel.text = @"￥";
    }
    return _symbolLabel;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.font = CYTFontWithPixel(70);
        _textFiled.textColor = kFFColor_green;
        _textFiled.placeholder = @"1~10000";
        _textFiled.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _textFiled;
}

@end
