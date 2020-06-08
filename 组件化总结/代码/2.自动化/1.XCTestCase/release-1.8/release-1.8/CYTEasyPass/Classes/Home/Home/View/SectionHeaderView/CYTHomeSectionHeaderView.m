//
//  CYTHomeSectionHeaderView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeSectionHeaderView.h"

@interface CYTHomeSectionHeaderView()
/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
@end

@implementation CYTHomeSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeSectionHeaderBasicConfig];
        [self initHomeSectionHeaderViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)homeSectionHeaderBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initHomeSectionHeaderViewComponents{
    [self addSubview:self.titleLabel];
    [self addSubview:self.dividerLine];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTItemMarginH);
    }];
    
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
}
#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    }
    return _titleLabel;
}

- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
