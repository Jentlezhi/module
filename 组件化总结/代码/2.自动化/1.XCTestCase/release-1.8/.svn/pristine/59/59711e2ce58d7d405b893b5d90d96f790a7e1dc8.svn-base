//
//  CYTPhotoCollectionViewCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageCollectionViewCell.h"
#import "CYTSelectImageModel.h"
#import "CYTImageAssetManager.h"

CGFloat deleteBtnWH  = 32.f;

@interface CYTImageCollectionViewCell()

/** 添加按钮背景 */
@property(strong, nonatomic) UIImageView *addImagebgView;
/** 删除按钮 */
@property(strong, nonatomic) UIButton *deleteBtn;
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;
/** 图片标识 */
@property(copy, nonatomic)   NSString *representedAssetIdentifier;
/** 图片请求标识 */
@property(assign, nonatomic) PHImageRequestID imageRequestID;

@end

@implementation CYTImageCollectionViewCell

#pragma mark - 基本设置

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self photoCollectionViewCellBasicConfig];
        [self initPhotoCollectionViewCellComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)photoCollectionViewCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.imageAssetManager = [CYTImageAssetManager sharedAssetManager];
}
/**
 *  初始化子控件
 */
- (void)initPhotoCollectionViewCellComponents{
    //添加背景
    [self.contentView addSubview:self.addImagebgView];
    //添加图片
    [self.contentView addSubview:self.imageView];
    //添加按钮
    [self.contentView addSubview:self.deleteBtn];
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [self.addImagebgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(CYTAutoLayoutV(deleteBtnWH)*0.5f, 0, 0, CYTAutoLayoutV(deleteBtnWH)*0.5f));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(deleteBtnWH));
        make.top.right.equalTo(self.contentView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(CYTAutoLayoutV(deleteBtnWH)*0.5f, 0, 0, CYTAutoLayoutV(deleteBtnWH)*0.5f));
    }];
}

#pragma mark - 属性设置


#pragma mark - 懒加载

- (UIImageView *)addImagebgView{
    if (!_addImagebgView) {
        CYTWeakSelf
        _addImagebgView = [[UIImageView alloc] init];
        _addImagebgView.userInteractionEnabled = YES;
        _addImagebgView.image = [UIImage imageNamed:@"bg_add_dl"];
        [_addImagebgView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.addImageAction?:weakSelf.addImageAction();
        }];
    }
    return _addImagebgView;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        CYTWeakSelf
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.adjustsImageWhenHighlighted = NO;
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
        [[_deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !weakSelf.deleteImageAction?:weakSelf.deleteImageAction(weakSelf.selectImageModel);
        }];
    }
    return _deleteBtn;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

#pragma mark - setter方法

- (void)setAddButton:(BOOL)addButton{
    _addButton = addButton;
    if (addButton) {
        self.addImagebgView.hidden = NO;
        self.imageView.hidden =  self.deleteBtn.hidden = YES;
    }else{
        self.addImagebgView.hidden = YES;
        self.imageView.hidden =  self.deleteBtn.hidden = NO;
    }
}

- (void)setSelectImageModel:(CYTSelectImageModel *)selectImageModel{
    _selectImageModel = selectImageModel;
    if (selectImageModel.image) {
        self.imageView.image = selectImageModel.image;
    }else{
        CYTWeakSelf
        NSString *localIdentifier = selectImageModel.asset.localIdentifier;
        self.representedAssetIdentifier = localIdentifier;
        PHImageRequestID imageRequestID = [self.imageAssetManager fetchImageWithAsset:selectImageModel.asset imageWidth:self.contentView.bounds.size.width allowLoadFromiCloud:NO completion:^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
            if ([weakSelf.representedAssetIdentifier isEqualToString:localIdentifier]) {
                self.imageView.image = image;
            } else {
                [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
            }
            if (!isDegraded) {
                self.imageRequestID = 0;
            }
        }];
        if (imageRequestID && self.imageRequestID && imageRequestID != self.imageRequestID) {
            [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        }
        self.imageRequestID = imageRequestID;
    }
}

@end
