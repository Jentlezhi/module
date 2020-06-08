//
//  CYTShareItemView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTShareItemView.h"

@implementation CYTShareItemView

- (void)ff_initWithViewModel:(id)viewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    @weakify(self);
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        if (self.clickedBlock) {
            self.clickedBlock(self.tag);
        }
    }];
    [self addGestureRecognizer:tapGes];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
    }];
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = CYTFontWithPixel(28);
        _titleLabel.textColor = kFFColor_title_L1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
