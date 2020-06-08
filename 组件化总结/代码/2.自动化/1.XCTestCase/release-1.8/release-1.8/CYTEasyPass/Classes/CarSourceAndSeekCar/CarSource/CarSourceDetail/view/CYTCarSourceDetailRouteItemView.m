//
//  CYTCarSourceDetailRouteItemView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailRouteItemView.h"

@interface CYTCarSourceDetailRouteItemView ()

@end

@implementation CYTCarSourceDetailRouteItemView

#pragma mark- flow control
- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.startLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.endLabel];
    [self addSubview:self.borderView];
    [self addSubview:self.line];
    
    [self.startLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginV);
        make.left.greaterThanOrEqualTo(2);
    }];
    [self.arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(self.startLabel);
        make.left.equalTo(self.startLabel.right).offset(2);
        make.right.equalTo(self.endLabel.left).offset(-2);
    }];
    [self.endLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startLabel);
        make.right.lessThanOrEqualTo(-2);
    }];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startLabel.bottom).offset(CYTItemMarginV);
        make.bottom.equalTo(-CYTMarginV);
        make.centerX.equalTo(self);
        make.left.greaterThanOrEqualTo(0);
        make.right.lessThanOrEqualTo(0);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(0);
        make.top.equalTo(CYTMarginV);
        make.bottom.equalTo(-CYTMarginV);
        make.width.equalTo(0.5);
    }];

    [self.borderView addSubview:self.assisImageView];
    [self.borderView addSubview:self.descriptionLabel];
    [self.assisImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.centerY.equalTo(0);
    }];
    [self.descriptionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.assisImageView.right).offset(2);
        make.top.bottom.equalTo(0);
        make.right.equalTo(0);
    }];
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
- (void)setModel:(CarSourceDetailRoutModel *)model {
    _model = model;
    self.startLabel.text = model.origin;
    self.endLabel.text = model.destination;
    
    NSString *des = @" 元起";
    NSString *price = [NSString stringWithFormat:@"%@%@",model.transportPrice,des];
    self.descriptionLabel.text = price;
    
    NSRange range = [price rangeOfString:des];
    [self.descriptionLabel updateWithRange:range font:CYTFontWithPixel(26) color:kFFColor_title_L2];
}

#pragma mark- get
- (UILabel *)startLabel {
    if (!_startLabel) {
        _startLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _startLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView ff_imageViewWithImageName:@"logistics_home_arrow"];
    }
    return _arrowImageView;
}

- (UILabel *)endLabel {
    if (!_endLabel) {
        _endLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _endLabel;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
    }
    return _borderView;
}

- (UIImageView *)assisImageView {
    if (!_assisImageView) {
        _assisImageView = [UIImageView ff_imageViewWithImageName:@"logsitics_home_yuan"];
    }
    return _assisImageView;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_title_L2];
    }
    return _descriptionLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}
@end
