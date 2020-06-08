//
//  FFConditionView_bottom.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFConditionView_bottom.h"

@implementation FFConditionView_bottom

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.closeButton];
    [self addSubview:self.line];
    
    [self.closeButton enlargeWithTop:0 left:10 bottom:0 right:10];
    [self.closeButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(30));
        make.right.equalTo(-kFFAutolayoutH(30));
        make.height.equalTo(0.5);
        make.top.equalTo(0);
    }];
}

#pragma mark- get
- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"ffCondition_close"] forState:UIControlStateNormal];
        @weakify(self);
        [[_closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock();
            }
        }];
    }
    return _closeButton;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

@end
