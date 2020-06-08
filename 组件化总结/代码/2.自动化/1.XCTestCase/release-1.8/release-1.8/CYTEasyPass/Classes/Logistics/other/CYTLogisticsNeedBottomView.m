//
//  CYTLogisticsNeedBottomView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedBottomView.h"

@implementation CYTLogisticsNeedBottomView

- (void)ff_initWithViewModel:(id)viewModel {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightButton];
    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(CYTAutoLayoutH(30));
        make.width.equalTo(CYTAutoLayoutH(480));
    }];
    [self.rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.leftLabel.right);
    }];
    
//    self.priceString = nil;
}

//- (void)setPriceString:(NSString *)priceString {
//    
//    _priceString = (priceString)?priceString:@"0";
//    
//    NSString *total = [NSString stringWithFormat:@"预估物流费： %@ 元",_priceString];
//    self.leftLabel.text = total;
//    NSRange range = [total rangeOfString:_priceString];
//    [FFCommonCode updateLabel:self.leftLabel range:range font:[UIFont boldSystemFontOfSize:16] color:CYTRedColor];
//    
//}

- (void)setValid:(BOOL)valid {
    _valid = valid;
    
    self.rightButton.enabled = valid;
    self.rightButton.backgroundColor = (valid)?kFFColor_green:CYTBtnDisableColor;
}

#pragma mark- get
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_gray];
        _leftLabel.text = @"发布托运需求后可以获取报价";
    }
    return _leftLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = kFFColor_green;
        _rightButton.titleLabel.font = CYTFontWithPixel(28);
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitle:@"发布托运需求" forState:UIControlStateNormal];
        @weakify(self);
        [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock();
            }
        }];
        
    }
    return _rightButton;
}

@end
