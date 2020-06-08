//
//  CYTPhotoPreviewView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhotoPreviewView.h"
#import "CYTIndicatorView.h"
#import "CYTImageCompresser.h"

static CFTimeInterval const kDefaultAnimationDuration = 0.25f;

#define marginH         CYTAutoLayoutH(60)

@interface CYTPhotoPreviewView()<UIScrollViewDelegate>

/** 滚动视图 */
@property (weak, nonatomic) UIScrollView *imageScrollView;
/** 图片 */
@property (weak, nonatomic) UIImageView *itemImageView;
/** 取消按钮 */
@property(weak, nonatomic) UIButton *cancelBtn;
/** 选择按钮 */
@property(weak, nonatomic) UIButton *selectBtn;
@end

@implementation CYTPhotoPreviewView
{
    //底部按钮
    UIView *_bottomView;
}

- (void)dealloc {
    CYTLog(@"CYTPhotoPreviewView dealloc------");
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self photoPreviewBasicConfig];
        [self initPhotoPreviewComponents];
        [self makeConstrains];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideView) name:kHideWindowSubviewsKey object:nil];
    }
    return  self;
}

- (void)hideView {
    CGRect originF = CGRectMake(0, kScreenHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        self.frame =originF;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


/**
 *  基本配置
 */
- (void)photoPreviewBasicConfig{
    self.backgroundColor = [UIColor blackColor];
}

/**
 *  初始化子控件
 */
- (void)initPhotoPreviewComponents{
    //添加滚动视图
    UIScrollView *imageScrollView = [[UIScrollView alloc]init];
    [imageScrollView setBackgroundColor:[UIColor clearColor]];
    imageScrollView.bounces = NO;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.maximumZoomScale = 2.f;
    imageScrollView.minimumZoomScale = 1.f;
    imageScrollView.delegate = self;
    [self addSubview:imageScrollView];
    _imageScrollView = imageScrollView;
    imageScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    //单击手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] init];
    singleTapGesture.numberOfTapsRequired = 1;
    [[singleTapGesture rac_gestureSignal] subscribeNext:^(id x) {
//        !self.cellClickBack?:self.cellClickBack();
    }];
    [self addGestureRecognizer:singleTapGesture];
    
    //双击手势
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] init];
    doubleTapGesture.numberOfTapsRequired = 2;
    [[doubleTapGesture rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *doubleTapGesture) {
        CGPoint currentPoint = [doubleTapGesture locationInView:doubleTapGesture.view];
        CGRect zoomZone = CGRectMake(currentPoint.x - 25, currentPoint.y - 25, 50, 50);
        _imageScrollView.zoomScale > 1 ? [_imageScrollView setZoomScale:1 animated:YES]:[_imageScrollView zoomToRect:zoomZone animated:YES];
    }];
    
    [imageScrollView addGestureRecognizer:doubleTapGesture];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    
    
    //图片
    UIImageView *itemImageView = [[UIImageView alloc] init];
    itemImageView.userInteractionEnabled = YES;
    [imageScrollView addSubview:itemImageView];
    _itemImageView = itemImageView;
    
    //底部按钮
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [CYTHexColor(@"#101010") colorWithAlphaComponent:0.4f];
    [self addSubview:bottomView];
    _bottomView = bottomView;

    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = CYTFontWithPixel(32.f);
    [bottomView addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    CYTWeakSelf
    CGRect originF = CGRectMake(0, kScreenHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
            self.frame =originF;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];
        
    }];
    
    //选取按钮
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitle:@"选取" forState:UIControlStateNormal];
    [selectBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    selectBtn.titleLabel.font = CYTFontWithPixel(32.f);
    [bottomView addSubview:selectBtn];
    _selectBtn = selectBtn;
    
    [selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectBtnClick{
   CYTIndicatorView *indicatorView = [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeEditTabBar inView:self backgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7f]];
    indicatorView.infoMessage = @"正在压缩图片...";
    
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @strongify(self);
//        UIImage *selectedImage = [CYTImageCompresser compressDataWithImage:self.selectedImage];
        UIImage *selectedImage = [self.selectedImage compressedToSize:kImageCompressedMaxSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [CYTIndicatorView hideIndicatorView];
            !self.selectedBtnClick?:self.selectedBtnClick(selectedImage);
            
            CGRect originF = CGRectMake(0, kScreenHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
                self.frame = originF;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        });
    });
}

- (void)makeConstrains{
    //底部view
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(120.f));
    }];
    
    [_cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(marginH);
        make.top.bottom.equalTo(_bottomView);
        make.width.equalTo((_cancelBtn.titleLabel.font.pointSize+2)*2);
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-marginH);
        make.top.bottom.equalTo(_bottomView);
        make.width.equalTo((_cancelBtn.titleLabel.font.pointSize+2)*2);
    }];
    
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

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    _itemImageView.image = selectedImage;
    
    CGFloat imageVX = 0;
    CGFloat imageVW = kScreenWidth;
    CGFloat imageVH = selectedImage.size.height*kScreenWidth/selectedImage.size.width;
    CGFloat imageVY = 0;
    _itemImageView.frame = CGRectMake(imageVX, imageVY, imageVW, imageVH);
    
    if (imageVH<=kScreenHeight) {
        _itemImageView.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    }
    
    _imageScrollView.contentSize = CGSizeMake(imageVW,imageVH);
}

@end
