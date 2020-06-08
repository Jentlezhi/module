//
//  CYTIndicatorView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTIndicatorView.h"

CYTIndicatorView *indicatorView = nil;

@interface CYTIndicatorView ()
/** 主背景 */
@property(weak, nonatomic) UIView *backgroundView;
/** 加载动画 */
@property(weak, nonatomic) UIActivityIndicatorView *activityIndicatorView;
/** 加载信息 */
@property(weak, nonatomic) UILabel *infoLabel;

@end

@implementation CYTIndicatorView

#pragma mark - 公有方法

+ (instancetype)showIndicatorViewWithType:(CYTIndicatorViewType)indicatorViewType{
    return [self showIndicatorViewWithType:indicatorViewType inView:[CYTCommonTool currentControllerView]];
}

+ (instancetype)showIndicatorViewWithType:(CYTIndicatorViewType)indicatorViewType inView:(UIView *)view{
   return [self showIndicatorViewWithType:indicatorViewType inView:view backgroundColor:[UIColor clearColor]];
}

+ (instancetype)showIndicatorViewWithType:(CYTIndicatorViewType)indicatorViewType inView:(UIView *)view backgroundColor:(UIColor *)backgroundColor{
    for (UIView *itemView in view.subviews) {
        if ([itemView isKindOfClass:[self class]]) return nil;
    }
    indicatorView = [[CYTIndicatorView alloc] init];
    indicatorView.backgroundView.backgroundColor = backgroundColor;
    view = view?view:kWindow;
    [view addSubview:indicatorView];
    [indicatorView layoutWithType:indicatorViewType];
    return indicatorView;
}

+ (void)hideIndicatorView{
    [indicatorView.activityIndicatorView stopAnimating];
    [indicatorView removeFromSuperview];
}

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self indicatorViewBasicConfig];
        [self initIndicatorViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)indicatorViewBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initIndicatorViewComponents{
    //背景
    UIView *backgroundView = [[UIView alloc] init];
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    //加载动画
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.7f, 1.7f);
    activityIndicatorView.color = [UIColor blackColor];
    activityIndicatorView.transform = transform;
    [activityIndicatorView startAnimating];
    [backgroundView addSubview:activityIndicatorView];
    _activityIndicatorView = activityIndicatorView;
    
    //加载信息
    UILabel *infoLabel = [UILabel labelWithFontPxSize:26.f textColor:CYTHexColor(@"#666666")];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = @"正在处理...";
    infoLabel.numberOfLines = 0;
    [backgroundView addSubview:infoLabel];
    _infoLabel = infoLabel;
    
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    //主背景
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    //加载动画
    CGFloat activityIndicatorViewWH = CYTAutoLayoutV(60.f);
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-CYTViewOriginY);
        make.width.height.equalTo(activityIndicatorViewWH);
    }];
    
    //加载文字信息
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundView);
        make.top.equalTo(_activityIndicatorView.mas_bottom).offset(CYTAutoLayoutV(10));
        make.width.lessThanOrEqualTo(kScreenWidth*0.25f);
    }];
    
}

#pragma mark - 布局

- (void)layoutWithType:(CYTIndicatorViewType)indicatorViewType{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (indicatorViewType) {
            case CYTIndicatorViewTypeNotEditable:
            {
                make.edges.equalTo(0);
                CGFloat activityIndicatorViewWH = CYTAutoLayoutV(60.f);
                [_activityIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                    make.centerY.equalTo(self);
                    make.width.height.equalTo(activityIndicatorViewWH);
                }];
            }
                
                break;
            case CYTIndicatorViewTypeEditNavBar:
                make.edges.equalTo(UIEdgeInsetsMake(CYTViewOriginY, 0, 0, 0));
                break;
            case CYTIndicatorViewTypeEditTabBar:
            {
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, CYTTabBarHeight, 0));
                CGFloat activityIndicatorViewWH = CYTAutoLayoutV(60.f);
                [_activityIndicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                    make.centerY.equalTo(self);
                    make.width.height.equalTo(activityIndicatorViewWH);
                }];
            }
                
                break;
            case CYTIndicatorViewTypeEditNavBarAndTabBar:
                make.edges.equalTo(UIEdgeInsetsMake(CYTViewOriginY, 0, CYTTabBarHeight, 0));
                break;
            default:
                break;
        }
    }];
}

- (void)setInfoMessage:(NSString *)infoMessage{
    _infoMessage = infoMessage;
    _infoLabel.text = infoMessage;
}



@end
