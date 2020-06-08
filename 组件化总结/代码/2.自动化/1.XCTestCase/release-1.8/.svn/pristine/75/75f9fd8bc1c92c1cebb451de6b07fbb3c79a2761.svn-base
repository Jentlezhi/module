//
//  CYTSelectedImageCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSelectedImageCell.h"
#import "CYTSelectImageModel.h"
#import "CYTImageAssetManager.h"

static NSString *const unselect = @"btn_chose_40_unsel";
static NSString *const selected = @"btn_chose_40_sel";

@interface CYTSelectedImageCell()

/** 选择标识 */
@property(strong, nonatomic) UIButton *selectBtn;
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;
/** 图片标识 */
@property(copy, nonatomic)   NSString *representedAssetIdentifier;
/** 图片请求标识 */
@property(assign, nonatomic) PHImageRequestID imageRequestID;
/** 扩大点击范围 */
@property(strong, nonatomic) UIView *enlargeClickView;

@end

@implementation CYTSelectedImageCell

#pragma mark - 基本设置

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self selectedImageBasicConfig];
        [self initSelectedImageComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)selectedImageBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    self.imageAssetManager.imageQuality = 0.9f;
}
/**
 *  初始化子控件
 */
- (void)initSelectedImageComponents{
    //添加图片
    [self.contentView addSubview:self.imageView];
    //添加按钮
    [self.contentView addSubview:self.selectBtn];
    //扩大点击范围
    [self.contentView addSubview:self.enlargeClickView];
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    CGFloat selectBtMargin = CYTAutoLayoutV(5.f);
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(40.f));
        make.right.bottom.offset(-selectBtMargin);
    }];
    [self.enlargeClickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(40.f)*1.7f);
        make.right.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - 属性设置


#pragma mark - 懒加载

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.image = [UIImage imageWithColor:[UIColor purpleColor]];
    }
    return _imageView;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.adjustsImageWhenDisabled = NO;
        _selectBtn.adjustsImageWhenHighlighted = NO;
        _selectBtn.hidden = YES;
        _selectBtn.originStatus = YES;
        [_selectBtn setBackgroundImage:[UIImage imageNamed:unselect] forState:UIControlStateNormal];
        CYTWeakSelf
        [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [weakSelf selectBtnClick];
        }];
    }
    return _selectBtn;
}

- (UIView *)enlargeClickView{
    if (!_enlargeClickView) {
        CYTWeakSelf
        _enlargeClickView = [[UIView alloc] init];
        _enlargeClickView.hidden = YES;
        _enlargeClickView.backgroundColor = [UIColor clearColor];
        [_enlargeClickView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
          [weakSelf selectBtnClick];
        }];
    }
    return _enlargeClickView;
}

- (void)selectBtnClick{
    NSString *selectBtnImage = [NSString string];
    if (_selectBtn.originStatus) {
        _selectBtn.originStatus = NO;
        selectBtnImage = selected;
    }else{
        _selectBtn.originStatus = YES;
        selectBtnImage = unselect;
    }
    [_selectBtn setBackgroundImage:[UIImage imageNamed:selectBtnImage] forState:UIControlStateNormal];
    !self.selectAction?:self.selectAction(self.selectImageModel,!_selectBtn.originStatus);
}



- (void)setAddButton:(BOOL)addButton{
    CYTWeakSelf
    _addButton = addButton;
    if (addButton) {
        _imageView.image = [UIImage imageNamed:@"bg_add_dl"];
        [_imageView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.addImageAction?:weakSelf.addImageAction();
        }];
        self.enlargeClickView.hidden = self.selectBtn.hidden = YES;
    }else{
//        _imageView.image = [UIImage imageWithColor:[UIColor clearColor]];
        _imageView.userInteractionEnabled = NO;
    }
}

- (void)setSelectImageModel:(CYTSelectImageModel *)selectImageModel{
    _selectImageModel = selectImageModel;
    self.enlargeClickView.hidden = self.selectBtn.hidden = !selectImageModel.editMode;
    [_selectBtn setBackgroundImage:[UIImage imageNamed:unselect] forState:UIControlStateNormal];
    [self setImageWithAlbumModel:selectImageModel];
}
/**
 *  设置图片
 */
- (void)setImageWithAlbumModel:(CYTSelectImageModel *)selectImageModel{
    CYTWeakSelf
    //编辑url
    if (selectImageModel.imageURL) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:selectImageModel.imageURL] placeholderImage:kPlaceholderImage];
    }else if (selectImageModel.image) {
        self.imageView.image = selectImageModel.image;
    }else{
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

#pragma mark - 配置




@end
