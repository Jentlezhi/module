//
//  CarFilterConditionTabelCell_text.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterConditionTabelCell_text.h"

@implementation CarFilterConditionTabelCell_text

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.contentLabel];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = -CYTMarginH;
    });
}

- (void)updateConstraints {
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.top.bottom.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(80));
        make.right.equalTo(-CYTAutoLayoutH(30));
    }];
    
    [super updateConstraints];
}

- (void)setType:(CarFilterConditionTableType)type {
    _type = type;
    if (type == CarFilterConditionTableCar) {
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = 0;
    }else {
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = -CYTMarginH;
    }
}

#pragma mark- get
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _contentLabel;
}

@end
