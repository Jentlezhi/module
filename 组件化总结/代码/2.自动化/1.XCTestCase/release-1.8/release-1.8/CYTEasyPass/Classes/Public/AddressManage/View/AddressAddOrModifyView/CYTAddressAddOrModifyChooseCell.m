//
//  CYTAddressAddOrModifyChooseCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressAddOrModifyChooseCell.h"

@implementation CYTAddressAddOrModifyChooseCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagLabel,self.contentLabel,self.arrowImageView];
    
    block(views,^{
        self.bottomHeight = 0;
        [self.flagLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(30));
        make.bottom.lessThanOrEqualTo(-CYTAutoLayoutV(30));
    }];
    [self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(30));
        make.right.equalTo(self.arrowImageView.left).offset(-5);
        make.left.equalTo(self.flagLabel.right).offset(5);
        make.bottom.lessThanOrEqualTo(-CYTAutoLayoutV(30));
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.flagLabel);
        make.right.equalTo(-CYTItemMarginH);
        make.width.height.equalTo(22);
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _flagLabel.text = @"所在地区省/市/区县";
    }
    return _flagLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_gray];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentRight;
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

@end
