//
//  CYTCarSourceDetailCell_carInfo.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_carInfo.h"

@implementation CYTCarSourceDetailCell_carInfo

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab,self.subTitleLab];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(25));
        make.right.equalTo((-CYTMarginH));
    }];
    [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.titleLab.bottom).offset(CYTAutoLayoutV(20));
        make.bottom.equalTo(-CYTAutoLayoutV(25));
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _subTitleLab;
}

@end
