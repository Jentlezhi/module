//
//  CYTCarSourceDetailCell_price.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_price.h"

@implementation CYTCarSourceDetailCell_price

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab,self.subTitleLab,self.assistantLab];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(25));
        make.bottom.equalTo(-CYTAutoLayoutV(25));
    }];
    [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.right).offset(CYTAutoLayoutH(20));
        make.centerY.equalTo(self.titleLab);
    }];
    [self.assistantLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.left.equalTo(self.subTitleLab.right);
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel labelWithFontPxSize:30 textColor:CYTRedColor];
    }
    return _subTitleLab;
}

- (UILabel *)assistantLab {
    if (!_assistantLab) {
        _assistantLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L3];
    }
    return _assistantLab;
}

@end
