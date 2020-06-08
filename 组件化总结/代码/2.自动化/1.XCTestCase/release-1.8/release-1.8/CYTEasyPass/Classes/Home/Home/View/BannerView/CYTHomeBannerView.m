//
//  CYTHomeBannerView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeBannerView.h"
#import "SDCycleScrollView.h"

@interface CYTHomeBannerView()<SDCycleScrollViewDelegate>

/** banner */
@property(strong, nonatomic) SDCycleScrollView *banner;
/** 蒙层 */
@property(strong, nonatomic) UIImageView *coverView;

@end


@implementation CYTHomeBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeBannerViewBasicConfig];
        [self initHomeBannerViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)homeBannerViewBasicConfig{
    self.backgroundColor = [UIColor redColor];
}
/**
 *  初始化子控件
 */
- (void)initHomeBannerViewComponents{
    //添加banner
    [self addSubview:self.banner];
    [self addSubview:self.coverView];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
}
#pragma mark - 懒加载

- (SDCycleScrollView *)banner{
    if (!_banner) {
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CYTAutoLayoutV(350)) delegate:self placeholderImage:nil];
        _banner.autoScroll = YES;
        _banner.currentPageDotImage = [UIImage imageNamed:@"ic_carousel_sel"];
        _banner.pageDotImage = [UIImage imageNamed:@"ic_carousel_unsel"];
        _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _banner.placeholderImage = [UIImage imageNamed:@"home_banner_placeholder"];
        _banner.hidesForSinglePage = YES;
    }
    return _banner;
}
- (UIImageView *)coverView{
    if (!_coverView) {
        _coverView = [UIImageView ff_imageViewWithImageName:@"home_bannerCover"];
        _coverView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CYTAutoLayoutV(350));
        _coverView.userInteractionEnabled = NO;
    }
    return _coverView;
}

#pragma mark - <SDCycleScrollViewDelegate>

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CYTBannerInfoModel *bannerInfoModel = self.bannerInfoLists[index];
    !self.imageClick?:self.imageClick(bannerInfoModel.pageLinkUrl);
}

- (void)setBannerInfoLists:(NSArray *)bannerInfoLists{
    _bannerInfoLists = bannerInfoLists;
    NSMutableArray *imageUrls = [NSMutableArray array];
    [bannerInfoLists enumerateObjectsUsingBlock:^(CYTBannerInfoModel *bannerInfoModel, NSUInteger idx, BOOL *  stop) {
        [imageUrls addObject:bannerInfoModel.bannerImageUrl];
    }];
    self.banner.autoScroll = YES;
    self.banner.imageURLStringsGroup = imageUrls;
}

@end
