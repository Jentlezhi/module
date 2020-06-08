//
//  CYTLoadingView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLoadingView.h"

CYTLoadingView *loadingView = nil;

@interface CYTLoadingView()

/** 主背景 */
@property(weak, nonatomic) UIView *bg;

/** 加载动画背景 */
@property(weak, nonatomic) UIView *carLoadingBg;

/** 加载动画 */
@property(weak, nonatomic) UIImageView *carLoadingView;

/** 阴影 */
@property(weak, nonatomic) UIImageView *shadowView;


@end

@implementation CYTLoadingView

+ (void)showLoadingWithType:(CYTLoadingViewType)loadingViewType{
    [CYTLoadingView showLoadingWithType:loadingViewType inView:[CYTCommonTool currentControllerView]];
}

+ (void)showLoadingWithType:(CYTLoadingViewType)loadingViewType inView:(UIView *)view{
    [self showLoadingWithType:loadingViewType inView:view clearColorBackground:YES];
}

+ (void)showBackgroundLoadingWithType:(CYTLoadingViewType)loadingViewType{
    [self showBackgroundLoadingWithType:loadingViewType inView:[CYTCommonTool currentControllerView]];
}

+ (void)showBackgroundLoadingWithType:(CYTLoadingViewType)loadingViewType inView:(UIView *)view{
    [self showLoadingWithType:loadingViewType inView:view clearColorBackground:NO];
}


+ (void)showLoadingWithType:(CYTLoadingViewType)loadingViewType inView:(UIView *)view clearColorBackground:(BOOL)clearColor{
    for (UIView *itemView in view.subviews) {
        if ([itemView isKindOfClass:[self class]]) return;
    }
    loadingView = [[CYTLoadingView alloc] init];
    loadingView.bg.backgroundColor = clearColor?[UIColor clearColor]:CYTLightGrayColor;
    if (!view) {
        [kWindow addSubview:loadingView];
        [loadingView layoutLoadViewWithType:loadingViewType];
        [loadingView layoutCarLoadingBgWithKeyWindow:YES];
        return;
    }
    [view addSubview:loadingView];
    [loadingView layoutLoadViewWithType:loadingViewType];
    [loadingView layoutCarLoadingBgWithKeyWindow:NO];
}

- (void)layoutLoadViewWithType:(CYTLoadingViewType)loadingViewType{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (loadingViewType) {
            case CYTLoadingViewTypeNotEditable:
                make.edges.equalTo(0);
                break;
            case CYTLoadingViewTypeEditNavBar:
                make.edges.equalTo(UIEdgeInsetsMake(CYTViewOriginY, 0, 0, 0));
                break;
            case CYTLoadingViewTypeEditTabBar:
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, CYTTabBarHeight, 0));
                break;
            case CYTLoadingViewTypeEditNavBarAndTabBar:
                make.edges.equalTo(UIEdgeInsetsMake(CYTViewOriginY, 0, CYTTabBarHeight, 0));
                break;
            default:
                break;
        }
    }];

}

+ (void)hideLoadingView{
    [loadingView removeFromSuperview];
    loadingView = nil;
}

+ (instancetype)sharedLoadingView{
    static CYTLoadingView *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadingViewBasicConfig];
        [self initLoadingViewComponents];
        [self addAnimation];
        [self makeConstrains];
    }
    return  self;
}

/**
 *  基本配置
 */
- (void)loadingViewBasicConfig{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
}

/**
 *  初始化子控件
 */
- (void)initLoadingViewComponents{
    //主背景
    UIView *bg = [[UIView alloc] init];
    bg.userInteractionEnabled = NO;
    [self addSubview:bg];
    _bg = bg;
    
    //加载动画背景
    UIView *carLoadingBg = [[UIView alloc] init];
    carLoadingBg.backgroundColor = [UIColor whiteColor];
    [bg addSubview:carLoadingBg];
    _carLoadingBg = carLoadingBg;
    

    //加载动画
    UIImageView *carLoadingView = [[UIImageView alloc] init];
    carLoadingView.contentMode = UIViewContentModeScaleAspectFit;
    carLoadingView.image = [UIImage imageNamed:@"loading_car"];
    [carLoadingBg addSubview:carLoadingView];
    _carLoadingView = carLoadingView;

    //阴影
    UIImageView *shadowView = [[UIImageView alloc] init];
    shadowView.contentMode = UIViewContentModeScaleAspectFit;
    shadowView.image = [UIImage imageNamed:@"loading_line"];
    [carLoadingBg addSubview:shadowView];
    _shadowView = shadowView;
    
    
}

- (void)makeConstrains{
    //主背景
    [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    //加载动画
    CGFloat carLoadingViewWH = CYTAutoLayoutV(78.f);
    [_carLoadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_carLoadingBg);
        make.width.height.equalTo(carLoadingViewWH);
    }];
    
    //阴影
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_carLoadingBg);
        make.top.equalTo(_carLoadingView.mas_bottom).offset(CYTAutoLayoutV(5));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(60), CYTAutoLayoutV(4)));
    }];

}

- (void)layoutCarLoadingBgWithKeyWindow:(BOOL)isKeywindow{
    //加载动画背景
    CGFloat carLoadingBgWH = CYTAutoLayoutV(140.f);
    [_carLoadingBg mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isKeywindow) {
            make.center.equalTo(_bg);
        }else{
            make.centerX.equalTo(_bg);
            make.centerY.equalTo(_bg).offset(-CYTViewOriginY*0.5);
        }
        make.width.height.equalTo(carLoadingBgWH);
        _carLoadingBg.layer.cornerRadius = carLoadingBgWH*0.5;
        _carLoadingBg.layer.masksToBounds = YES;
    }];
}
/**
 * 添加动画
 */
- (void)addAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    animation.duration = 0.45f;
    animation.cumulative = YES;
    animation.repeatCount = CGFLOAT_MAX;
    [_carLoadingView.layer addAnimation:animation forKey:nil];
}

+ (void)hideLoadingViewWithDuration:(CGFloat)duration{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CYTLoadingView hideLoadingView];
    });
    
}

@end
