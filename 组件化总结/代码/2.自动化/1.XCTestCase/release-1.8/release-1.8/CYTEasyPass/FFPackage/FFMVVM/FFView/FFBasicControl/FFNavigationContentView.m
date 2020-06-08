//
//  FFNavigationContentView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFNavigationContentView.h"

@implementation FFNavigationContentView
@synthesize leftView = _leftView;
@synthesize titleView = _titleView;
@synthesize rightView = _rightView;


- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleView];
    [self.titleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.greaterThanOrEqualTo(kItemMinWidth);
        make.width.lessThanOrEqualTo(kFF_SCREEN_WIDTH-3*kItemMinWidth);
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    
}

- (void)showTitleItem:(BOOL)show {
    if (self.titleView) {
        [self.titleView removeFromSuperview];
    }
    if (!show) {
        return;
    }
    [self addSubview:self.titleView];
    [self.titleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.greaterThanOrEqualTo(kItemMinWidth);
        make.width.lessThanOrEqualTo(kFF_SCREEN_WIDTH-3*kItemMinWidth);
    }];
}

- (void)showLeftItem:(BOOL)show {
    if (self.leftView) {
        [self.leftView removeFromSuperview];
    }
    if (!show) {
        return;
    }
    [self addSubview:self.leftView];
    [self.leftView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.greaterThanOrEqualTo(kItemMinWidth);
    }];
}

- (void)showRightItem:(BOOL)show {
    if (self.rightView) {
        [self.rightView removeFromSuperview];
    }
    if (!show) {
        return;
    }
    [self addSubview:self.rightView];
    [self.rightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(-kFFNavigationItemSpace);
        make.width.greaterThanOrEqualTo(kItemMinWidth);
    }];
}

#pragma mark- method
- (void)updateView:(FFNavigationItemView *)item width:(float)width {
    if (item) {
        [item updateConstraints:^(MASConstraintMaker *make) {
            make.width.lessThanOrEqualTo(width);
        }];
    }
}

#pragma mark- get

- (FFNavigationItemView *)leftView {
    if (!_leftView) {
        _leftView = [FFNavigationItemView new];
        _leftView.imageName = @"ff_nav_back_0";
        @weakify(self);
        [_leftView setClickedBlock:^(FFNavigationItemView *itemView) {
            @strongify(self);
            if (self.leftClickBlock) {
                self.leftClickBlock(self.leftView);
            }
        }];
    }
    return _leftView;
}

- (void)setLeftView:(FFNavigationItemView *)leftView {
    //先将原来的删除
    if (leftView) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    @weakify(self);
    [_leftView setClickedBlock:^(FFNavigationItemView *itemView) {
        @strongify(self);
        if (self.leftClickBlock) {
            self.leftClickBlock(leftView);
        }
    }];
}

- (FFNavigationItemView *)titleView {
    if (!_titleView) {
        _titleView = [FFNavigationItemView new];
        @weakify(self);
        [_titleView setClickedBlock:^(FFNavigationItemView *itemView) {
            @strongify(self);
            if (self.titleClickBlock) {
                self.titleClickBlock(self.titleView);
            }
        }];
    }
    return _titleView;
}

- (void)setTitleView:(FFNavigationItemView *)titleView {
    //先将原来的删除
    if (titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    @weakify(self);
    [_titleView setClickedBlock:^(FFNavigationItemView *itemView) {
        @strongify(self);
        if (self.titleClickBlock) {
            self.titleClickBlock(titleView);
        }
    }];
}

- (FFNavigationItemView *)rightView {
    if (!_rightView) {
        _rightView = [FFNavigationItemView new];
        @weakify(self);
        [_rightView setClickedBlock:^(FFNavigationItemView *itemView) {
            @strongify(self);
            if (self.rightClickBlock) {
                self.rightClickBlock(self.rightView);
            }
        }];
    }
    return _rightView;
}

- (void)setRightView:(FFNavigationItemView *)rightView {
    //先将原来的删除
    if (rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    @weakify(self);
    [_rightView setClickedBlock:^(FFNavigationItemView *itemView) {
        @strongify(self);
        if (self.rightClickBlock) {
            self.rightClickBlock(rightView);
        }
    }];
}

@end
