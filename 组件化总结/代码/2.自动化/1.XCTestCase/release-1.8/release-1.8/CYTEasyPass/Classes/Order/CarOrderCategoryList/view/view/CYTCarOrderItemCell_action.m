//
//  CYTCarOrderItemCell_action.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderItemCell_action.h"

@implementation CYTCarOrderItemCell_action

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.firstButton];
    [self addSubview:self.midButton];
    [self addSubview:self.secondButton];
    self.midButton.hidden = YES;
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(10));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(58)));
        make.right.equalTo(self.secondButton.mas_left).offset(-CYTAutoLayoutH(20));
    }];
    [self.midButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(10));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(58)));
        make.right.equalTo(self.secondButton.mas_left).offset(-CYTAutoLayoutH(20));
    }];
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(10));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(58)));
        make.right.equalTo(-CYTAutoLayoutH(20));
    }];
}

#pragma mark- get
- (UIButton *)firstButton {
    if (!_firstButton) {
        _firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_firstButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        _firstButton.titleLabel.font = CYTFontWithPixel(28);
        _firstButton.backgroundColor = [UIColor whiteColor];
        [_firstButton radius:1 borderWidth:0.5 borderColor:kFFColor_line];
        @weakify(self);
        [[_firstButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.firstBlock) {
                self.firstBlock(0);
            }
        }];
    }
    return _firstButton;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _secondButton.titleLabel.font = CYTFontWithPixel(28);
        _secondButton.backgroundColor = kFFColor_green;
        [_secondButton radius:1 borderWidth:0.5 borderColor:kFFColor_green];
        @weakify(self);
        [[_secondButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.secondBlock) {
                self.secondBlock(1);
            }
        }];
    }
    return _secondButton;
}

- (UIButton *)midButton {
    if (!_midButton) {
        _midButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_midButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        _midButton.titleLabel.font = CYTFontWithPixel(28);
        _midButton.backgroundColor = [UIColor whiteColor];
        [_midButton radius:1 borderWidth:0.5 borderColor:kFFColor_line];
        @weakify(self);
        [[_midButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.midBlock) {
                self.midBlock(5);
            }
        }];
    }
    return _midButton;
}


@end
