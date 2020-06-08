//
//  CYTDealerRecommendView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerRecommendView.h"
#import "CYTScrollMessageView.h"

@interface CYTDealerRecommendView()

/** 图标 */
@property(strong, nonatomic) UIImageView *icon;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
/** 滚动消息 */
@property(strong, nonatomic) CYTScrollMessageView *scrollMessageView;
/** 商家类型 */
@property(strong, nonatomic) UIButton *typeLabel;
/** 信息内容 */
@property(strong, nonatomic) UILabel *messageLabel;

@end

@implementation CYTDealerRecommendView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self dealerRecommendConfig];
        [self initDealerRecommendComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)dealerRecommendConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initDealerRecommendComponents{
    //添加图片
    [self addSubview:self.icon];
    //添加分割线
    [self addSubview:self.dividerLine];
    //添加滚动消息
    [self addSubview:self.scrollMessageView];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(CYTAutoLayoutH(142.f));
        make.height.equalTo(CYTAutoLayoutH(40.f));
        make.left.equalTo(CYTItemMarginH);
        make.centerY.equalTo(self);
    }];
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
        make.left.equalTo(self.icon.mas_right).offset(CYTMarginH);
        make.width.equalTo(CYTDividerLineWH);
    }];
    [self.scrollMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTItemMarginV);
        make.bottom.equalTo(-CYTItemMarginV);
        make.left.equalTo(self.dividerLine.mas_right).offset(CYTMarginH);
        make.right.equalTo(-CYTItemMarginV);
    }];
}
#pragma mark - 懒加载
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView imageViewWithImageName:@"pic_kaopu_nor"];
    }
    return _icon;
}
- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}
- (CYTScrollMessageView *)scrollMessageView{
    if (!_scrollMessageView) {
        _scrollMessageView = [[CYTScrollMessageView alloc] initWithFrame:CGRectZero];
    }
    return _scrollMessageView;
}

- (void)setStoreAuthModels:(NSArray *)storeAuthModels{
    _storeAuthModels = storeAuthModels;
    self.scrollMessageView.storeAuthModels = storeAuthModels;
}


@end
