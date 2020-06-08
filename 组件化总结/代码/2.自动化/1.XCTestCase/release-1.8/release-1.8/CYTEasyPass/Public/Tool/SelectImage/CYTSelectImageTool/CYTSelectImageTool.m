//
//  CYTSelectImageTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSelectImageTool.h"
#import "CYTSelectedImageCell.h"
#import "CYTAlbumModel.h"
#import "CYTSelectImageModel.h"
#import "CYTImagePickerNavController.h"
#import "CYTImageAssetManager.h"
#import "CYTCarSourceAddImageFooter.h"
#import "CYTPhotoBrowseViewController.h"
#import "CYTIndicatorView.h"
#import "CYTImageCompresser.h"

static NSString *const cellIdentifier = @"CYTSelectedImageCell";
static NSString *const footerIdentifier = @"CYTCarSourceAddImageFooter";

@interface CYTSelectImageTool()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 布局 */
@property(strong, nonatomic) UICollectionViewFlowLayout *layout;
/** 图片表格 */
@property(strong, nonatomic) UICollectionView *photoCollectionView;
/** 已选择相册资源模型 */
@property(strong, nonatomic) NSMutableArray <CYTSelectImageModel *>*selectedAlbumModels;
/** footer */
@property(strong, nonatomic) CYTCarSourceAddImageFooter *carSourceAddImageFooter;
/** 待删除图片 */
@property(strong, nonatomic) NSMutableArray *waitDeleteImageArray;

@end

@implementation CYTSelectImageTool

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self selectImageBasicConfig];
        [self iniSelectImageComponents];
        [self configLayout];
        [self makeConstrains];
    }
    return  self;
}

#pragma mark - 基本设置
/**
 *  基本配置
 */
- (void)selectImageBasicConfig{
    self.backgroundColor = [UIColor clearColor];

}
/**
 *  初始化子控件
 */
- (void)iniSelectImageComponents{
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
    self.layout.footerReferenceSize = CGSizeMake(0, CYTAutoLayoutV(180.f));
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWH = (self.bounds.size.width - self.leftRightMargin * 2 - (self.eachLineNum - 1)*self.itemMargin)/self.eachLineNum;
    self.layout.itemSize = CGSizeMake(itemWH, itemWH);
    //设置表格frame
    self.photoCollectionView.frame = self.bounds;
    //设置边角间隔 UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
    self.photoCollectionView.contentInset = UIEdgeInsetsMake(self.topBottomMargin, self.leftRightMargin, self.topBottomMargin, self.leftRightMargin);
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    
}
#pragma mark - 属性设置

- (void)setEditMode:(BOOL)editMode{
    _editMode = editMode;
    if (editMode) {
        self.carSourceAddImageFooter.btnTitle = @"删 除";
        [self.waitDeleteImageArray removeAllObjects];
    }else{
        self.carSourceAddImageFooter.btnTitle = @"完 成";
    }
    [self.photoCollectionView reloadData];
}

- (CGFloat)itemMargin{
    if (_itemMargin <= 0) {
        return CYTAutoLayoutV(6.f);
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
        return 3;
    }
    return _eachLineNum;
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
        [_photoCollectionView registerClass:[CYTSelectedImageCell class] forCellWithReuseIdentifier:cellIdentifier];
        [_photoCollectionView registerClass:[CYTCarSourceAddImageFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
        _photoCollectionView.backgroundColor = [UIColor clearColor];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.pagingEnabled = NO;
        _photoCollectionView.showsHorizontalScrollIndicator = NO;
        _photoCollectionView.alwaysBounceVertical = YES;
    }
    return _photoCollectionView;
}

- (NSMutableArray *)imageModels{
    if (!_imageModels) {
        _imageModels = [NSMutableArray array];
    }
    return _imageModels;
}

- (NSMutableArray *)selectedAlbumModels{
    if (!_selectedAlbumModels) {
        _selectedAlbumModels = [NSMutableArray array];
    }
    return _selectedAlbumModels;
}

- (NSMutableArray *)waitDeleteImageArray{
    if (!_waitDeleteImageArray) {
        _waitDeleteImageArray = [NSMutableArray array];
    }
    return _waitDeleteImageArray;
}

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
        [weakSelf.imageModels addObject:selectImageModel];
        [CYTIndicatorView hideIndicatorView];
        [weakSelf.photoCollectionView reloadData];
    };
}
/**
 *  相册选取照片
 */
- (void)selectImagFromAlbum{
    CYTWeakSelf
    NSUInteger albumSeleMaxNum = self.selectedMaxNum - self.imageModels.count;
    CYTImagePickerNavController *imagePickerNavController = [CYTImagePickerNavController pickerNavControllerWithMaxSelectNum:albumSeleMaxNum eachLineNum:4];
    imagePickerNavController.modalPresentationStyle = UIModalPresentationCustom;
    imagePickerNavController.completeAction = ^(NSArray<CYTAlbumModel *> *albumModels) {
        [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditNavBar];
        [albumModels enumerateObjectsUsingBlock:^(CYTAlbumModel * _Nonnull albumModel, NSUInteger idx, BOOL * _Nonnull stop) {
            CYTSelectImageModel *imageModel = [[CYTSelectImageModel alloc] init];
            imageModel.asset = albumModel.asset;
            [weakSelf.imageModels addObject:imageModel];
        }];
        [CYTIndicatorView hideIndicatorView];
        [weakSelf.photoCollectionView reloadData];
    };
    [[CYTCommonTool currentViewController] presentViewController:imagePickerNavController animated:YES completion:nil];

}

#pragma mark - <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
     CYTCarSourceAddImageFooter *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        CYTCarSourceAddImageFooter *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        self.carSourceAddImageFooter = footerView;
        self.carSourceAddImageFooter.completionAction = ^{
            !weakSelf.completion?:weakSelf.completion(weakSelf.imageModels);
        };
        self.carSourceAddImageFooter.deleteAction = ^{
            NSString *deleteTip = [NSString stringWithFormat:@"是否确认删除 %ld 张选中图片?",weakSelf.waitDeleteImageArray.count];
            [CYTAlertView alertViewWithTitle:@"提示" message:deleteTip confirmAction:^{
                !weakSelf.clickEditBtnBlock?:weakSelf.clickEditBtnBlock();
                [weakSelf.imageModels removeObjectsInArray:weakSelf.waitDeleteImageArray];
                if (weakSelf.imageModels.count == 0) {
                    weakSelf.editMode = NO;
                    !weakSelf.editAble?:weakSelf.editAble(NO);
                    !weakSelf.deleteEmpty?:weakSelf.deleteEmpty();
                }
                [weakSelf.waitDeleteImageArray removeAllObjects];
                [weakSelf.photoCollectionView reloadData];
            } cancelAction:nil];
        };
        reusableView = footerView;
    }
    return reusableView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSUInteger albumModelsNum = self.imageModels.count;
    !self.editAble?:self.editAble(albumModelsNum);
    if (self.editMode) {
        self.carSourceAddImageFooter.waitDeleteImageArray = self.waitDeleteImageArray;
    }else{
        self.carSourceAddImageFooter.selectedImageArray = self.imageModels;
    }
    if (albumModelsNum == self.selectedMaxNum || self.isEditMode) {
        return albumModelsNum;
    }else{
        return albumModelsNum + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CYTSelectedImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    CYTSelectImageModel *selectImageModel = indexPath.item < self.imageModels.count ? self.imageModels[indexPath.item] : nil;
    NSUInteger lastIndex = self.imageModels.count;
    if (lastIndex == indexPath.item) {
        cell.addButton = YES;
        selectImageModel.editMode = NO;
    }else{
        selectImageModel.editMode = self.editMode;
        cell.selectImageModel = selectImageModel;
        cell.addButton = NO;
    }
    cell.addImageAction = self.addImageAction;
    cell.selectAction = ^(CYTSelectImageModel *albumModel, BOOL selected) {
        if (selected) {
             [self.waitDeleteImageArray addObject:albumModel];
        }else{
            if ([self.waitDeleteImageArray containsObject:albumModel]) {
                [self.waitDeleteImageArray removeObject:albumModel];
            }
        }
        self.carSourceAddImageFooter.waitDeleteImageArray = self.waitDeleteImageArray;
    };
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.imageModels enumerateObjectsUsingBlock:^(CYTSelectImageModel * _Nonnull selectImageModel, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *cellImageView = ((CYTSelectedImageCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]]).imageView;
        selectImageModel.prviewFrame = [cellImageView convertRect:cellImageView.bounds toView:nil];
        selectImageModel.prviewImage = cellImageView.image;
    }];
    CYTPhotoBrowseViewController *photoBrowseViewController = [[CYTPhotoBrowseViewController alloc] initWithShowAnimation:YES];
    photoBrowseViewController.selectImageModels = self.imageModels;
    photoBrowseViewController.photoIndex = indexPath.item;
    [photoBrowseViewController showPhotoBrowseViewWithAnimation];

}

@end
