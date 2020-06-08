//
//  CYTAdsInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAdsInfoView.h"
#import "CYTHomeAdsInfoCell.h"

static const NSString *identifier = @"CYTHomeAdsInfoCell";

@interface CYTAdsInfoView()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 布局 */
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 表格 */
@property(strong, nonatomic) UICollectionView *adsInfoCollectionView;

@end

@implementation CYTAdsInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self adsInfoViewBasicConfig];
        [self initAdsInfoViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)adsInfoViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initAdsInfoViewComponents{
    [self addSubview:self.adsInfoCollectionView];
    [self.adsInfoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
}

#pragma mark - 懒加载

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(CYTAutoLayoutV(300.f), CYTAutoLayoutV(170.f));
        _layout.minimumLineSpacing = 0.f;
        _layout.minimumInteritemSpacing = 0.f;
    }
    return _layout;
}
- (UICollectionView *)adsInfoCollectionView{
    if (!_adsInfoCollectionView) {
        _adsInfoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _adsInfoCollectionView.backgroundColor = [UIColor clearColor];
        _adsInfoCollectionView.delegate = self;
        _adsInfoCollectionView.dataSource = self;
        _adsInfoCollectionView.pagingEnabled = NO;
        _adsInfoCollectionView.bounces = YES;
        _adsInfoCollectionView.showsHorizontalScrollIndicator = NO;
        _adsInfoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, CYTItemMarginH);
        [_adsInfoCollectionView registerClass:[CYTHomeAdsInfoCell class] forCellWithReuseIdentifier:identifier];
    }
    return _adsInfoCollectionView;
}
#pragma mark - <UICollectionViewDateSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recommendLists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTHomeAdsInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.recommendListModel = self.recommendLists[indexPath.item];
    return cell;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTRecommendListModel *recommendListModel = self.recommendLists[indexPath.item];
    !self.adsInfoClick?:self.adsInfoClick(recommendListModel);
}

- (void)setRecommendLists:(NSArray *)recommendLists{
    _recommendLists = recommendLists;
    [self.adsInfoCollectionView reloadData];
}

@end
