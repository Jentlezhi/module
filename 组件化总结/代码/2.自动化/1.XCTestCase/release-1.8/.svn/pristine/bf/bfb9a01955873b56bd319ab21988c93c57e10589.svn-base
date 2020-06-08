//
//  CYTSourceAndFindCarSearchHeadView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSourceAndFindCarSearchHeadView.h"

@implementation CYTSourceAndFindCarSearchHeadView

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = kFFColor_bg_nor;
    [self addSubview:self.flagLabel];
    [self addSubview:self.clearButton];
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(CYTMarginH);
    }];
    [self.clearButton enlargeWithValue:5];
    [self.clearButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTAutoLayoutH(20));
        make.width.height.equalTo(CYTAutoLayoutH(40));
    }];
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _flagLabel.text = @"历史搜索";
    }
    return _flagLabel;
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setImage:[UIImage imageNamed:@"carSourceAndSeekCarSearch_clearHistory"] forState:UIControlStateNormal];
        [_clearButton setImage:[UIImage imageNamed:@"carSourceAndSeekCarSearch_clearHistory"] forState:UIControlStateHighlighted];
        @weakify(self);
        [[_clearButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clearBlock) {
                self.clearBlock();
            }
        }];
    }
    return _clearButton;
}

@end
