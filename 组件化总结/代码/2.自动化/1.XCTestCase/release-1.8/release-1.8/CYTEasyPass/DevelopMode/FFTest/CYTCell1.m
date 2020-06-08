//
//  CYTCell1.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCell1.h"

@implementation CYTCell1

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    block(@[self.label],^{
        self.bottomHeight = 5;
    });
}

- (void)updateConstraints {
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
    }];
    
    [super updateConstraints];
}

- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    //自定义样式
    if ([ffCustomizeCellModel.ffIdentifier isEqualToString:NSStringFromClass([self class])]) {
        if (ffCustomizeCellModel.ffIndexPath.row==0) {
            self.label.textColor = [UIColor blueColor];
        }else {
            self.label.textColor = [UIColor purpleColor];
        }
    }
    [super setFfCustomizeCellModel:ffCustomizeCellModel];
}

- (void)setFfModel:(FFExtendModel *)ffModel {
    self.model = ffModel;
}

- (void)setModel:(FFExtendModel *)model {
    _model = model;
    self.str = model.ffDescription;
}

- (void)setStr:(NSString *)str {
    _str = str;
    
    self.label.text = str;
}

#pragma mark- get
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
