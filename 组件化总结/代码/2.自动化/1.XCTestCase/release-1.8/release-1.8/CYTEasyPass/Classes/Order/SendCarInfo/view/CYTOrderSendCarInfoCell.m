//
//  CYTOrderSendCarInfoCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderSendCarInfoCell.h"

@implementation CYTOrderSendCarInfoCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagLabel,self.contentLabel];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = -CYTMarginH;
        [self.flagLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTMarginV);
        make.bottom.lessThanOrEqualTo(-CYTMarginV);
    }];
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flagLabel);
        make.left.equalTo(self.flagLabel.right).offset(8);
        make.right.lessThanOrEqualTo(-CYTMarginH);
        make.bottom.lessThanOrEqualTo(-CYTMarginV);
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _flagLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
