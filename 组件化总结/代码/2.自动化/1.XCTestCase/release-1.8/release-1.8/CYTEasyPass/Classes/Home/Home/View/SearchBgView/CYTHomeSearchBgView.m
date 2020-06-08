//
//  CYTHomeSearchBgView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeSearchBgView.h"

@interface CYTHomeSearchBgView()
/** 分割线 */
@property(strong, nonatomic) UILabel *lineLabel;

@end

@implementation CYTHomeSearchBgView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeSearchBgBasicConfig];
        [self initHomeSearchBgComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)homeSearchBgBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initHomeSearchBgComponents{
    [self addSubview:self.lineLabel];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(self);
    }];
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [UILabel dividerLineLabel];
        _lineLabel.hidden = YES;
    }
    return _lineLabel;
}
- (void)setShowDividerLine:(BOOL)showDividerLine{
    _showDividerLine = showDividerLine;
    self.lineLabel.hidden = !showDividerLine;
}
@end
