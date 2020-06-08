//
//  CYTCarInfoCommonView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarInfoCommonView.h"

@implementation CYTCarInfoCommonView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleLabel];
    [self addSubview:self.typeButton];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.importView];
    [self addSubview:self.colorView];
    [self addSubview:self.cityLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.timeLabel];
    
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(CYTAutoLayoutH(20));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.typeButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.right).offset(CYTAutoLayoutH(20));
    }];
    [self.subTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(self.titleLabel.bottom);
    }];
    [self.importView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.equalTo(self.subTitleLabel.bottom).offset(CYTAutoLayoutV(20));
        make.width.lessThanOrEqualTo(85);
    }];
    [self.colorView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLabel.bottom).offset(CYTAutoLayoutV(20));
        make.left.equalTo(self.importView.right);
        make.width.lessThanOrEqualTo(120);
    }];
    [self.cityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLabel.bottom).offset(CYTAutoLayoutV(20));
        make.left.equalTo(self.colorView.right);
        make.width.lessThanOrEqualTo(80);
    }];
    [self.lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(self.colorView.bottom).offset(CYTAutoLayoutV(20));
        make.height.equalTo(CYTLineH);
    }];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(self.lineView.bottom).offset(CYTAutoLayoutV(20));
        make.bottom.lessThanOrEqualTo(self).offset(-CYTAutoLayoutV(20));
    }];
    
}

#pragma mark- get
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _titleLabel;
}

- (UIButton *)typeButton {
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeButton setBackgroundImage:[UIImage imageNamed:@"commonCell_seller_type"] forState:UIControlStateNormal];
        [_typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _typeButton.titleLabel.font = CYTFontWithPixel(22);
    }
    return _typeButton;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _subTitleLabel;
}

- (FFLabel_Type_WithRightView *)importView {
    if (!_importView) {
        _importView = [FFLabel_Type_WithRightView new];
        [_importView initWithLabel:[self tmpLabel] rightView:[self tmpView]];
    }
    return _importView;
}

- (FFLabel_Type_WithRightView *)colorView {
    if (!_colorView) {
        _colorView = [FFLabel_Type_WithRightView new];
        [_colorView initWithLabel:[self tmpLabel] rightView:[self tmpView]];
    }
    return _colorView;
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _cityLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kFFColor_line;
    }
    return _lineView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFontPxSize:24 textColor:CYTBtnDisableColor];
    }
    return _timeLabel;
}

#pragma mark-
- (UIView *)tmpView {
    UIView *theView = [UIView new];
    UIView *line = [UIView new];
    line.backgroundColor = kFFColor_title_gray;
    [theView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(theView);
        make.width.equalTo(1);
        make.left.equalTo(5);
        make.right.equalTo(-5);
    }];
    
    return theView;
}

- (UILabel *)tmpLabel {
    UILabel *label = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    return label;
}
@end
