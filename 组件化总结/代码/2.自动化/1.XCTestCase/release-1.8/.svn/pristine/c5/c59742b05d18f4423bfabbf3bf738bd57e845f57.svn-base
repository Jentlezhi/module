//
//  CYTArrivalDateCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTArrivalDateCell.h"

@implementation CYTArrivalDateCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab];
    block(views,^{
        self.bottomLeftOffset = CYTItemMarginH;
        self.bottomRightOffset = -CYTItemMarginH;
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.top.bottom.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

@end
