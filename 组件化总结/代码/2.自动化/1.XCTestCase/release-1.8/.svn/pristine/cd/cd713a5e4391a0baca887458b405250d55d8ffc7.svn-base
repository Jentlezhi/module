//
//  CYTCarSourcePublishCarBrandCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourcePublishCarBrandCell.h"

@interface CYTCarSourcePublishCarBrandCell()
@property (nonatomic, assign) BOOL hideSubtitle;

@end

@implementation CYTCarSourcePublishCarBrandCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    [self.subTitleView addSubview:self.subTitleLab];
    
    NSArray *views = @[self.flagLab,self.contentLab,self.subTitleView,self.arrowImageView];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
        [self.flagLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.flagLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.flagLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.top.equalTo(CYTAutoLayoutV(25));
        make.bottom.lessThanOrEqualTo(-CYTAutoLayoutV(25));
    }];
    [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.left).offset(-CYTAutoLayoutH(10));
        make.left.greaterThanOrEqualTo(self.flagLab.right).offset(CYTAutoLayoutH(20));
        make.centerY.equalTo(self.flagLab);
    }];
    [self.subTitleView updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentLab);
        make.top.equalTo(self.contentLab.bottom);
        make.left.greaterThanOrEqualTo(self.flagLab.right).offset(20);
        make.bottom.equalTo(0);
    }];
    [self.arrowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(CYTAutoLayoutH(-20));
        make.centerY.equalTo(self.flagLab);
    }];
    [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(16));
        make.left.right.equalTo(self.subTitleView);
        make.bottom.equalTo(self.subTitleView).offset(-20);
    }];
    
    
    if (self.hideArrow) {
        [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo((-CYTMarginH));
        }];
    }else {
        [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.left).offset(-CYTAutoLayoutH(10));
        }];
    }
    
    if (self.hideSubtitle) {
        [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(0));
            make.bottom.equalTo(self.subTitleView).offset(0);
        }];
    }else {
        [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(16));
            make.bottom.equalTo(self.subTitleView).offset(CYTAutoLayoutV(-20));
        }];
    }
    
    [super updateConstraints];
}

- (void)title:(NSString *)title subtitle:(NSString *)subtitle placeholder:(NSString *)placeholder{
    if (title.length>0 && subtitle.length>0) {
        self.contentLab.text = title;
        self.subTitleLab.text = subtitle;
        self.hideSubtitle = NO;
    }else {
        self.contentLab.text = placeholder;
        self.subTitleLab.text = @"";
        self.hideSubtitle = YES;
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setHideArrow:(BOOL)hideArrow {
    _hideArrow = hideArrow;
    self.arrowImageView.hidden = hideArrow;
}

#pragma mark- get
- (UILabel *)flagLab {
    if (!_flagLab) {
        _flagLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _flagLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
    }
    return _contentLab;
}

- (UIView *)subTitleView {
    if (!_subTitleView) {
        _subTitleView = [UIView new];
    }
    return _subTitleView;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _subTitleLab.textAlignment = NSTextAlignmentRight;
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.text = @"";
    }
    return _subTitleLab;
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
