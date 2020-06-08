//
//  CYTCourseView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCourseView.h"

@interface CYTCourseView()

/** 背景 */
@property(weak, nonatomic) UIView *bgView;
/** 展示图片 */
@property(weak, nonatomic) UIImageView *showImageView;

@end

@implementation CYTCourseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self courseViewBasicConfig];
        [self initCourseVieComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)courseViewBasicConfig{
    self.backgroundColor = [UIColor clearColor];

}

+ (instancetype)showCourseViewWithType:(CYTIdType)idType finish:(void(^)())fishBlock{
    CYTCourseView *courseView = [[CYTCourseView alloc] init];
    __weak typeof(courseView) weakCoureView = courseView;
    courseView.frame = kWindow.bounds;
    [kWindow addSubview:courseView];
    [UIView animateWithDuration:0.2f animations:^{
        weakCoureView.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    }];
    NSString *imageName = [NSString string];
    switch (idType) {
        case CYTIdTypeFront:
            imageName = @"pic_zhengmian_dl";
            break;
        case CYTIdTypeBack:
            imageName = @"pic_fanmian_dl";
            break;
        case CYTIdTypeFrontWithHand:
            imageName = @"pic_shouchi_dl";
            break;
        default:
            break;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    courseView.showImageView.image = image;
    [courseView.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(courseView.bgView);
        make.top.equalTo(CYTViewOriginY);
        make.size.equalTo(CGSizeMake(image.size.width, image.size.height));
    }];
    
    [courseView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        [UIView animateWithDuration:0.25f animations:^{
            weakCoureView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [weakCoureView removeFromSuperview];
            !finished?:fishBlock();
        }];
    }];
    return courseView;
    
}

/**
 *  初始化子控件
 */
- (void)initCourseVieComponents{
    //背景
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    [self addSubview:bgView];
    _bgView = bgView;
    //展示图片
    UIImageView *showImageView = [[UIImageView alloc] init];
    [bgView addSubview:showImageView];
    _showImageView = showImageView;
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
@end
