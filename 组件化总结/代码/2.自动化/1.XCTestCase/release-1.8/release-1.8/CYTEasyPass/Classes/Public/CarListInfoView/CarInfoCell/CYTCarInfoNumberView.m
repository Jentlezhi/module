//
//  CYTCarInfoNumberView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarInfoNumberView.h"

@interface CYTCarInfoNumberView ()

@end

@implementation CYTCarInfoNumberView

#pragma mark- flow control
- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.numberLabel];
    [self addSubview:self.line];
    [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
        make.right.equalTo(-CYTItemMarginH);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.numberLabel);
        make.bottom.equalTo(0);
        make.height.equalTo(kFFLayout_line);
    }];
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
- (void)setNumber:(NSInteger)number {
    _number = number;
    NSString *string = @"成交数量：";
    self.numberLabel.text = [NSString stringWithFormat:@"%@%ld辆",string,number];
}

#pragma mark- get
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _numberLabel.text = @"成交数量：";
    }
    return _numberLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
