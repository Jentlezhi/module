//
//  CYT3DPriviewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYT3DPriviewController.h"
#import "CYTAlbumModel.h"
#import "CYTImageAssetManager.h"

static const CGFloat animationTime = 0.2f;

@interface CYT3DPriviewController ()<UIScrollViewDelegate>
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;
/** 滚动视图 */
@property(strong, nonatomic) UIScrollView *scrollView;
/** 图片 */
@property(strong, nonatomic) UIImageView *imageView;
/** 首次显示（动画设置属性） */
@property(assign, nonatomic) BOOL firstShow;
/** 动画的静态图 */
@property(weak, nonatomic) UIImage *firstImage;
/** 动画 */
@property(strong, nonatomic) UIImage *gifImage;

@end

@implementation CYT3DPriviewController

- (void)showPhotoBrowserViewWithAnimation{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.maximumZoomScale = 2.f;
        _scrollView.minimumZoomScale = 1.f;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, 0);
    }
    return _scrollView;
}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = self.albumModel.prviewImage;
        [self layoutImageViewWithImage:_imageView.image];
        _imageView.userInteractionEnabled = YES;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self priviewBasicConfig];
    [self initpriviewComponents];
    [self makeConstrains];
}

/**
 *  基本配置
 */
- (void)priviewBasicConfig{
    [self.navigationBar removeFromSuperview];
    [self.statusBar removeFromSuperview];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.clipsToBounds = YES;
    self.firstShow = YES;
    
    //单击手势
    CYTWeakSelf
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] init];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.delaysTouchesBegan = YES;
    [[singleTapGesture rac_gestureSignal] subscribeNext:^(id x) {
        [weakSelf dismissAnimationWithAlbumModel:weakSelf.albumModel];
    }];
    [self.view addGestureRecognizer:singleTapGesture];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] init];
    doubleTapGesture.numberOfTapsRequired = 2;
    [[doubleTapGesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *doubleTapGesture) {
        CGPoint currentPoint = [doubleTapGesture locationInView:doubleTapGesture.view];
        CGRect zoomZone = CGRectMake(currentPoint.x - 25, currentPoint.y - 25, 50, 50);
        weakSelf.scrollView.zoomScale > 1 ? [weakSelf.scrollView setZoomScale:1 animated:YES]:[weakSelf.scrollView zoomToRect:zoomZone animated:YES];
    }];
    [self.scrollView addGestureRecognizer:doubleTapGesture];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}


/**
 *  初始化子控件
 */
- (void)initpriviewComponents{
    //添加滚动视图
    [self.view addSubview:self.scrollView];
    //滚动视图添加图片
    [self.scrollView addSubview:self.imageView];
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

#pragma mark - 赋值

- (void)setAlbumModel:(CYTAlbumModel *)albumModel{
    _albumModel = albumModel;
    self.imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    self.imageAssetManager.imageQualityConfig = 1.0f;
    CYTWeakSelf
    [self.imageAssetManager fetchAssetSizeWithAsset:albumModel.asset completion:^(CGFloat assetSize) {
        self.imageAssetManager.imageQuality = [CYTImageAssetManager fetchImageQualityWithImageSize:assetSize];
        [weakSelf fetHighQualityWithAlbumModel:albumModel];
    }];

}

- (void)fetHighQualityWithAlbumModel:(CYTAlbumModel *)albumModel{
    CYTWeakSelf
    if (albumModel.assetMediaType == CYTAssetlMediaTypePhotoGif) {
        [self.imageAssetManager fetchImageDataWithAsset:albumModel.asset completion:^(NSData *imageData, NSDictionary *info) {
            UIImage *gifImage = [UIImage gifWithData:imageData];
            if (!gifImage.images.count) {
                weakSelf.firstImage = gifImage;
                _imageView.image = gifImage;
            }else{
                weakSelf.firstImage = gifImage.images.firstObject;
                _imageView.image = gifImage.images.firstObject;
            }
            _imageView.image = gifImage;
            [weakSelf layoutImageViewWithImage:weakSelf.firstImage];
        }];
    }else{
        [self.imageAssetManager fetchImageWithAsset:albumModel.asset imageWidth:self.imageAssetManager.imagePreviewMaxWidth allowLoadFromiCloud:NO completion:^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
            _imageView.image = image;
            [weakSelf layoutImageViewWithImage:image];
        }];
    }
}

#pragma mark - 配置

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xCenter = scrollView.center.x;
    CGFloat yCenter = scrollView.center.y;
    xCenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xCenter;
    yCenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : yCenter;
    UIImageView *imamgeView = (UIImageView *)scrollView.subviews.firstObject;
    [imamgeView setCenter:CGPointMake(xCenter, yCenter)];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return  _imageView;
}
- (void)layoutImageViewWithImage:(UIImage *)image{
    CGFloat imageWith   = image.size.width;
    CGFloat imageHeght = image.size.height;
    CGFloat imageRadio = imageWith/imageHeght;
    CGFloat imageViewX = 0.f;
    CGFloat imageViewY = 0.f;
    CGFloat imageViewW = kScreenWidth;
    CGFloat imageViewH = imageViewW/imageRadio;
    _imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    _scrollView.contentSize = CGSizeMake(imageViewW,imageViewH);
    if (imageViewH <= kScreenHeight) {
        _imageView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    }
}

/**
 *  消失动画
 */
- (void)dismissAnimationWithAlbumModel:(CYTAlbumModel *)albumModel{
    CYTWeakSelf
    [UIView animateWithDuration:animationTime animations:^{
        _imageView.image = albumModel.prviewImage;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
    [UIView animateWithDuration:animationTime + 0.1f animations:^{
        if (albumModel.prviewFrame.origin.y > - albumModel.prviewFrame.size.height &&albumModel.prviewFrame.origin.y < kScreenHeight) {
            _imageView.frame = albumModel.prviewFrame;
        }else{
            _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - albumModel.prviewFrame.origin.y);
        }
        if (_imageView.image.images) {
            _imageView.image = _imageView.image.images[0];
        }
        weakSelf.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [weakSelf.view removeFromSuperview];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
}



@end
