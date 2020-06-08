//
//  FFBasicSegmentItemView_triangle.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSegmentItemView_triangle.h"

@implementation FFBasicSegmentItemView_triangle
@synthesize title = _title;

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleButton];
    [self addSubview:self.vline];
    [self addSubview:self.borderView];
    self.vline.hidden = NO;
    
    [self.titleButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.vline makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(kFFAutolayoutV(50));
        make.width.equalTo(0.5);
        make.right.equalTo(self);
    }];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.right.lessThanOrEqualTo(-1);
        make.left.greaterThanOrEqualTo(1);
    }];
    
    [self.borderView addSubview:self.titleLabel];
    [self.borderView addSubview:self.triangleImageView];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(10));
        make.top.bottom.equalTo(self.borderView);
    }];
    [self.triangleImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.right).offset(kFFAutolayoutH(10));
        make.top.bottom.equalTo(self.borderView);
        make.right.equalTo(-kFFAutolayoutH(10));
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleButton setTitle:@"" forState:UIControlStateNormal];
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}

#pragma mark- get
- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
    }
    return _borderView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _titleLabel;
}

- (UIImageView *)triangleImageView {
    if (!_triangleImageView) {
        _triangleImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _triangleImageView;
}

@end
