//
//  CYTCell2.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCell2.h"

@implementation CYTCell2

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *array = @[self.imgView,self.label];
    block(array,^{
        self.topHeight = 5;
        self.ffTopLineColor = CYTRedColor;
        self.bottomHeight = 5;
        self.ffBottomLineColor = [UIColor orangeColor];
    });
}

- (void)updateConstraints {
    [self.imgView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
    }];
    [self.label updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgView);
        make.left.equalTo(self.imgView.right).offset(10);
        make.right.lessThanOrEqualTo(-10);
    }];
    
    [super updateConstraints];
}

- (void)setStr:(NSString *)str {
    _str = str;
    
    self.label.text = str;
}

#pragma mark- get
- (UITableView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView ff_imageViewWithImageName:@"img_picture_80x80"];
    }
    return _imgView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
