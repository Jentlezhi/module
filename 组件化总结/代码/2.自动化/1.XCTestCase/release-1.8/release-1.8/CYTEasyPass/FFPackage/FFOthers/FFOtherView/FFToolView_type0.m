//
//  FFToolView_type0.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFToolView_type0.h"

@interface FFToolView_type0 ()
@property (nonatomic, strong) UIView *borderView;

@end

@implementation FFToolView_type0

- (void)ff_initWithViewModel:(id)viewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    @weakify(self);
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        if (self.clickedBlock) {
            self.clickedBlock(self);
        }
    }];
    [self addGestureRecognizer:tapGes];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.borderView];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(self.insect);
    }];
    
    [self.borderView addSubview:self.imageView];
    [self.borderView addSubview:self.titleLabel];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(self.imageView.bottom).offset(self.space);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
    }];
}

- (void)setInsect:(UIEdgeInsets)insect {
    _insect = insect;
    [self.borderView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(self.insect);
    }];
}

- (void)setSpace:(float)space {
    _space = space;
    [self.titleLabel updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.bottom).offset(self.space);
    }];
}

#pragma mark- get
- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
    }
    return _borderView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
