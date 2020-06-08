//
//  FFCellView_Style_SimpleShow.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCellView_Style_SimpleShow.h"
#import "FFBasicMacro.h"
#import "FFCommonCode.h"

@implementation FFCellView_Style_SimpleShow

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.flagLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.line];
    
    [self.flagLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kFFAutolayoutV(25));
        make.bottom.lessThanOrEqualTo(-kFFAutolayoutV(25));
        make.left.equalTo(kFFAutolayoutH(30));
    }];
    
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(kFFAutolayoutV(25));
        make.bottom.lessThanOrEqualTo(-kFFAutolayoutV(25));
        make.right.lessThanOrEqualTo(-kFFAutolayoutH(30));
        make.centerY.equalTo(self);
        make.left.equalTo(self.flagLabel.right).offset(kFFAutolayoutH(20));
    }];
    
    [self.arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(kFFAutolayoutH(-30));
        make.centerY.equalTo(self);
    }];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(30));
        make.right.equalTo(-kFFAutolayoutH(30));
        make.bottom.equalTo(0);
        make.height.equalTo(kFFLayout_line);
    }];
}

#pragma mark- set
- (void)setSingleLine:(BOOL)singleLine {
    _singleLine = singleLine;
    
    if (singleLine) {
        self.contentLabel.numberOfLines = 1;
    }else {
        self.contentLabel.numberOfLines = 0;
    }
}

- (void)setShowArrow:(BOOL)showArrow {
    _showArrow = showArrow;
    
    self.arrowImageView.hidden = !showArrow;
    
    if (showArrow) {
        //显示箭头
        [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
            make.right.lessThanOrEqualTo(self.arrowImageView.left).offset(-kFFAutolayoutH(10));
        }];
    }else{
        //不显示箭头
        [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
            make.right.lessThanOrEqualTo(kFFAutolayoutH(-20));
        }];
    }
}

- (void)setContentRightOffset:(float)contentRightOffset {
    _contentRightOffset = contentRightOffset;
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(contentRightOffset);
    }];
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _flagLabel.text = @"title";
    }
    return _flagLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _contentLabel.text = @"content";
    }
    return _contentLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrowImageView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}
@end
