//
//  FFOtherView_1.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFOtherView_1.h"
#import "FFCommonCode.h"
#import "FFBasicMacro.h"

@interface FFOtherView_1 ()
@property (nonatomic, strong) UIButton *bgButton;

@end

@implementation FFOtherView_1

- (void)ff_initWithViewModel:(id)viewModel {
    _topOffset = 2;
    _midOffset = 2;
    _botOffset = -2;
    
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bgButton];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    [self.bgButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topOffset);
        make.centerX.equalTo(self);
        make.left.greaterThanOrEqualTo(5);
        make.right.lessThanOrEqualTo(-5);
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.bottom).offset(self.midOffset);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.bottom);
        make.left.greaterThanOrEqualTo(5);
        make.right.lessThanOrEqualTo(-5);
    }];
}

- (void)setTopOffset:(float)topOffset {
    _topOffset = topOffset;
    
    [self.imageView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topOffset);
    }];
}

- (void)setMidOffset:(float)midOffset {
    _midOffset = midOffset;
    
    [self.titleLabel updateConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.imageView.bottom).offset(self.midOffset);
    }];
}

- (void)setBotOffset:(float)botOffset {
    _botOffset = botOffset;
    
    [self.titleLabel updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(botOffset);
    }];
}

#pragma mark- get
- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(self);
            }
        }];
    }
    return _bgButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_green];
    }
    return _titleLabel;
}

@end
