//
//  FFSectionHeadView_style0.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFSectionHeadView_style0.h"

@implementation FFSectionHeadView_style0

- (void)ff_bindViewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    @weakify(self);
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
        @strongify(self);
        if (self.ffClickedBlock) {
            self.ffClickedBlock(self);
        }
    }];
    [self addGestureRecognizer:tapGes];
}

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = kFFColor_bg_nor;
    
    [self addSubview:self.ffBgView];
    [self.ffBgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.bottom.equalTo(self);
        make.top.equalTo(kFFAutolayoutV(0));
    }];
    
    [self.ffBgView addSubview:self.ffVLine];
    [self.ffBgView addSubview:self.ffServeNameLabel];
    [self.ffBgView addSubview:self.ffMoreLabel];
    [self.ffBgView addSubview:self.ffMoreImageView];
    [self.ffBgView addSubview:self.ffHLine];
    
    [self.ffVLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(20));
        make.height.equalTo(kFFAutolayoutV(34));
        make.centerY.equalTo(self.ffBgView);
        make.width.equalTo(kFFAutolayoutH(6));
    }];
    [self.ffServeNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffBgView);
        make.left.equalTo(self.ffVLine.right).offset(CYTAutoLayoutH(14));
    }];
    [self.ffMoreLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffBgView);
        make.right.equalTo(self.ffMoreImageView.left);
    }];
    [self.ffMoreImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffBgView);
        make.right.equalTo(-kFFAutolayoutH(20)+3);
    }];
    [self.ffHLine makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.ffBgView);
        make.left.equalTo(kFFAutolayoutH(20));
        make.right.equalTo(-kFFAutolayoutH(20));
        make.height.equalTo(0.5);
    }];
}

- (void)setTopOffset:(float)topOffset {
    _topOffset = topOffset;
    
    [self.ffBgView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topOffset);
    }];
}

- (void)setMoreLabelLeftAlig:(BOOL)moreLabelLeftAlig {
    _moreLabelLeftAlig = moreLabelLeftAlig;
    
    [self.ffMoreLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffBgView);
        make.left.equalTo(self.ffServeNameLabel.right).offset(kFFAutolayoutH(5));
        make.right.lessThanOrEqualTo(self.ffMoreImageView.left);
    }];
}

- (void)setLeftOffset:(float)leftOffset {
    _leftOffset = leftOffset;
    [self.ffVLine updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftOffset);
    }];
}

- (void)setHLineOffset:(float)hLineOffset {
    _hLineOffset = hLineOffset;
    [self.ffHLine updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hLineOffset);
        make.right.equalTo(-hLineOffset);
    }];
}

#pragma mark- get

- (UIView *)ffBgView {
    if (!_ffBgView) {
        _ffBgView = [UIView new];
        _ffBgView.backgroundColor = [UIColor whiteColor];
    }
    return _ffBgView;
}

- (UIView *)ffVLine {
    if (!_ffVLine) {
        _ffVLine = [UIView new];
        _ffVLine.backgroundColor = kFFColor_green;
    }
    return _ffVLine;
}

- (UILabel *)ffServeNameLabel {
    if (!_ffServeNameLabel) {
        _ffServeNameLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
    }
    return _ffServeNameLabel;
}

- (UILabel *)ffMoreLabel {
    if (!_ffMoreLabel) {
        _ffMoreLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
        _ffMoreLabel.text = @"查看更多";
    }
    return _ffMoreLabel;
}

- (UIImageView *)ffMoreImageView {
    if (!_ffMoreImageView) {
        _ffMoreImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    }
    return _ffMoreImageView;
}

- (UIView *)ffHLine {
    if (!_ffHLine) {
        _ffHLine = [UIView new];
        _ffHLine.backgroundColor = kFFColor_line;
    }
    return _ffHLine;
}

@end
