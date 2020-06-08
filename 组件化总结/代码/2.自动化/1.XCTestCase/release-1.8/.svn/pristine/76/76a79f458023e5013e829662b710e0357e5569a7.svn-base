//
//  CYTLogisticsNeedDetailOfferEmptyCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailOfferEmptyCell.h"

@implementation CYTLogisticsNeedDetailOfferEmptyCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab];
    block(views,^{
        self.bottomHeight = 0;
        self.backgroundColor = kFFColor_bg_nor;
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(130));
        make.centerX.equalTo(self.ffContentView);
        make.bottom.equalTo(-CYTAutoLayoutV(130));
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _titleLab.text = @"暂未收到报价";
    }
    return _titleLab;
}

@end
