//
//  CYTPersonalHomeCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalHomeCell.h"

@implementation CYTPersonalHomeCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagImageView,self.flagLabel,self.numberLabel,self.bubbleView,self.arrowImageView];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.flagImageView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
    }];
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffContentView);
        make.left.equalTo(self.flagImageView.right).offset(CYTItemMarginH);
    }];
    [self.numberLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffContentView);
        make.right.equalTo(self.arrowImageView.left).offset(-2);
    }];
    [self.bubbleView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.right);
        make.bottom.equalTo(self.numberLabel.top).offset(2);
        make.width.height.equalTo(CYTAutoLayoutH(18));
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ffContentView);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTPersonalHomeCellModel *)model {
    _model = model;
    
    self.flagImageView.image = [UIImage imageNamed:model.imageName];
    self.flagLabel.text = model.title;
    self.numberLabel.text = model.number;
    self.bubbleView.hidden = !model.showBubble;
}

#pragma mark- get
- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _flagImageView;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _flagLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _numberLabel;
}

- (UIView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [UIView new];
        _bubbleView.backgroundColor = CYTRedColor;
        [_bubbleView radius:CYTAutoLayoutH(18/2.0) borderWidth:0.5 borderColor:CYTRedColor];
    }
    return _bubbleView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImageView.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrowImageView;
}

@end
