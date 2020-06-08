//
//  CYTAddressAreaReaviewView2.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressAreaReaviewView2.h"

@implementation CYTAddressAreaReaviewView2

- (void)ff_initWithViewModel:(id)viewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
        [self hide];
    }];
    [self addGestureRecognizer:tapGes];
}

- (void)ff_addSubViewAndConstraints {
    self.alpha = 0;
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.areaImageView];
    [self.bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.areaImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }];
}

#pragma mark-get
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.image = [UIImage imageNamed:@"carSource_publish_bgImage"];
    }
    return _bgImageView;
}

- (UIImageView *)areaImageView {
    if (!_areaImageView) {
        _areaImageView = [UIImageView new];
        _areaImageView.contentMode = UIViewContentModeScaleAspectFit;
        _areaImageView.image = [UIImage imageNamed:@"carSource_publish_area"];
    }
    return _areaImageView;
}


@end
