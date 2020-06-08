//
//  CYTSourceAndFindCarSearchHistoryCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSourceAndFindCarSearchHistoryCell.h"

@implementation CYTSourceAndFindCarSearchHistoryCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.contentLab,self.arrowImageView];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(80));
        make.top.bottom.equalTo(self.ffContentView);
    }];
    [self.arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentLab);
        make.right.equalTo(kFFAutolayoutH(-20));
        make.left.greaterThanOrEqualTo(self.contentLab.right).offset(5);
    }];
    
    [super updateConstraints];
}

- (void)setFfModel:(id)ffModel {
    self.contentLab.text = (NSString *)ffModel;
}

#pragma mark- get
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _contentLab;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    }
    return _arrowImageView;
}

@end
