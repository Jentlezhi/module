//
//  CYTCarSourceDetailCell_image.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_image.h"

@implementation CYTCarSourceDetailCell_image

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.titleLab,self.imgView,self.assistantLab,self.arrowImageView];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
    });
}

- (void)updateConstraints {
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(25));
    }];
    [self.imgView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.right).offset(CYTAutoLayoutH(20));
        make.top.equalTo(CYTAutoLayoutV(25));
        make.bottom.equalTo(-CYTAutoLayoutV(25));
    }];
    [self.assistantLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.right).offset(CYTAutoLayoutH(20));
        make.bottom.equalTo(self.imgView);
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.right.equalTo((-CYTMarginH));
    }];
    
    [super updateConstraints];
}

- (void)setUrlArray:(NSArray *)urlArray {
    _urlArray = urlArray;
    self.assistantLab.text = [NSString stringWithFormat:@"（共%ld张）",urlArray.count];
    self.imgView.urlArray = urlArray;
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (CYTCarSourceDetailImageView *)imgView {
    if (!_imgView) {
        _imgView = [CYTCarSourceDetailImageView new];
    }
    return _imgView;
}

- (UILabel *)assistantLab {
    if (!_assistantLab) {
        _assistantLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L3];
    }
    return _assistantLab;
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
