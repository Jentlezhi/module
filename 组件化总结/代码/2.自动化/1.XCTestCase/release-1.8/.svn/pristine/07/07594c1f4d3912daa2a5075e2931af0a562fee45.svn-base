//
//  CYTGetColorBasicCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetColorBasicCell.h"

@implementation CYTGetColorBasicCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(CYTAutoLayoutV(20));
        make.bottom.equalTo(-CYTAutoLayoutV(20));
        make.left.greaterThanOrEqualTo(CYTMarginH);
        make.right.lessThanOrEqualTo((-CYTMarginH));
        
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L2];
    }
    return _titleLab;
}

@end
