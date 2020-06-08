//
//  CYTDealerAuthFooterView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerAuthFooterView.h"

@implementation CYTDealerAuthFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.numberLabel];
        [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(-CYTAutoLayoutH(30));
        }];
    }
    return self;
}

#pragma mark- get
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _numberLabel;
}

@end
