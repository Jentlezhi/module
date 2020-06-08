//
//  LogisticsHomeCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "LogisticsHomeCell.h"

@implementation LogisticsHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.startLabel,self.arrowImageView,self.endLabel,self.assisImageView,self.descriptionLabel];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    
    [self.startLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(40));
        make.top.equalTo(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startLabel);
        make.left.equalTo(self.startLabel.right).offset(CYTAutoLayoutH(22));
    }];
    [self.endLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startLabel);
        make.left.equalTo(self.arrowImageView.right).offset(CYTAutoLayoutH(22));
    }];
    [self.assisImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startLabel);
        make.right.equalTo(self.descriptionLabel.left).offset(-CYTAutoLayoutH(8));
        make.left.greaterThanOrEqualTo(self.endLabel.right).offset(CYTItemMarginH);
    }];
    [self.descriptionLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startLabel);
        make.right.equalTo(-CYTAutoLayoutH(40));
    }];
    
    [super updateConstraints];
}

- (void)setModel:(LogisticsHomeModel *)model {
    _model = model;
    self.startLabel.text = model.origin;
    self.endLabel.text = model.destination;
    
    NSString *des = @" 元起";
    NSString *price = [NSString stringWithFormat:@"%@%@",model.transportPrice,des];
    self.descriptionLabel.text = price;
    
    NSRange range = [price rangeOfString:des];
    [self.descriptionLabel updateWithRange:range font:CYTFontWithPixel(26) color:kFFColor_title_L2];
}

#pragma mark- get
- (UILabel *)startLabel {
    if (!_startLabel) {
        _startLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _startLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView ff_imageViewWithImageName:@"logistics_home_arrow"];
    }
    return _arrowImageView;
}

- (UILabel *)endLabel {
    if (!_endLabel) {
        _endLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _endLabel;
}

- (UIImageView *)assisImageView {
    if (!_assisImageView) {
        _assisImageView = [UIImageView ff_imageViewWithImageName:@"logsitics_home_yuan"];
    }
    return _assisImageView;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_title_L2];
    }
    return _descriptionLabel;
}

@end
