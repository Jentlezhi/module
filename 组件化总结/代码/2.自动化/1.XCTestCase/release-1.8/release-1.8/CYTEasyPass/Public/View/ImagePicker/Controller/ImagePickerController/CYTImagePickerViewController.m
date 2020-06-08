//
//  CYTImagePickerController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImagePickerViewController.h"
#import "CYTImageAssetCell.h"
#import "CYTImageAssetManager.h"
#import "CYTAssetModel.h"
#import "CYTAlbumModel.h"
#import "CYTAlbumsListViewController.h"
#import "CYTImagePickToolBarView.h"
#import "CYTSelectedArrayModel.h"
#import "CYTPhotoBrowseViewController.h"
#import "CYT3DPriviewController.h"


static NSString *const identifier = @"CYTImageAssetCell";

@interface CYTImagePickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerPreviewingDelegate>

/** 布局 */
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 图片表格 */
@property(strong, nonatomic) UICollectionView *imageAssetCollectionView;
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;
/** 资源模型 */
@property(strong, nonatomic) NSMutableArray <CYTAlbumModel *>*albumModels;
/** 已选中模型 */
@property(strong, nonatomic) CYTSelectedArrayModel *selectedArrayModel;
/** 底部工具条 */
@property(strong, nonatomic) CYTImagePickToolBarView *toolBarView;
/** 是否已选到最大值 */
@property(assign, nonatomic) BOOL reachMaxSelectValue;
/** 操作：添加/移除 */
@property(assign, nonatomic) BOOL addImageOperation;
/** 选择按钮回调 */
@property(copy, nonatomic) void(^selectAction)(CYTAlbumModel *albumModel,BOOL selected);
@end

@implementation CYTImagePickerViewController
{
    CYTSelectedArrayModel *_selectedArrayModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imagePickerBasicConfig];
    [self initImagePickerComponents];
    [self configLayout];
    [self loadImageAsset];
    [self makeConstrains];
    [self observeSelectedModels];
}

#pragma mark - 基本设置
/**
 *  基本配置
 */
- (void)imagePickerBasicConfig{
    [self createNavBarWithTitle:@"所有照片" andShowBackButton:YES showRightButtonWithTitle:@"取消"];
}
/**
 *  初始化子控件
 */
- (void)initImagePickerComponents{
    //添加collectionView
    [self.view insertSubview:self.imageAssetCollectionView belowSubview:self.navigationZone];
    //添加工具条
    [self.view addSubview:self.toolBarView];
}
/**
 *  返回操作
 */
- (void)backButtonClick:(UIButton *)backButton{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  取消操作
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  配置布局
 */
- (void)configLayout{
    //设置布局属性
    self.layout.minimumLineSpacing = self.itemMargin;
    self.layout.minimumInteritemSpacing = self.itemMargin;
    CGFloat itemWH = (self.view.bounds.size.width - (self.eachLineNum + 1) * self.itemMargin) / self.eachLineNum;
    self.layout.itemSize = CGSizeMake(itemWH, itemWH);
    //设置边角间隔
    self.imageAssetCollectionView.contentInset = UIEdgeInsetsMake(self.itemMargin + CYTViewOriginY, self.itemMargin, self.itemMargin + CYTAutoLayoutV(110.f), self.itemMargin);
}

#pragma mark - 懒加载

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}
- (UICollectionView *)imageAssetCollectionView{
    if (!_imageAssetCollectionView) {
        CGRect AssetCollectionViewFrame = self.view.bounds;
        _imageAssetCollectionView = [[UICollectionView alloc] initWithFrame:AssetCollectionViewFrame collectionViewLayout:self.layout];
        [_imageAssetCollectionView registerClass:[CYTImageAssetCell class] forCellWithReuseIdentifier:identifier];
        _imageAssetCollectionView.backgroundColor = [UIColor clearColor];
        _imageAssetCollectionView.delegate = self;
        _imageAssetCollectionView.dataSource = self;
        _imageAssetCollectionView.pagingEnabled = NO;
        _imageAssetCollectionView.showsHorizontalScrollIndicator = NO;
        _imageAssetCollectionView.alwaysBounceVertical = YES;
    }
    return _imageAssetCollectionView;
}

- (CYTImageAssetManager *)imageAssetManager{
    if (!_imageAssetManager) {
        _imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    }
    return _imageAssetManager;
}

- (NSMutableArray *)albumModels{
    if (!_albumModels) {
        _albumModels = [NSMutableArray array];
    }
    return _albumModels;
}

- (void (^)(CYTAlbumModel *, BOOL))selectAction{
    CYTWeakSelf
    NSMutableArray *selectedModels = [weakSelf.selectedArrayModel mutableArrayValueForKeyPath:@"selectedModels"];
    return ^(CYTAlbumModel *albumModel,BOOL selected) {
        if (selected) {
            albumModel.showCoverView = NO;
            albumModel.selected = YES;
            weakSelf.addImageOperation = YES;
            [selectedModels addObject:albumModel];
        }else{
            albumModel.showCoverView = YES;
            albumModel.selected = NO;
            weakSelf.addImageOperation = NO;
            if ([selectedModels containsObject:albumModel]) {
                ;
                [selectedModels removeObject:albumModel];
            }
        }
    };

}

- (UIView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[CYTImagePickToolBarView alloc] init];
        _toolBarView.maxSelectNum = self.selectedMaxNum;
        CYTWeakSelf
        _toolBarView.previewAction = ^{
            [weakSelf previewSelectPhoto];
        };
        _toolBarView.doupleTapAction = ^{
            NSUInteger lastItem = weakSelf.albumModels.count > 0 ? weakSelf.albumModels.count - 1 : 0;
            [weakSelf scrollToItem:lastItem animated:YES];
        };
        
        _toolBarView.completeAction = ^{
            !weakSelf.completeAction?:weakSelf.completeAction([weakSelf complatonAlbumModels]);
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _toolBarView;
}
/**
 *  回调的模型集合
 */
- (NSMutableArray *)complatonAlbumModels{
    return [self.selectedArrayModel.selectedModels mutableCopy];
}

- (void)previewSelectPhoto{
    CYTPhotoBrowseViewController *photoBrowseViewController = [[CYTPhotoBrowseViewController alloc] init];
    photoBrowseViewController.albumModels = [self complatonAlbumModels];
    photoBrowseViewController.photoIndex = 0;
    photoBrowseViewController.showAnimation = NO;
    self.navigationController.navigationBar.alpha = 0.f;
    [self presentViewController:photoBrowseViewController animated:YES completion:nil];
}

- (CYTSelectedArrayModel *)selectedArrayModel{
    if (!_selectedArrayModel) {
        _selectedArrayModel = [[CYTSelectedArrayModel alloc] init];
    }
    return _selectedArrayModel;
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(110.f));
    }];
}

#pragma mark - 加载图片资源

- (void)loadImageAsset{
    BOOL firstLoad = self.assetModel.albumModels.count <= 0;
    __block NSMutableArray *albumModeArray = [NSMutableArray array];
    if (firstLoad) {
        [self.imageAssetManager fetchSmartAlbumsWithAssetType:CYTAssetTypeAll completion:^(CYTAssetModel *assetModel) {
            if (assetModel.albumsTitle.length) {
                self.navTitle = assetModel.albumsTitle;
            }
            albumModeArray = [assetModel.albumModels copy];
        }];
    }else{
        if (self.assetModel.albumsTitle.length) {
            self.navTitle = self.assetModel.albumsTitle;
        }
        albumModeArray = [self.assetModel.albumModels copy];
    }
    self.albumModels = [albumModeArray mutableCopy];
    [self.imageAssetCollectionView reloadData];
    NSUInteger lastItem = self.albumModels.count > 0 ? self.albumModels.count - 1 : 0;
    [self scrollToItem:lastItem animated:NO];

}

#pragma mark - 属性设置

- (CGFloat)itemMargin{
    if (_itemMargin <= 0) {
        return CYTAutoLayoutV(6.f);
    }
    return _itemMargin;
}

- (NSInteger)eachLineNum{
    if (_eachLineNum <= 0) {
        return 4;
    }
    return _eachLineNum;
}

- (NSInteger)selectedMaxNum{
    if (_selectedMaxNum <= 0) {
        return 9;
    }
    return _selectedMaxNum;
}
- (void)setReachMaxSelectValue:(BOOL)reachMaxSelectValue{
    _reachMaxSelectValue = reachMaxSelectValue;
    [CATransaction begin];
    [self.imageAssetCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [CATransaction setDisableActions:NO];
}



#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.albumModels.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTImageAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    CYTAlbumModel *albumModel = self.albumModels[indexPath.item];
    albumModel.eachLineNum = self.eachLineNum;
    albumModel.reachMaxSelectValue = self.reachMaxSelectValue;
    cell.selectAction = self.selectAction;
    cell.albumModel = albumModel;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTAlbumModel *albumModel = self.albumModels[indexPath.item];
    if (albumModel.showCoverView && self.reachMaxSelectValue){
        return NO;
    }
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.albumModels enumerateObjectsUsingBlock:^(CYTAlbumModel * _Nonnull albumModel, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *cellImageView = ((CYTImageAssetCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]]).itemImageView;
        albumModel.prviewFrame = [cellImageView convertRect:cellImageView.bounds toView:kWindow];
        albumModel.prviewImage = cellImageView.image;
    }];
    CYTPhotoBrowseViewController *photoBrowseViewController = [[CYTPhotoBrowseViewController alloc] init];
    photoBrowseViewController.showAnimation = YES;
    photoBrowseViewController.albumModels = [self.albumModels copy];
    photoBrowseViewController.photoIndex = indexPath.item;
    [photoBrowseViewController showPhotoBrowseViewWithAnimation];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CYTImageAssetCell *imageAssetCell = (CYTImageAssetCell *)cell;
    if ([self respondsToSelector:@selector(traitCollection)]){
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]){
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
                imageAssetCell.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:imageAssetCell];
                imageAssetCell.firstRegisterPreview = YES;
            }
        }
    }
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    CYTImageAssetCell *imageAssetCell = (CYTImageAssetCell *)cell;
    if (imageAssetCell.firstRegisterPreview) {
        [self unregisterForPreviewingWithContext:imageAssetCell.previewingContext];
        imageAssetCell.previewingContext = nil;
        imageAssetCell.firstRegisterPreview = NO;
    }
}


#pragma mark - 其他配置

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0.0f;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.alpha = 0.0f;
}
- (void)scrollToItem:(NSUInteger)item animated:(BOOL)animated{
    if (!item) return;
    [self.imageAssetCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:animated];
}

- (void)observeSelectedModels{
    @weakify(self)
    [RACObserve(self.selectedArrayModel, selectedModels) subscribeNext:^(CYTSelectedArrayModel *selectedArrayModel) {
        @strongify(self)
        NSInteger selectedNum = self.selectedArrayModel.selectedModels.count;
        self.toolBarView.selectNum = selectedNum;
        if (selectedNum >= self.selectedMaxNum) {
            self.reachMaxSelectValue = YES;
        }else if (selectedNum == self.selectedMaxNum - 1){
            if (!self.addImageOperation ) {
                self.reachMaxSelectValue = NO;
            }
        }
        if (selectedNum > 0) {
            self.toolBarView.previewBtnEnable = YES;
            self.toolBarView.completeBtnEnable = YES;
        }else{
            self.toolBarView.previewBtnEnable = NO;
            self.toolBarView.completeBtnEnable = NO;
        }
    }];
}

#pragma mark - <UIViewControllerPreviewingDelegate>

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    CYT3DPriviewController *priviewController = [[CYT3DPriviewController alloc] init];
    CYTImageAssetCell *imageAssetCell = (CYTImageAssetCell *)[previewingContext sourceView];
    NSIndexPath *previewIndexPath = [self.imageAssetCollectionView indexPathForCell:imageAssetCell];
    CYTAlbumModel *albumModel = self.albumModels[previewIndexPath.item];
    if (albumModel.showCoverView && self.reachMaxSelectValue) return nil;
    UIImageView *cellImageView = ((CYTImageAssetCell *)[self.imageAssetCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:previewIndexPath.item inSection:0]]).itemImageView;
    albumModel.prviewFrame = [cellImageView convertRect:cellImageView.bounds toView:nil];
    albumModel.prviewImage = cellImageView.image;
    priviewController.albumModel = albumModel;
    return priviewController;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    CYT3DPriviewController *commitVc = (CYT3DPriviewController *)viewControllerToCommit;
    commitVc.view.frame = [UIScreen mainScreen].bounds;
    viewControllerToCommit.view.backgroundColor = [UIColor blackColor];
    [commitVc showPhotoBrowserViewWithAnimation];
}



@end
