//
//  CYTCoinValueView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCoinValueView.h"
#import "CYTCoinSignModel.h"

@interface CYTCoinValueView()

/** 内容 */
@property(strong, nonatomic) UILabel *contentLabel;

@end

@implementation CYTCoinValueView

- (void)initSubComponents{
    [self addSubview:self.contentLabel];
}

- (void)makeSubConstrains{
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentCenter fontPixel:20.f setContentPriority:NO];
        _contentLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _contentLabel;
}

- (void)setCoinSignModel:(CYTCoinSignModel *)coinSignModel{
    _coinSignModel = coinSignModel;
    UIColor *contentColor = CYTHexColor(@"#B6B6B6");
    UIFont *contentFont = CYTFontWithPixel(20.f);
    BOOL isToday = [coinSignModel.coinValue isEqualToString:@"今日"];
    BOOL isKeyCoinValue = coinSignModel.keyCoinValue;
    if (isToday) {
        contentColor = CYTHexColor(@"#333333");
        contentFont = CYTBoldFontWithPixel(22.f);
    }
    if (isKeyCoinValue && !isToday) {
        contentColor = CYTHexColor(@"#C39F5B");
        contentFont = CYTFontWithPixel(24.f);
    }
    self.contentLabel.textColor = contentColor;
    self.contentLabel.font = contentFont;
    self.contentLabel.text = coinSignModel.coinValue;
}

@end
