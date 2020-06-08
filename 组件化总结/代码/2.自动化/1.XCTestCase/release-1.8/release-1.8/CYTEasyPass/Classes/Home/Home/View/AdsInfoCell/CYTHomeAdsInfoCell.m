//
//  CYTHomeAdsInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeAdsInfoCell.h"
#import "CYTRecommendListModel.h"

@interface CYTHomeAdsInfoCell()
/** 图片 */
@property(strong, nonatomic) UIImageView *adsInfoView;
@end

@implementation CYTHomeAdsInfoCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeToolBarBasicConfig];
        [self initHomeToolBarComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)homeToolBarBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initHomeToolBarComponents{
    //添加图片
    [self.contentView addSubview:self.adsInfoView];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.adsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(self.contentView);
    }];
}
#pragma mark - 懒加载

- (UIImageView *)adsInfoView{
    if (!_adsInfoView) {
        _adsInfoView = [[UIImageView alloc] init];
    }
    return _adsInfoView;
}

- (void)setRecommendListModel:(CYTRecommendListModel *)recommendListModel{
    _recommendListModel = recommendListModel;
    UIImage *placeHolderImage = [UIImage imageNamed:@"pic_300x170_nor"];
    [self.adsInfoView sd_setImageWithURL:[NSURL URLWithString:recommendListModel.imageUrl] placeholderImage:placeHolderImage];
}

@end
