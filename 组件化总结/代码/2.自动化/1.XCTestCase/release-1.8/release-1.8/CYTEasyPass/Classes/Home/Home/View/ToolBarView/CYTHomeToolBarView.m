//
//  CYTHomeToolBarView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeToolBarView.h"
#import "CYTHomeToolBarCell.h"

static const NSString *identifier = @"CYTHomeToolBarCell";

@interface CYTHomeToolBarView()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 布局 */
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 表格 */
@property(strong, nonatomic) UICollectionView *toolBarCollectionView;

@end

@implementation CYTHomeToolBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeToolBarBasicConfig];
        [self initHomeToolBarViewComponents];
        [self configToolBarCollectionView];
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
- (void)initHomeToolBarViewComponents{
    [self addSubview:self.toolBarCollectionView];
    [self.toolBarCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
/**
 *  配置表格
 */
- (void)configToolBarCollectionView{
    
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
        _layout.itemSize = CGSizeMake(CYTAutoLayoutV(106+32*2), CYTAutoLayoutV(150.f));
        _layout.minimumLineSpacing = 0.f;
        _layout.minimumInteritemSpacing = 0.f;
    }
    return _layout;
}
- (UICollectionView *)toolBarCollectionView{
    if (!_toolBarCollectionView) {
        _toolBarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _toolBarCollectionView.backgroundColor = [UIColor clearColor];
        _toolBarCollectionView.delegate = self;
        _toolBarCollectionView.dataSource = self;
        _toolBarCollectionView.pagingEnabled = NO;
        _toolBarCollectionView.bounces = YES;
        _toolBarCollectionView.showsHorizontalScrollIndicator = NO;
        [_toolBarCollectionView registerClass:[CYTHomeToolBarCell class] forCellWithReuseIdentifier:identifier];
    }
    return _toolBarCollectionView;
}
#pragma mark - <UICollectionViewDateSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.functionData.count?self.functionData.count:5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTFunctionModel *indexFunctionModel = self.functionData[indexPath.item];
    CYTHomeToolBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.indexFunctionModel = indexFunctionModel;
    return cell;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTFunctionModel *functionModel = self.functionData[indexPath.item];
    !self.toolBarClick?:self.toolBarClick(functionModel);
}

- (void)setFunctionData:(NSArray *)functionData{
    _functionData = functionData;
    [self.toolBarCollectionView reloadData];
}

@end
