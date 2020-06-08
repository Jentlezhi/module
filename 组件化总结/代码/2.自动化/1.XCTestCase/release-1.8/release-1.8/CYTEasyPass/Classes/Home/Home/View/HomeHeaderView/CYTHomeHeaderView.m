//
//  CYTHomeHeaderView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeHeaderView.h"
#import "CYTHomeBannerView.h"
#import "CYTHomeToolBarView.h"
#import "CYTDealerRecommendView.h"
#import "CYTAdsInfoView.h"
#import "HomeConfig.h"

@interface CYTHomeHeaderView()

/** bannerView */
@property(strong, nonatomic) CYTHomeBannerView *bannerView;
/** 工具条 */
@property(strong, nonatomic) CYTHomeToolBarView *toolBarView;
/** 靠谱车商 */
@property(strong, nonatomic) CYTDealerRecommendView *dealerRecommendView;
/** 专区 */
@property(strong, nonatomic) CYTAdsInfoView *adsInfoView;

@end

@implementation CYTHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeHeaderViewBasicConfig];
        [self initHomeHeaderViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)homeHeaderViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initHomeHeaderViewComponents{
    [self addSubview:self.bannerView];
    [self addSubview:self.toolBarView];
    [self addSubview:self.dealerRecommendView];
    [self addSubview:self.adsInfoView];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
}

#pragma mark - 懒加载

- (CYTHomeBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[CYTHomeBannerView alloc] init];
        _bannerView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(kBannerViewHeightPixel));
        @weakify(self);
        _bannerView.imageClick = ^(NSString *url) {
            @strongify(self);
            !self.bannerImageClick?:self.bannerImageClick(url);
        };
    }
    return _bannerView;
}

- (CYTHomeToolBarView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[CYTHomeToolBarView alloc] init];
        _toolBarView.frame = CGRectMake(0, CGRectGetMaxY(self.bannerView.frame), kScreenWidth, CYTAutoLayoutV(kToolViewHeightPixel));
        @weakify(self);
        _toolBarView.toolBarClick = ^(CYTFunctionModel *functionModel) {
            @strongify(self);
            !self.functionItemClick?:self.functionItemClick(functionModel);
        };
    }
    return _toolBarView;
}

- (CYTDealerRecommendView *)dealerRecommendView{
    if (!_dealerRecommendView) {
        _dealerRecommendView = [[CYTDealerRecommendView alloc] init];
        _dealerRecommendView.frame =  CGRectMake(0, CGRectGetMaxY(self.toolBarView.frame) + CYTItemMarginV, kScreenWidth, CYTAutoLayoutV(kDealerRecommendViewHeightPixel));
    }
    return _dealerRecommendView;
}

- (CYTAdsInfoView *)adsInfoView{
    if (!_adsInfoView) {
        _adsInfoView = [[CYTAdsInfoView alloc] init];
        _adsInfoView.frame =  CGRectMake(0, CGRectGetMaxY(self.dealerRecommendView.frame) + CYTItemMarginV, kScreenWidth, CYTAutoLayoutV(kAdsInfoViewHeightPixel));
        @weakify(self);
        _adsInfoView.adsInfoClick = ^(CYTRecommendListModel *recommendListModel) {
            @strongify(self);
            !self.recommendClick?:self.recommendClick(recommendListModel);
        };
    }
    return _adsInfoView;
}

#pragma mark - setter方法

- (void)setBannerInfoLists:(NSArray *)bannerInfoLists{
    _bannerInfoLists = bannerInfoLists;
    self.bannerView.bannerInfoLists = bannerInfoLists;
}

- (void)setFunctionData:(NSArray *)functionData{
    _functionData = functionData;
    self.toolBarView.functionData = functionData;
}

- (void)setStoreAuthModels:(NSArray *)storeAuthModels{
    _storeAuthModels = storeAuthModels;
    self.dealerRecommendView.storeAuthModels = storeAuthModels;
}

- (void)setRecommendLists:(NSArray *)recommendLists{
    _recommendLists = recommendLists;
    self.adsInfoView.hidden = !recommendLists.count;
    self.adsInfoView.recommendLists = recommendLists;
}


@end
