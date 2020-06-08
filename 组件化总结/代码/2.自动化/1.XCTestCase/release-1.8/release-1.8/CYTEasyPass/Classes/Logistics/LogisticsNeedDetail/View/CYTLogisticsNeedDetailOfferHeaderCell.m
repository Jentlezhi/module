//
//  CYTLogisticsNeedDetailOfferHeaderCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailOfferHeaderCell.h"

@interface CYTLogisticsNeedDetailOfferHeaderCell ()
@property (nonatomic, strong) UIView *sepaView;

@end

@implementation CYTLogisticsNeedDetailOfferHeaderCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.sepaView,self.titleLab,self.expireLabel];
    block(views,^{
        self.bottomLeftOffset = CYTItemMarginH;
        self.bottomRightOffset = -CYTItemMarginH;
        [self.expireLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

- (void)updateConstraints {
    [self.sepaView updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.ffContentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [self.titleLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sepaView.bottom);
        make.left.equalTo(CYTItemMarginH);
        make.bottom.equalTo(self.ffContentView);
        make.height.equalTo(CYTAutoLayoutV(70));
    }];
    [self.expireLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab);
        make.left.greaterThanOrEqualTo(self.titleLab.right).offset(5);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [super updateConstraints];
}

- (void)setExpired:(BOOL)expired {
    _expired = expired;
    
    if (expired) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:240/255.0];
        self.bottomHeight = 5;
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.bottomHeight = 0;
    }
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    
    NSString *numStr = [NSString stringWithFormat:@"已收到 %ld 个报价",number];
    NSRange range = [numStr rangeOfString:[NSString stringWithFormat:@"%ld",number]];
    self.titleLab.text = numStr;
    [self.titleLab updateWithRange:range font:CYTFontWithPixel(26) color:CYTRedColor];
}

#pragma mark- get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _titleLab;
}

- (UIView *)sepaView {
    if (!_sepaView) {
        _sepaView = [UIView new];
        _sepaView.backgroundColor = kFFColor_bg_nor;
    }
    return _sepaView;
}

- (UILabel *)expireLabel {
    if (!_expireLabel) {
        _expireLabel = [UILabel labelWithFontPxSize:25 textColor:kFFColor_title_L2];
        _expireLabel.textAlignment = NSTextAlignmentRight;
    }
    return _expireLabel;
}

@end
