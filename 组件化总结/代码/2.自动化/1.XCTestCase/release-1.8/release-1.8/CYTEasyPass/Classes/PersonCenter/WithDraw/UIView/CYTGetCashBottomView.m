//
//  CYTGetCashBottomView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashBottomView.h"

@implementation CYTGetCashBottomView

- (void)ff_initWithViewModel:(id)viewModel {
    [self radius:4 borderWidth:1 borderColor:[UIColor clearColor]];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setActionEnable:(BOOL)actionEnable {
    _actionEnable = actionEnable;
    self.actionButton.enabled = actionEnable;
    UIColor *backColor = (actionEnable)?kFFColor_green:kFFColor_line;
    [self.actionButton setBackgroundImage:[UIImage imageWithColor:backColor] forState:UIControlStateNormal];
}

#pragma mark- get
- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = CYTFontWithPixel(34);
        @weakify(self);
        [[_actionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock();
            }
        }];
    }
    return _actionButton;
}

@end
