//
//  CYTPhotoBrowserCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhotoBrowserCell.h"
#import "CYTAlbumModel.h"
#import "CYTImageAssetManager.h"
#import "CYTProgressPieView.h"

static const CGFloat animationTime = 0.2f;

@interface CYTPhotoBrowserCell()<UIScrollViewDelegate>
/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;
/** 滚动视图 */
@property(strong, nonatomic) UIScrollView *scrollView;
/** 图片 */
@property(strong, nonatomic) UIImageView *imageView;
/** 首次显示（动画设置属性） */
@property(assign, nonatomic) BOOL firstShow;
/** gif图 */
@property(weak, nonatomic) UIImage *firstImage;
/** gif动图 */
@property(strong, nonatomic) UIImage *gifImage;
/** 图片请求ID */
@property(assign, nonatomic) PHImageRequestID imageRequestID;
/** 加载进度 */
@property(strong, nonatomic) CYTProgressPieView *progressPieView;

@end

@implementation CYTPhotoBrowserCell

#pragma mark - 基本设置

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self photoBrowserCellBasicConfig];
        [self initPhotoBrowserCellComponents];
        [self makeConstrains];
        [self addObserver];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)photoBrowserCellBasicConfig{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.firstShow = YES;
    self.imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    //单击手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] init];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.delaysTouchesBegan = YES;
    [[singleTapGesture rac_gestureSignal] subscribeNext:^(id x) {
        !self.signalTapClick?:self.signalTapClick();
    }];
    [self.scrollView addGestureRecognizer:singleTapGesture];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] init];
    doubleTapGesture.numberOfTapsRequired = 2;
    [[doubleTapGesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *doubleTapGesture) {
        CGPoint currentPoint = [doubleTapGesture locationInView:doubleTapGesture.view];
        CGRect zoomZone = CGRectMake(currentPoint.x - 25, currentPoint.y - 25, 50, 50);
        self.scrollView.zoomScale > 1 ? [self.scrollView setZoomScale:1 animated:YES]:[self.scrollView zoomToRect:zoomZone animated:YES];
    }];
    
    [self.scrollView addGestureRecognizer:doubleTapGesture];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}
/**
 *  初始化子控件
 */
- (void)initPhotoBrowserCellComponents{
     //添加滚动视图
    [self.contentView addSubview:self.scrollView];
    //滚动视图添加图片
    [self.scrollView addSubview:self.imageView];
    //添加加载进度
    [self.imageView addSubview:self.progressPieView];

}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [self.progressPieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(90.f), CYTAutoLayoutV(90.f)));
        make.center.equalTo(self.imageView);
    }];
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.maximumZoomScale = 2.f;
        _scrollView.minimumZoomScale = 1.f;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.frame = [UIScreen mainScreen].bounds;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    }
    return _scrollView;

}


- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.frame = [UIScreen mainScreen].bounds;
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
//        CYTWeakSelf
//        __weak typeof(_imageView) weakImageView = _imageView;
//        [_imageView addLongTapGestureRecognizerWithTap:^(UILongPressGestureRecognizer *longTap) {
//            if (!weakImageView.image)return;
//            [CYTAlertView actionSheetWithConfirmTitle:@"保存图片" cancelTitle:@"取消" confirmAction:^{
//                BOOL authorized = [[CYTImageAssetManager sharedAssetManager] authorizationStatusAuthorized];
//                if (authorized) {
//                    [weakSelf saveImageToAlbumWithImage:weakImageView.image];
//                    return;
//                }
//                [CYTImageAssetManager authorizationStatusWithDenied:^{
//                    [CYTAlertView alertTipWithTitle:@"提示" message:@"没有权限访问您的相册，请前往设置允许该应用访问相册。" confiemAction:nil];
//                } authorized:^{
//                    [weakSelf saveImageToAlbumWithImage:weakImageView.image];
//                }];
//            } cancelAction:nil];
//        }];

    }
    return _imageView;
}

- (CYTProgressPieView *)progressPieView{
    if (!_progressPieView) {
        _progressPieView = [[CYTProgressPieView alloc] init];
        _progressPieView.circleColor = CYTHexColor(@"#e4e4e4");
        _progressPieView.progressColor = CYTHexColor(@"#e4e4e4");
        _progressPieView.backgroundRingWidth = 1.5f;
        _progressPieView.pieProgressValue = 0.05f;
        _progressPieView.hidden = YES;
    }
    return _progressPieView;
}


//- (void)saveImageToAlbumWithImage:(UIImage *)image{
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//    return;
//}
//
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if(!error){
//        [CYTToast successToastWithMessage:@"图片保存成功"];
//    }else{
//        [CYTToast errorToastWithMessage:@"图片保存失败"];
//    }
//}


#pragma mark - 赋值

- (void)setAlbumModel:(CYTAlbumModel *)albumModel{
    _albumModel = albumModel;
    if (albumModel.imageURL) {//URL图片
        self.progressPieView.hidden = NO;
        self.scrollView.userInteractionEnabled = NO;
        albumModel.prviewImage = albumModel.prviewImage ? albumModel.prviewImage : kDefaultPlaceholderImage;
        [self configWithAlbumModel:albumModel image:albumModel.prviewImage];
        [_imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:albumModel.imageURL] placeholderImage:albumModel.prviewImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            CGFloat progressValue = 1.0*receivedSize/expectedSize;
            if ( progressValue >= 0.05) {
                self.progressPieView.pieProgressValue = progressValue;
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.progressPieView.hidden = YES;
            self.scrollView.userInteractionEnabled = YES;
            if (image) {
                _imageView.image = image;
                [self configWithAlbumModel:albumModel image:image];
            }
        }];
    }else if (albumModel.cameraImage) {//相机图片
        _imageView.image = albumModel.cameraImage;
        [self configWithAlbumModel:albumModel image:albumModel.prviewImage];
    }else{//相册图片
       [self configImageAssetManagerWithAlbumModel:albumModel];
    }
}

- (void)configWithAlbumModel:(CYTAlbumModel *)albumModel image:(UIImage *)image{
    if (albumModel.showAnimation) {
        [self showAnimationWithAlbumModel:albumModel image:_imageView.image];
    }
    [self layoutImageViewWithImage:image];
}

- (void)configImageAssetManagerWithAlbumModel:(CYTAlbumModel *)albumModel{
    if (albumModel.asset && self.imageRequestID) {
        [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
    }
    CYTWeakSelf
    [[CYTImageAssetManager sharedAssetManager] fetchAssetSizeWithAsset:albumModel.asset completion:^(CGFloat assetSize) {
        self.imageAssetManager.imageQuality = [CYTImageAssetManager fetchImageQualityWithImageSize:assetSize];
        [weakSelf fetchHighQulityImageWithAlbumModel:albumModel];
    }];
    
}

- (void)fetchHighQulityImageWithAlbumModel:(CYTAlbumModel *)albumModel{
    CYTWeakSelf
    if (albumModel.assetMediaType == CYTAssetlMediaTypePhotoGif) {//gif图
        self.imageRequestID = [[CYTImageAssetManager sharedAssetManager] fetchImageDataWithAsset:albumModel.asset completion:^(NSData *imageData, NSDictionary *info) {
            UIImage *gifImage = [UIImage gifWithData:imageData];
            if (!gifImage.images.count) {
                self.firstImage = gifImage;
                dispatch_async(dispatch_get_main_queue(), ^{
                    _imageView.image = gifImage;
                });
            }else{
                self.firstImage = gifImage.images.firstObject;
                dispatch_async(dispatch_get_main_queue(), ^{
                    _imageView.image = gifImage.images.firstObject;
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = gifImage;
                if (albumModel.showAnimation) {
                    [self showAnimationWithAlbumModel:albumModel image:_imageView.image];
                }
                [self layoutImageViewWithImage:gifImage];
            });
            self.imageRequestID = 0;
        }];
    }else{//非gif图
        self.imageRequestID = [[CYTImageAssetManager sharedAssetManager] fetchImageWithAsset:albumModel.asset completion:^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.imageView.image = image;
                if (albumModel.showAnimation) {
                    [weakSelf showAnimationWithAlbumModel:albumModel image:_imageView.image];
                }
                [weakSelf layoutImageViewWithImage:image];
            });
            weakSelf.imageRequestID = 0;
        }];
    }

}

- (void)addObserver{
    extern NSString *kBackBtnClickNotification;
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kBackBtnClickNotification object:nil] subscribeNext:^(id x) {
        @strongify(self)
        if (self.scrollView.contentOffset.y != 0) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
        if (_scrollView.zoomScale > 1.0f) {
            [_scrollView setZoomScale:1.f animated:YES];
            [self dismissAnimationWithAlbumModel:self.albumModel];
        }else{
            [self dismissAnimationWithAlbumModel:self.albumModel];
        }
    }];
}

- (void)removeObserver{
    extern NSString *kBackBtnClickNotification;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBackBtnClickNotification object:nil];
}

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
    CGFloat imageWith  = image.size.width == 0 ? kScreenWidth:image.size.width;
    CGFloat imageHeght = image.size.height == 0 ?kScreenWidth/3.f : image.size.height;
    CGFloat imageRadio = imageWith/imageHeght*1.0f;
    CGFloat imageViewX = 0.f;
    CGFloat imageViewY = 0.f;
    CGFloat imageViewW = kScreenWidth;
    CGFloat imageViewH = imageViewW/imageRadio;
    _imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    _scrollView.contentSize = CGSizeMake(imageViewW,imageViewH);
    if (imageViewH <= kScreenHeight) {
        _imageView.center = CGPointMake(kScreenWidth*0.5f, kScreenHeight*0.5f);
    }
}

- (void)showAnimationWithAlbumModel:(CYTAlbumModel *)albumModel image:(UIImage *)image{
    CGSize  boundsSize = self.bounds.size;
    CGFloat boundsWidth  = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    CGSize  imageSize    =  image ? image.size :albumModel.prviewImage.size;
    CGFloat imageWidth   = imageSize.width;
    CGFloat imageHeight  = imageSize.height;
    
    CGFloat minScale = 1.0f;
    if (imageWidth && boundsWidth) {
        minScale = boundsWidth / imageWidth > 1.0 ? 1.0:boundsWidth / imageWidth;
    }
    CGFloat maxScale = 2.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
    }
    CGFloat imageViewHeight = 0;
    if (imageWidth>0.f) {
        imageViewHeight = imageHeight * boundsWidth / imageWidth*1.0f;
    }
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageViewHeight);
    self.scrollView.contentSize = CGSizeMake(0, imageFrame.size.height);
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
    } else {
        imageFrame.origin.y = 0;
    }
    if (self.firstShow) {
        self.firstShow = NO;
        if (albumModel.prviewFrame.origin.y< kScreenHeight) {
            _imageView.frame = albumModel.prviewFrame;
        }else{
            _imageView.frame = imageFrame;
            _imageView.alpha = 0;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.frame = imageFrame;
        } completion:^(BOOL finished) {
            [self showAnimationWithAlbumModel:albumModel image:_imageView.image];
        }];
    }else{
        _imageView.frame = imageFrame;
    }
}

- (void)dismissAnimationWithAlbumModel:(CYTAlbumModel *)albumModel{
    self.progressPieView.hidden = YES;
    [[SDWebImageManager sharedManager].imageDownloader cancelAllDownloads];
    [UIView animateWithDuration:animationTime animations:^{
        _imageView.image = albumModel.prviewImage;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
    [UIView animateWithDuration:animationTime + 0.1f animations:^{
        if (albumModel.prviewFrame.origin.y > - albumModel.prviewFrame.size.height && albumModel.prviewFrame.origin.y < kScreenHeight) {
            _imageView.frame = albumModel.prviewFrame;
        }else{
            _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - albumModel.prviewFrame.origin.y);
        }
        if (_imageView.image.images.count) {
            _imageView.image = _imageView.image.images[0];
        }
        !self.setControllerViewColor?:self.setControllerViewColor();
    } completion:^(BOOL finished) {
        [self removeObserver];
        !self.dismissController?:self.dismissController();
    }];
}


@end
