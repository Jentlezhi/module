//
//  CYTBrandSelect_carCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelect_carCell.h"

@implementation CYTBrandSelect_carCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.contentLabel,self.assistantLabel];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
        [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(80));
        make.top.bottom.equalTo(0);
    }];
    [self.assistantLabel updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTItemMarginH);
        make.centerY.equalTo(0);
        make.left.greaterThanOrEqualTo(self.contentLabel.right).offset(10);
    }];
    
    [super updateConstraints];
}

- (void)setHighlightedCell:(BOOL)highlightedCell {
    _highlightedCell = highlightedCell;
    self.contentLabel.textColor = (highlightedCell)?kFFColor_green:kFFColor_title_L2;
}

#pragma mark- get
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_title_L2];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UILabel *)assistantLabel {
    if (!_assistantLabel) {
        _assistantLabel = [UILabel labelWithFontPxSize:31 textColor:kFFColor_title_L2];
    }
    return _assistantLabel;
}

@end
