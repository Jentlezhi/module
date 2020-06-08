//
//  FFNavigationView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFNavigationView.h"

@interface FFNavigationView ()

@end

@implementation FFNavigationView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bgImageView];
    [self addSubview:self.contentView];
    [self insertSubview:self.bottomLineView atIndex:0];
    
    [self.bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(-kFFNavigationLineHeight);
    }];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(kFFStatusBarHeight);
        make.bottom.equalTo(-kFFNavigationLineHeight);
    }];
    [self.bottomLineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(5);
    }];
}

#pragma mark- method
- (void)showTitleItem:(BOOL)show {
    [self.contentView showTitleItem:show];
}

- (void)showTitleItemWithTitle:(NSString *)title {
    self.contentView.titleView.title = title;
    [self showTitleItem:YES];
}

- (void)showLeftItem:(BOOL)show {
    [self.contentView showLeftItem:show];
}

- (void)showLeftItemWithTitle:(NSString *)title {
    self.contentView.leftView.title = title;
    [self showLeftItem:YES];
}

- (void)showRightItem:(BOOL)show {
    [self.contentView showRightItem:show];
}

- (void)showRightItemWithTitle:(NSString *)title {
    self.contentView.rightView.title = title;
    [self showRightItem:YES];
}

- (void)setBottomLineColor:(UIColor *)color andOpacity:(float)opacity andOffset:(float)offset {
    _bottomLineView.layer.shadowOffset = CGSizeMake(0, offset);
    _bottomLineView.layer.shadowOpacity = opacity;
    _bottomLineView.layer.shadowColor = color.CGColor;
}

#pragma mark- get
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImageView.backgroundColor = kFFNavigationBarDefaultColor;
    }
    return _bgImageView;
}

- (FFNavigationContentView *)contentView {
    if (!_contentView) {
        _contentView = [FFNavigationContentView new];
        @weakify(self);
        [_contentView setLeftClickBlock:^(FFNavigationItemView *leftView) {
            @strongify(self);
            if (self.leftClickBlock) {
                self.leftClickBlock(leftView);
            }
        }];
        [_contentView setTitleClickBlock:^(FFNavigationItemView *titleView) {
            @strongify(self);
            if (self.titleClickBlock) {
                self.titleClickBlock(titleView);
            }
        }];
        [_contentView setRightClickBlock:^(FFNavigationItemView *rightView) {
            @strongify(self);
            if (self.rightClickBlock) {
                self.rightClickBlock(rightView);
            }
        }];
    }
    return _contentView;
}

- (UIImageView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [UIImageView new];
        _bottomLineView.contentMode = UIViewContentModeScaleAspectFit;
        _bottomLineView.backgroundColor = kFFNavigationBarLineDefaultColor;
//        [self setBottomLineColor:kFFNavigationBarLineDefaultColor andOpacity:0.5 andOffset:0.5];
    }
    return _bottomLineView;
}

@end
