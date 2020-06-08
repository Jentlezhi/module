//
//  CYTCarOrderItemCell_orderNum.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderItemCell_orderNum.h"

@implementation CYTCarOrderItemCell_orderNum

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.vline];
    [self addSubview:self.flagLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.assistantLabel];
    [self addSubview:self.line];
    
    [self.vline makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.centerY.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.width.equalTo(CYTAutoLayoutH(6));
    }];
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.vline.right).offset(CYTAutoLayoutH(14));
    }];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.flagLabel.right).offset(2);
    }];
    [self.assistantLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTItemMarginH);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.equalTo(0);
        make.height.equalTo(0.5);
    }];
}

#pragma mark- get
- (UIView *)vline {
    if (!_vline) {
        _vline = [UIView new];
        _vline.backgroundColor = kFFColor_green;
    }
    return _vline;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _flagLabel.text = @"订单号：";
    }
    return _flagLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
    }
    return _contentLabel;
}

- (UILabel *)assistantLabel {
    if (!_assistantLabel) {
        _assistantLabel = [UILabel labelWithFontPxSize:26 textColor:CYTRedColor];
    }
    return _assistantLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
