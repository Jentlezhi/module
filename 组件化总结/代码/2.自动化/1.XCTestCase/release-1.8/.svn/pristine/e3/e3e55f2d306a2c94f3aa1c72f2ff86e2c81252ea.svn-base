//
//  CYTNewfeatureController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTNewfeatureController.h"

#define kNewfeatureImageCount 3

@interface CYTNewfeatureController ()<UIScrollViewDelegate,CAAnimationDelegate>

@property (weak, nonatomic) UIScrollView *introScrollView;
@property (weak, nonatomic) UIPageControl *pageControl;


@end

@implementation CYTNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView{
    UIScrollView *introScrollView = [[UIScrollView alloc] init];
    introScrollView.backgroundColor = [UIColor clearColor];
    introScrollView.frame = self.view.bounds;
    introScrollView.delegate = self;
    [self.view addSubview:introScrollView];
    
    CGFloat imageViewW = kScreenWidth;
    CGFloat imageViewH = kScreenHeight;
    for (int index = 0; index < kNewfeatureImageCount; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        NSString *name = [NSString stringWithFormat:@"introPage%d", index+1];
        //适配图片 4/5/6/6p
        if (kFF_IS_IPHONE_4) {
            name = [NSString stringWithFormat:@"4_%@",name];
        }else if (kFF_IS_IPHONE_5) {
            name = [NSString stringWithFormat:@"5_%@",name];
        }else if (kFF_IS_IPHONE_6) {
            name = [NSString stringWithFormat:@"6_%@",name];
        }else if (kFF_IS_IPHONE_6P) {
            name = [NSString stringWithFormat:@"6p_%@",name];
        }
        
        imageView.image = [UIImage imageNamed:name];
        [introScrollView addSubview:imageView];
        
        CGFloat imageViewX = index * imageViewW;
        CGFloat imageViewY = 0;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        
        if (index == kNewfeatureImageCount - 1) {
            UIButton *experienceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [experienceBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            UIColor *color = (self.clearIndicator)?[UIColor clearColor]:CYTGreenNormalColor;
            [experienceBtn setTitleColor:color forState:UIControlStateNormal];
            [experienceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [experienceBtn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateHighlighted];
            experienceBtn.layer.borderWidth = 1.0f;
            experienceBtn.layer.borderColor = color.CGColor;
            experienceBtn.layer.cornerRadius = 6;
            experienceBtn.layer.masksToBounds = YES;
            experienceBtn.titleLabel.font = CYTFontWithPixel(34.f);
            
            CGFloat experienceBtnW = CYTAutoLayoutH(200);
            CGFloat experienceBtnH = CYTAutoLayoutV(64);
            CGFloat experienceBtnX = (kScreenWidth-experienceBtnW)*0.5;
            CGFloat experienceBtnY = kScreenHeight-CYTAutoLayoutV(80)-experienceBtnH;
            
            experienceBtn.frame = CGRectMake(experienceBtnX, experienceBtnY, experienceBtnW, experienceBtnH);
            //1.7版本修改,点击最后一张图就可以进入
            experienceBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//            if (self.clearIndicator) {
//                [experienceBtn enlargeWithTop:10 left:20 bottom:0 right:20];
//            }
            [imageView addSubview:experienceBtn];
            [[experienceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                !self.experienceNowOperation?:self.experienceNowOperation();
            }];
        }
    }
    
    introScrollView.contentSize = CGSizeMake(kNewfeatureImageCount *imageViewW, 0);
    introScrollView.bounces = NO;
    introScrollView.pagingEnabled = YES;
    introScrollView.showsHorizontalScrollIndicator = NO;
}

/**
 *  添加pageControl
 */
- (void)setupPageControl{
    if (!self.showPageControl) {
        return;
    }
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = kNewfeatureImageCount;
    pageControl.currentPage = 0;
    //btn_dot_nor14 btn_dot_press14 #c3c3c3 灰色
    [pageControl setValue:[UIImage imageNamed:@"btn_dot_nor14"] forKeyPath:@"pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"btn_dot_press14"] forKeyPath:@"currentPageImage"];
    pageControl.centerX = kScreenWidth * 0.5;
    pageControl.centerY = kScreenHeight - CYTAutoLayoutV(95);
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.showPageControl) {
        return;
    }
    double scrollOffsetX = scrollView.contentOffset.x;
    double ratio = scrollOffsetX / kScreenWidth;
    int pageNo = (int)(ratio + 0.5);
    _pageControl.currentPage = pageNo;
    BOOL hide = pageNo >= kNewfeatureImageCount - 1 ? YES:NO;
    hide = (self.showPageControl)?hide:YES;
    _pageControl.hidden = hide;
}

/**
 * 动画效果
 */
- (void)transitionFromRight{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0f;
    animation.type = @"rippleEffect";
    animation.delegate = self;
    [keyWindow.layer addAnimation:animation forKey:nil];
}

#pragma mark - <CAAnimationDelegate>
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    !self.experienceNowOperation?:self.experienceNowOperation();
}

@end
