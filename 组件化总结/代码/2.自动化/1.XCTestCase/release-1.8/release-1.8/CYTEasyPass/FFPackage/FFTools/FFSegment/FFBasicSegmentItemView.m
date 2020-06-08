//
//  FFBasicSegmentItemView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSegmentItemView.h"

@interface FFBasicSegmentItemView ()
@property (nonatomic, strong) UIView *bgView;

@end

@implementation FFBasicSegmentItemView

- (void)ff_initWithViewModel:(id)viewModel {
    _bubbleWidth = 18.0;
}

- (void)ff_bindViewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
        if (self.selectBlock) {
            self.selectBlock();
        }
    }];
    [self addGestureRecognizer:tapGes];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bgView];
    [self addSubview:self.titleButton];
    [self addSubview:self.bubbleView];
    [self addSubview:self.vline];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.titleButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.bubbleView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleButton.titleLabel.right).offset(-self.bubbleWidth/2.0);
        make.top.equalTo(2);
        make.height.equalTo(self.bubbleWidth);
        make.width.greaterThanOrEqualTo(self.bubbleWidth);
    }];
    [self.vline makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(kFFAutolayoutV(50));
        make.width.equalTo(0.5);
        make.right.equalTo(self);
    }];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.titleButton setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}

#pragma mark- get
- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        _titleButton.userInteractionEnabled = NO;
    }
    return _titleButton;
}

- (FFBubbleView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [FFBubbleView new];
        [_bubbleView radius:self.bubbleWidth/2.0 borderWidth:1 borderColor:[UIColor whiteColor]];
        _bubbleView.bubbleButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_bubbleView.bubbleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bubbleView.bubbleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bubbleView.bubbleButton setContentEdgeInsets:UIEdgeInsetsMake(1.5, 3, 1.5, 3)];
        _bubbleView.bubbleButton.userInteractionEnabled = NO;
        _bubbleView.hidden = YES;
    }
    return _bubbleView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
    }
    return _bgView;
}

- (UIView *)vline {
    if (!_vline) {
        _vline = [UIView new];
        _vline.hidden = YES;
        _vline.backgroundColor = kFFColor_line;
    }
    return _vline;
}

@end
