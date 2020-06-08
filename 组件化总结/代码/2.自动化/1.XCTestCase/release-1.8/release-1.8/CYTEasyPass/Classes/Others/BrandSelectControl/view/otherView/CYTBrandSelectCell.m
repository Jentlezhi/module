//
//  CYTBrandSelectCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelectCell.h"

@implementation CYTBrandSelectCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagImageView,self.contentLabel];
    block(views,^{
        self.bottomLeftOffset = CYTAutoLayoutH(130);
        self.bottomRightOffset = CYTAutoLayoutH(-40);
        [self.flagImageView radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
    });
}

- (void)updateConstraints {
    [self.flagImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(CYTAutoLayoutH(40));
        make.width.height.equalTo(CYTAutoLayoutH(70));
    }];
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.flagImageView.right).offset(CYTAutoLayoutH(20));
        make.height.equalTo(CYTAutoLayoutV(100));
        make.top.bottom.equalTo(0);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTBrandSelectModel *)model {
    _model = model;
    NSURL *url = [NSURL URLWithString:model.logoUrl];
    [self.flagImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_car_unsel"]];
    self.contentLabel.text = model.masterBrandName;
}

- (void)setHighlightedCell:(BOOL)highlightedCell {
    _highlightedCell = highlightedCell;
    self.contentLabel.textColor = (highlightedCell)?kFFColor_green:kFFColor_title_L1;
}

#pragma mark- get
- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _flagImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:34 textColor:kFFColor_title_L1];
    }
    return _contentLabel;
}

@end
