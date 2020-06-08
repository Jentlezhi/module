//
//  CYTBrandSelect_seriesCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelect_seriesCell.h"

@implementation CYTBrandSelect_seriesCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.contentLabel];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(80));
        make.top.bottom.equalTo(0);
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
    }
    return _contentLabel;
}

@end
