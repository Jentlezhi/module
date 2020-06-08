//
//  CYTPhotoCollectionViewCell.m
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhotoCollectionViewCell.h"
#import "CYTProgressPieView.h"
#import "CYTImageAssetManager.h"

@interface CYTPhotoCollectionViewCell()<UIScrollViewDelegate>
/** 滚动视图 */
@property (weak, nonatomic) UIScrollView *itemScrollView;
/** 图片 */
@property (weak, nonatomic) UIImageView *itemImageView;
/** 图片加载进度 */
@property(strong, nonatomic) CYTProgressPieView *progressPieView;

@end

@implementation CYTPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self photoCollectionViewBasicConfig];
        [self initPhotoCollectionViewComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)photoCollectionViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initPhotoCollectionViewComponents{
    //添加滚动视图
    UIScrollView *itemScrollView = [[UIScrollView alloc]init];
    itemScrollView.userInteractionEnabled = NO;
    [itemScrollView setBackgroundColor:[UIColor clearColor]];
    itemScrollView.bounces = YES;
    itemScrollView.showsHorizontalScrollIndicator = NO;
    itemScrollView.showsVerticalScrollIndicator = NO;
    itemScrollView.maximumZoomScale = 2.f;
    itemScrollView.minimumZoomScale = 1.f;
    itemScrollView.delegate = self;
    itemScrollView.contentSize = CGSizeMake(kScreenWidth, 0);
    [self.contentView addSubview:itemScrollView];
    _itemScrollView = itemScrollView;
    itemScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //单击手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] init];
    singleTapGesture.numberOfTapsRequired = 1;
    [[singleTapGesture rac_gestureSignal] subscribeNext:^(id x) {
        !self.cellClickBack?:self.cellClickBack();
    }];
    [self addGestureRecognizer:singleTapGesture];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] init];
    doubleTapGesture.numberOfTapsRequired = 2;
    [[doubleTapGesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *doubleTapGesture) {
        CGPoint currentPoint = [doubleTapGesture locationInView:doubleTapGesture.view];
        CGRect zoomZone = CGRectMake(currentPoint.x - 25, currentPoint.y - 25, 50, 50);
        _itemScrollView.zoomScale > 1 ? [_itemScrollView setZoomScale:1 animated:YES]:[_itemScrollView zoomToRect:zoomZone animated:YES];
    }];
    
    [itemScrollView addGestureRecognizer:doubleTapGesture];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    
    
    //图片
    CYTWeakSelf
    UIImageView *itemImageView = [[UIImageView alloc] init];
    itemImageView.userInteractionEnabled = YES;
    [itemScrollView addSubview:itemImageView];
    itemImageView.frame = [UIScreen mainScreen].bounds;
    _itemImageView = itemImageView;
    __weak typeof(itemImageView) weakItemImageView = itemImageView;
//    [itemImageView addLongTapGestureRecognizerWithTap:^(UILongPressGestureRecognizer *longTap) {
//        if (!weakItemImageView.image)return;
//        [CYTAlertView actionSheetWithConfirmTitle:@"保存图片" cancelTitle:@"取消" confirmAction:^{
//            BOOL authorized = [[CYTImageAssetManager sharedAssetManager] authorizationStatusAuthorized];
//            if (authorized) {
//                [weakSelf saveImageToAlbumWithImage:weakItemImageView.image];
//                return;
//            }
//            [CYTImageAssetManager authorizationStatusWithDenied:^{
//                [CYTAlertView alertTipWithTitle:@"提示" message:@"没有权限访问您的相册，请前往设置允许该应用访问相册。" confiemAction:nil];
//            } authorized:^{
//                [weakSelf saveImageToAlbumWithImage:weakItemImageView.image];
//            }];
//        } cancelAction:nil];
//    }];
    
    
    //图片加载进度
    [itemImageView addSubview:self.progressPieView];
    [self.progressPieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(90.f), CYTAutoLayoutV(90.f)));
        make.center.equalTo(itemImageView);
    }];
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
/**
 * 本地图片
 */
- (void)setItemImage:(UIImage *)itemImage{
    _itemImage = itemImage;
    [self layoutImageAndScrollViewWithImage:itemImage localPic:YES];
}
/**
 *  根据图片自动适配
 */
- (void)layoutImageAndScrollViewWithImage:(UIImage *)image localPic:(BOOL)isLocalPic{
    if (isLocalPic) {
        _itemImageView.image = image;
        _progressPieView.hidden = YES;
    }else{
        //加载失败，取默认图片
        if (!image){
            image = kPlaceholderImage;
            _itemImageView.image = image;
        };
    }
    
    if (image.size.width == 0 || image.size.height == 0) {
        return;
    }

    CGFloat imageVX = 0;
    CGFloat imageVW = kScreenWidth;
    CGFloat imageVH = image.size.height*kScreenWidth/image.size.width;
    CGFloat imageVY = 0;
    _itemImageView.frame = CGRectMake(imageVX, imageVY, imageVW, imageVH);
    if (imageVH<=kScreenHeight) {
        _itemImageView.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    }
    _itemScrollView.contentSize = CGSizeMake(imageVW,imageVH);
}

/**
 * 加载网络图片
 */
- (void)setItemImageURL:(NSString *)itemImageURL {
    _itemImageURL = itemImageURL;
    [_itemImageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:itemImageURL] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressPieView.hidden = NO;
            CGFloat progressValue = 1.0*receivedSize/expectedSize;
            if ( progressValue >= 0.05) {
                self.progressPieView.pieProgressValue = progressValue;
            }
        });
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _itemScrollView.userInteractionEnabled = YES;
        self.progressPieView.hidden = YES;
        [self layoutImageAndScrollViewWithImage:image localPic:NO];
    }];
}

#pragma mark - 懒加载

- (CYTProgressPieView *)progressPieView{
    if (!_progressPieView) {
        _progressPieView = [[CYTProgressPieView alloc] init];
        _progressPieView.circleColor = CYTHexColor(@"#e4e4e4");
        _progressPieView.progressColor = CYTHexColor(@"#e4e4e4");
        _progressPieView.backgroundRingWidth = 1.5f;
        _progressPieView.pieProgressValue = 0.05f;
    }
    return _progressPieView;
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    
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
    return  scrollView.subviews.firstObject;
}




@end
