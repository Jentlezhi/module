//
//  FFCellView_Sytle_SimpleChoose.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCellView_Sytle_SimpleChoose.h"
#import "FFCommonCode.h"
#import "FFBasicMacro.h"

@implementation FFCellView_Sytle_SimpleChoose

- (void)ff_initWithViewModel:(id)viewModel {
    
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.borderView];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addContentView];
}

- (void)setLeftMinWidth:(float)leftMinWidth {
    _leftMinWidth = leftMinWidth;
    [self addContentView];
}

- (void)addContentView {
    [self.borderView addSubview:self.flagLabel];
    [self.borderView addSubview:self.contentLabel];
    [self.borderView addSubview:self.arrowImageView];
    [self.borderView addSubview:self.line];
    
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(30));
        make.centerY.equalTo(self.borderView);
        make.top.greaterThanOrEqualTo(kFFAutolayoutV(30));
        make.bottom.lessThanOrEqualTo(-kFFAutolayoutV(30));
    }];
    
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.left).offset(-kFFAutolayoutH(10));
        make.centerY.equalTo(self.borderView);
        if (self.leftMinWidth == 0) {
            make.left.greaterThanOrEqualTo(self.flagLabel.right).offset(kFFAutolayoutH(20));
        }else {
            make.left.greaterThanOrEqualTo(self.leftMinWidth);
        }
        make.top.greaterThanOrEqualTo(kFFAutolayoutV(30));
        make.bottom.lessThanOrEqualTo(-kFFAutolayoutV(30));
    }];
    [self.arrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(kFFAutolayoutH(-20));
        make.centerY.equalTo(self.borderView);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(30));
        make.right.equalTo(-kFFAutolayoutH(30));
        make.bottom.equalTo(self.borderView);
        make.height.equalTo(kFFLayout_line);
    }];
}

- (void)setShowArrow:(BOOL)showArrow {
    _showArrow = showArrow;
    
    self.arrowImageView.hidden = !showArrow;
    
    if (showArrow) {
        //显示箭头
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.left).offset(-kFFAutolayoutH(10));
            make.centerY.equalTo(self.borderView);
            if (self.leftMinWidth == 0) {
                make.left.greaterThanOrEqualTo(self.flagLabel.right).offset(kFFAutolayoutH(20));
            }else {
                make.left.greaterThanOrEqualTo(self.leftMinWidth);
            }
            make.top.greaterThanOrEqualTo(kFFAutolayoutV(30));
            make.bottom.lessThanOrEqualTo(-kFFAutolayoutV(30));
        }];
    }else{
        //不显示箭头
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(kFFAutolayoutH(-30));
            make.centerY.equalTo(self.borderView);
            if (self.leftMinWidth == 0) {
                make.left.greaterThanOrEqualTo(self.flagLabel.right).offset(kFFAutolayoutH(20));
            }else {
                make.left.greaterThanOrEqualTo(self.leftMinWidth);
            }
            make.top.greaterThanOrEqualTo(kFFAutolayoutV(30));
            make.bottom.lessThanOrEqualTo(-kFFAutolayoutV(30));
        }];
    }
}

- (void)setShowNone:(BOOL)showNone {
    _showNone = showNone;
    
    if (showNone) {
        [self.borderView removeFromSuperview];
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(kFFLayout_line);
        }];
    }else {
        [self addSubview:self.borderView];
        [self.borderView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

#pragma mark- get
- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
        _borderView.layer.masksToBounds = YES;
    }
    return _borderView;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        
    }
    return _flagLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
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
