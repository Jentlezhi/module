//
//  CYTPhotoCollectionView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageCollectionView.h"
#import "CYTImageCollectionViewCell.h"
#import "CYTImageAssetManager.h"
#import "CYTIndicatorView.h"
#import "CYTSelectImageModel.h"
#import "CYTImagePickerNavController.h"
#import "CYTAlbumModel.h"
#import "CYTPhotoBrowseViewController.h"
#import "CYTImageCompresser.h"

static NSString *const cellIdentifier = @"CYTImageCollectionViewCell";

@interface CYTImageCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 布局 */
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 图片表格 */
@property(strong, nonatomic) UICollectionView *photoCollectionView;
/** 相册资源模型 */
@property(strong, nonatomic) NSMutableArray <CYTSelectImageModel *>*albumModels;
//cell点击的回调
/** 添加按钮的点击 */
@property(copy, nonatomic) void(^addImageAction)();
/** 删除按钮的点击 */
@property(copy, nonatomic) void(^deleteImageAction)(CYTSelectImageModel *imageModel);


@end

@implementation CYTImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self imageCollectionViewBasicConfig];
        [self initImageCollectionViewComponents];
        [self configLayout];
        [self makeConstrains];
    }
    return  self;
}



#pragma mark - 基本设置
/**
 *  基本配置
 */
- (void)imageCollectionViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initImageCollectionViewComponents{
    //添加collectionView
    [self addSubview:self.photoCollectionView];
    
}
/**
 *  配置布局
 */
- (void)configLayout{
    //设置布局属性
    self.layout.minimumLineSpacing = self.itemMargin;
    self.layout.minimumInteritemSpacing = self.itemMargin;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWH = (self.bounds.size.width - self.leftRightMargin * 2 - (self.eachLineNum - 1)*self.itemMargin)/self.eachLineNum;
    self.layout.itemSize = CGSizeMake(itemWH, itemWH);
    //设置边角间隔 UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
    extern CGFloat deleteBtnWH;
    self.photoCollectionView.contentInset = UIEdgeInsetsMake(self.topBottomMargin - CYTAutoLayoutV(deleteBtnWH) *0.5f, self.leftRightMargin, self.topBottomMargin*2, self.leftRightMargin);
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
#pragma mark - 属性设置

- (CGFloat)itemMargin{
    if (_itemMargin <= 0) {
        return CYTAutoLayoutV(5);
    }
    return _itemMargin;
}

- (CGFloat)topBottomMargin{
    if (_topBottomMargin <= 0) {
        return CYTMarginV;
    }
    return _topBottomMargin;
}

- (CGFloat)leftRightMargin{
    if (_leftRightMargin <= 0) {
        return CYTMarginH;
    }
    return _leftRightMargin;
}

- (NSInteger)eachLineNum{
    if (_eachLineNum <= 0) {
        return 5;
    }
    return _eachLineNum;
}

- (NSInteger)selectedMaxNum{
    if (_selectedMaxNum<=0) {
        return 9;
    }
    return _selectedMaxNum;
}
- (CGFloat)collectionViewHeight{
    extern CGFloat deleteBtnWH;
    NSInteger rowNum = self.albumModels.count/self.eachLineNum + 1;
    CGFloat top = self.topBottomMargin - CYTAutoLayoutV(deleteBtnWH) *0.5f;
    CGFloat bottom = self.topBottomMargin*2;
    CGFloat itemH = (kScreenWidth - self.leftRightMargin * 2 - (self.eachLineNum - 1)*self.itemMargin)/self.eachLineNum;
    CGFloat totalH = rowNum*(itemH+self.itemMargin);
    return top + bottom + totalH;
}
- (CGFloat)layoutHeight{
    extern CGFloat deleteBtnWH;
    CGFloat itemMargin = self.itemMargin;
    CGFloat itemH = (kScreenWidth - self.leftRightMargin * 2 - (self.eachLineNum - 1)*self.itemMargin)/self.eachLineNum;
    NSInteger   addRowNum = self.albumModels.count/self.eachLineNum;
    return addRowNum?(itemMargin + itemH)*addRowNum:0;
}

#pragma mark - 懒加载

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}
- (UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_photoCollectionView registerClass:[CYTImageCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _photoCollectionView.backgroundColor = [UIColor clearColor];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.pagingEnabled = NO;
        _photoCollectionView.showsHorizontalScrollIndicator = NO;
        _photoCollectionView.alwaysBounceVertical = YES;
        _photoCollectionView.scrollEnabled = NO;
    }
    return _photoCollectionView;
}

- (NSMutableArray *)albumModels{
    if (!_albumModels) {
        _albumModels = [NSMutableArray array];
    }
    return _albumModels;
}

#pragma maek - 属性配置

- (NSMutableArray<CYTSelectImageModel *> *)selectedImageModels{
    return self.albumModels;
}

#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger albumModelsNum = self.albumModels.count;
    if (albumModelsNum == self.selectedMaxNum) {
        return albumModelsNum;
    }else{
        return albumModelsNum + 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    CYTSelectImageModel *selectImageModel = indexPath.item < self.albumModels.count ? self.albumModels[indexPath.item] : nil;
    NSUInteger lastIndex = self.albumModels.count;
    if (lastIndex == indexPath.item) {
        cell.addButton = YES;
    }else{
        cell.addButton = NO;
        cell.selectImageModel = selectImageModel;
    }
    
    cell.addImageAction = self.addImageAction;
    cell.deleteImageAction = self.deleteImageAction;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.albumModels enumerateObjectsUsingBlock:^(CYTSelectImageModel * _Nonnull selectImageModel, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *cellImageView = ((CYTImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]]).imageView;
        selectImageModel.prviewFrame = [cellImageView convertRect:cellImageView.bounds toView:nil];
        selectImageModel.prviewImage = cellImageView.image;
    }];
    CYTPhotoBrowseViewController *photoBrowseViewController = [[CYTPhotoBrowseViewController alloc] initWithShowAnimation:YES];
    photoBrowseViewController.selectImageModels = self.albumModels;
    photoBrowseViewController.photoIndex = indexPath.item;
    [photoBrowseViewController showPhotoBrowseViewWithAnimation];
}


#pragma mark - cell的点击
/**
 *  添加按钮的点击
 */
- (void (^)())addImageAction{
    CYTWeakSelf
    return ^{
        [CYTAlertView selectPhotoAlertWithTakePhoto:^(UIAlertAction * _Nullable action) {
            [weakSelf selectImagFromCamera];
        } album:^(UIAlertAction * _Nullable action) {
            [weakSelf selectImagFromAlbum];
        }];
    };
}
/**
 *  删除按钮的点击
 */
- (void (^)(CYTSelectImageModel *))deleteImageAction{
    CYTWeakSelf
    return ^(CYTSelectImageModel *imageModel) {
        NSInteger index = [weakSelf.albumModels indexOfObject:imageModel];
        [weakSelf.albumModels removeObjectAtIndex:index];
        !weakSelf.reLayout?:weakSelf.reLayout();
        [weakSelf.photoCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
    };
}

/**
 *  相机选取照片
 */
- (void)selectImagFromCamera{
    CYTWeakSelf
    CYTImageAssetManager *imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditNavBar inView:self];
    });
    [imageAssetManager fetchCareraImage];
    __weak typeof(imageAssetManager) weakImageAssetManager = imageAssetManager;
    imageAssetManager.imagePickerDeallocBlock = ^{
        if (weakImageAssetManager.cameraImageBlock) {
            [CYTIndicatorView hideIndicatorView];
        }
    };
    imageAssetManager.cameraImageBlock = ^(UIImage *cameraImage) {
        CYTSelectImageModel *selectImageModel = [[CYTSelectImageModel alloc] init];
        selectImageModel.image = [[cameraImage compressedToSize:kImageCompressedMaxSize] fixOrientation];
        [weakSelf.albumModels addObject:selectImageModel];
        [CYTIndicatorView hideIndicatorView];
        !weakSelf.reLayout?:weakSelf.reLayout();
        [weakSelf.photoCollectionView reloadData];
    };
}
/**
 *  相册选取照片
 */
- (void)selectImagFromAlbum{
    CYTWeakSelf
    NSUInteger albumSeleMaxNum = self.selectedMaxNum - self.albumModels.count;
    CYTImagePickerNavController *imagePickerNavController = [CYTImagePickerNavController pickerNavControllerWithMaxSelectNum:albumSeleMaxNum eachLineNum:4];
    imagePickerNavController.modalPresentationStyle = UIModalPresentationCustom;
    imagePickerNavController.completeAction = ^(NSArray<CYTAlbumModel *> *albumModels) {
        [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditNavBar];
        [albumModels enumerateObjectsUsingBlock:^(CYTAlbumModel * _Nonnull albumModel, NSUInteger idx, BOOL * _Nonnull stop) {
            CYTSelectImageModel *imageModel = [[CYTSelectImageModel alloc] init];
            imageModel.asset = albumModel.asset;
            [weakSelf.albumModels addObject:imageModel];
        }];
        [CYTIndicatorView hideIndicatorView];
        !weakSelf.reLayout?:weakSelf.reLayout();
        [weakSelf.photoCollectionView reloadData];
    };
    [[CYTCommonTool currentViewController] presentViewController:imagePickerNavController animated:YES completion:nil];
}
@end
