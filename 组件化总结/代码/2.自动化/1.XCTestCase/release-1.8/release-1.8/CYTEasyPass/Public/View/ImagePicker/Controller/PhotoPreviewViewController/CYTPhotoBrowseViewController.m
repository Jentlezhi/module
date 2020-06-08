//
//  CYTPhotoBrowseViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhotoBrowseViewController.h"
#import "CYTPhotoBrowserCell.h"
#import "CYTAlbumModel.h"
#import "CYTSelectImageModel.h"

static NSString *const identifier = @"CYTPhotoBrowserCell";
NSString *kBackBtnClickNotification = @"kBackBtnClickNotification";

@interface CYTPhotoBrowseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UIViewControllerPreviewingDelegate>

/** 布局 */
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 图片表格 */
@property(strong, nonatomic) UICollectionView *photoBrowserCollectionView;
/** 总图片数 */
@property(assign, nonatomic) NSUInteger photoTotalNum;

@end

@implementation CYTPhotoBrowseViewController

- (void)showPhotoBrowseViewWithAnimation{
    self.showAnimation = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}

- (instancetype)initWithShowAnimation:(BOOL)animation{
    if (self = [super init]) {
        self.showAnimation = animation;
        [self photoBrowserBasicConfig];
        [self initPhotoBrowserComponents];
        [self configLayout];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.statusBarStyle = CYTStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self photoBrowserBasicConfig];
    [self initPhotoBrowserComponents];
    [self configLayout];
}
#pragma mark - 基本设置
/**
 *  基本配置
 */
- (void)photoBrowserBasicConfig{
    self.view.backgroundColor = [UIColor blackColor];
    [self createNavBarWithBackButtonAndTitle:nil];
    self.navigationBarColor = [UIColor clearColor];
    self.backBtnColor = [UIColor whiteColor];
    self.navTitleColor = [UIColor whiteColor];
    self.navTitle = [NSString stringWithFormat:@"%lu/%ld",self.photoIndex+1,self.photoTotalNum];
}
/**
 *  初始化子控件
 */
- (void)initPhotoBrowserComponents{
    //添加collectionView
    [self.view insertSubview:self.photoBrowserCollectionView belowSubview:self.navigationZone];
    [self.photoBrowserCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
}
/**
 *  配置布局
 */
- (void)configLayout{
    //设置布局属性
    self.layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    self.layout.minimumLineSpacing = 0.f;
    self.layout.minimumInteritemSpacing = 0.f;
    
}

- (void)backButtonClick:(UIButton *)backButton{
    self.statusBarStyle = CYTStatusBarStyleDefault;
    if (self.showAnimation) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kBackBtnClickNotification object:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - 属性设置

- (void)setPhotoIndex:(NSUInteger)photoIndex{
    _photoIndex = photoIndex;
    NSUInteger itemNum = self.albumModels.count;
    //设置标题索引
    self.navTitle = [NSString stringWithFormat:@"%ld/%ld",photoIndex+1,itemNum];
    //定位到点击图片位置
    [self.view layoutIfNeeded];
    if (photoIndex > itemNum - 1 || photoIndex <= 0) return;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:photoIndex inSection:0];
    [self.photoBrowserCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)setSelectImageModels:(NSArray<CYTSelectImageModel *> *)selectImageModels{
    _selectImageModels = selectImageModels;
    self.navTitle = [NSString stringWithFormat:@"%ld/%ld",self.photoIndex+1,selectImageModels.count];
    [selectImageModels enumerateObjectsUsingBlock:^(CYTSelectImageModel * _Nonnull selectImageModel, NSUInteger idx, BOOL * _Nonnull stop) {
        CYTAlbumModel *albumModel = [[CYTAlbumModel alloc] init];
        albumModel.asset = selectImageModel.asset;
        albumModel.cameraImage = selectImageModel.image;
        albumModel.prviewFrame = selectImageModel.prviewFrame;
        albumModel.prviewImage = selectImageModel.prviewImage;
        albumModel.imageURL = selectImageModel.imageURL;
        [self.albumModels addObject:albumModel];
    }];
}

- (NSUInteger)photoTotalNum{
    return self.albumModels.count;
}

#pragma mark - 懒加载

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}
- (UICollectionView *)photoBrowserCollectionView{
    if (!_photoBrowserCollectionView) {
        _photoBrowserCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _photoBrowserCollectionView.backgroundColor = [UIColor clearColor];
        _photoBrowserCollectionView.delegate = self;
        _photoBrowserCollectionView.dataSource = self;
        _photoBrowserCollectionView.pagingEnabled = YES;
        _photoBrowserCollectionView.bounces = NO;
        _photoBrowserCollectionView.showsHorizontalScrollIndicator = NO;
        [_photoBrowserCollectionView registerClass:[CYTPhotoBrowserCell class] forCellWithReuseIdentifier:identifier];
    }
    return _photoBrowserCollectionView;
}

- (NSMutableArray *)albumModels{
    if (!_albumModels) {
        _albumModels = [NSMutableArray array];
    }
    return _albumModels;
}

#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.albumModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
   CYTPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    CYTAlbumModel *albumModel = self.albumModels[indexPath.item];
    
    if (self.photoIndex == indexPath.item){
        albumModel.showAnimation = self.showAnimation;
    }else{
       albumModel.showAnimation = NO;
    }
    cell.albumModel = albumModel;
    cell.setControllerViewColor = ^{
        [UIView animateWithDuration:0.25f animations:^{
            weakSelf.view.backgroundColor = [UIColor clearColor];
        }];
    };
    cell.dismissController = ^{
        [weakSelf.view removeFromSuperview];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    cell.signalTapClick = ^{
        weakSelf.navigationZone.alpha = 0.f;
        [weakSelf backButtonClick:nil];
    };
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger currentIndex = (int)(scrollView.contentOffset.x/kScreenWidth + 0.5) + 1;
    self.navTitle = [NSString stringWithFormat:@"%ld/%ld",currentIndex,self.photoTotalNum];
}



@end
