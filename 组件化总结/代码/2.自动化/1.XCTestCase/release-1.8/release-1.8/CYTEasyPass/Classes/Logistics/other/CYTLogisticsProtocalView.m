//
//  CYTLogisticsProtocalView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsProtocalView.h"

@implementation CYTLogisticsProtocalView

- (void)ff_initWithViewModel:(id)viewModel {
    _select = YES;
    self.backgroundColor = kFFColor_bg_nor;
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleLabel];
    [self addSubview:self.checkButton];
    
    [self.checkButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.bottom.equalTo(self);
        make.left.equalTo(CYTAutoLayoutH(15));
        make.centerY.equalTo(self.titleLabel);
        make.width.height.equalTo(30);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkButton.right);
        make.right.lessThanOrEqualTo(-CYTAutoLayoutH(30));
    }];
    
    [self.checkButton enlargeWithValue:10.0];
}

#pragma mark- get
- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_checkButton setImage:[UIImage imageNamed:@"m_select_"] forState:UIControlStateNormal];
        @weakify(self);
        [[_checkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            self.select = !self.select;
            NSString *imageString = (self.select)?@"m_select_":@"m_seleectable_";
            [_checkButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
            
            if (self.selectBlock) {
                self.selectBlock(self.select);
            }
            
        }];
    }
    return _checkButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:22 textColor:kFFColor_title_gray];
        _titleLabel.userInteractionEnabled  = YES;
        NSString *totalString = @"我已阅读并同意《车辆运输居间服务协议》";
        _titleLabel.text = totalString;
        NSRange range = [totalString rangeOfString:@"《车辆运输居间服务协议》"];
        [_titleLabel updateWithRange:range font:CYTFontWithPixel(22) color:kFFColor_green];
        
        UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
        @weakify(self);
        [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.agreeProtocalBlock) {
                self.agreeProtocalBlock();
            }
        }];
        [_titleLabel addGestureRecognizer:tapGes];
    }
    return _titleLabel;
}

@end
