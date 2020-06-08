//
//  CYTImageAssetCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageAssetCell.h"
#import "CYTAlbumModel.h"
#import "CYTImageAssetManager.h"

static NSString *const unselect = @"btn_chose_40_unsel";
static NSString *const selected = @"btn_chose_40_sel";

@interface CYTImageAssetCell()

/** 选择标识 */
@property(strong, nonatomic) UIButton *selectBtn;
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;
/** 图片标识 */
@property(copy, nonatomic)   NSString *representedAssetIdentifier;
/** 图片请求标识 */
@property(assign, nonatomic) PHImageRequestID imageRequestID;
/** 不可选蒙层 */
@property(strong, nonatomic) UIView *coverVeiw;
/** 是否选中 */
@property(assign, nonatomic,getter=isImageSelected) BOOL imageSelected;
/** 扩大点击范围 */
@property(strong, nonatomic) UIView *enlargeClickView;
/** gif图片标识 */
@property(strong, nonatomic) UILabel *gifTipLabel;

@end

@implementation CYTImageAssetCell


#pragma mark - 懒加载

- (UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] init];
        _itemImageView.userInteractionEnabled = YES;
        _itemImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _itemImageView;
}

- (UIView *)coverVeiw{
    if (!_coverVeiw) {
        _coverVeiw = [[UIView alloc] init];
        _coverVeiw.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f];
    }
    return _coverVeiw;
}

- (UIButton *)selectBtn{
    CYTWeakSelf
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.adjustsImageWhenDisabled = NO;
        _selectBtn.adjustsImageWhenHighlighted = NO;
        [_selectBtn setBackgroundImage:[UIImage imageNamed:unselect] forState:UIControlStateNormal];
        [[_selectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [weakSelf selectBtnClick];
        }];
    }
    return _selectBtn;
}

- (void)selectBtnClick{
    NSString *selectBtnImage = [NSString string];
    if (self.isImageSelected) {
        selectBtnImage = unselect;
    }else{
        selectBtnImage = selected;
    }
    self.imageSelected = !self.isImageSelected;
    [_selectBtn setBackgroundImage:[UIImage imageNamed:selectBtnImage] forState:UIControlStateNormal];
    !self.selectAction?:self.selectAction(self.albumModel,self.isImageSelected);
}

- (UIView *)enlargeClickView{
    if (!_enlargeClickView) {
        CYTWeakSelf
        _enlargeClickView = [[UIView alloc] init];
        _enlargeClickView.backgroundColor = [UIColor clearColor];
        [_enlargeClickView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            [weakSelf selectBtnClick];
        }];
    }
    return _enlargeClickView;
}

- (UILabel *)gifTipLabel{
    if (!_gifTipLabel) {
        _gifTipLabel = [[UILabel alloc] init];
        _gifTipLabel.hidden = YES;
        _gifTipLabel.text = @" GIF ";
        _gifTipLabel.font = CYTBoldFontWithPixel(22.f);
        _gifTipLabel.textColor = [UIColor whiteColor];
        _gifTipLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    }
    return _gifTipLabel;
}

#pragma mark - 基本设置

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self imageAssetCellBasicConfig];
        [self initImageAssetCellComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)imageAssetCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
}


/**
 *  初始化子控件
 */
- (void)initImageAssetCellComponents{
    //图片
    [self.contentView addSubview:self.itemImageView];
    
    //选择标识
    [self.contentView addSubview:self.selectBtn];
    
    //扩大点击范围
    [self.contentView addSubview:self.enlargeClickView];

    //gif图标识
    [self.contentView addSubview:self.gifTipLabel];
    
    //不可选蒙层
    [self.contentView addSubview:self.coverVeiw];
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [_coverVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    CGFloat selectBtMargin = CYTAutoLayoutV(5.f);
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(40.f));
        make.right.bottom.offset(-selectBtMargin);
    }];
    
    [self.enlargeClickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(40.f)*1.7f);
        make.right.bottom.equalTo(self.contentView);
    }];
    
    [self.gifTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
    }];
}

- (void)setAlbumModel:(CYTAlbumModel *)albumModel{
    _albumModel = albumModel;
    [self setImageWithAlbumModel:albumModel];
    [self setOthersWithAlbumModel:albumModel];
    
    
//    _albumModel.prviewImage = self.itemImageView.image;
}


/**
 *  设置图片
 */
- (void)setImageWithAlbumModel:(CYTAlbumModel *)albumModel{
    CYTWeakSelf
    self.imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    if (albumModel.eachLineNum >= 4) {
        self.imageAssetManager.imageQualityConfig = 0.7f;
    }else{
        self.imageAssetManager.imageQualityConfig = 0.3f;
    }
    
    NSString *localIdentifier = albumModel.asset.localIdentifier;
    self.representedAssetIdentifier = localIdentifier;
    PHImageRequestID imageRequestID = [self.imageAssetManager fetchImageWithAsset:albumModel.asset imageWidth:self.contentView.bounds.size.width allowLoadFromiCloud:NO completion:^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
        if ([weakSelf.representedAssetIdentifier isEqualToString:localIdentifier]) {
            self.itemImageView.image = image;
            _albumModel.prviewImage = image;
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

- (void)setOthersWithAlbumModel:(CYTAlbumModel *)albumModel{
    self.imageSelected = albumModel.isSelected;
    NSString *selectBtnImage = [NSString string];
    if (albumModel.isSelected) {
        selectBtnImage = selected;
    }else{
        selectBtnImage = unselect;
    }
    [_selectBtn setBackgroundImage:[UIImage imageNamed:selectBtnImage] forState:UIControlStateNormal];
    if (albumModel.isReachMaxSelectValue) {
         _coverVeiw.hidden = !albumModel.isShowCoverView;
         _selectBtn.hidden = albumModel.isShowCoverView;
         _enlargeClickView.hidden = _selectBtn.hidden;
    }else{
        _coverVeiw.hidden = YES;
        _selectBtn.hidden = NO;
        _enlargeClickView.hidden = NO;
    }
    if (albumModel.assetMediaType == CYTAssetlMediaTypePhotoGif) {
        _gifTipLabel.hidden = NO;
        _selectBtn.hidden = YES;
        _enlargeClickView.hidden = _selectBtn.hidden;
    }else{
        _gifTipLabel.hidden = YES;
    }
}

@end
