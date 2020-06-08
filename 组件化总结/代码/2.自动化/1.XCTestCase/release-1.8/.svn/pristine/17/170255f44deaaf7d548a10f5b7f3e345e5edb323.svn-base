//
//  CYTCommonOrderStatusBar.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
// 订单进度
// 高度：CYTAutoLayoutV((28+10)*2 + 32.f)

#import "CYTCommonOrderStatusBar.h"

#define CYTBarNormalColor     [UIColor colorWithHexColor:@"#DFDFDF"]

#define CYTBarTipLabelColor   [UIColor colorWithHexColor:@"#999999"]

@interface CYTCommonOrderStatusBar()

/** 进度提示 */
@property(weak, nonatomic) UILabel *progressTipLabel;

/** 圆角进度 */
@property(weak, nonatomic) UIView *roundView;

/** 左条形进度 */
@property(weak, nonatomic) UIView *leftBarView;

/** 右条形进度 */
@property(weak, nonatomic) UIView *rightBarView;

/** 进度文字显示类型 */
@property(assign, nonatomic) CYTCommonOrderStatusBarType commonOrderStatusBarType;

/** 高亮状态颜色 */
@property(strong, nonatomic) UIColor *highlightColor;;

@end

@implementation CYTCommonOrderStatusBar

+ (instancetype)commonOrderStatusBarWithStyle:(CYTCommonOrderStatusBarType)commonOrderStatusBarType title:(NSString *)title highlightColor:(UIColor *)highlightColor{
    return [[CYTCommonOrderStatusBar alloc] initWithFrame:CGRectZero withStyle:commonOrderStatusBarType title:title highlightColor:highlightColor];
}

- (instancetype)initWithFrame:(CGRect)frame withStyle:(CYTCommonOrderStatusBarType)commonOrderStatusBarType title:(NSString *)title highlightColor:(UIColor *)highlightColor{
    if (self = [super initWithFrame:frame]) {
        [self commonOrderStatusBarBasicConfig];
        [self initCommonOrderStatusBarComponentWithTitle:title highlightColor:highlightColor];
        [self makeConstrainsWithStyle:commonOrderStatusBarType];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)commonOrderStatusBarBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initCommonOrderStatusBarComponentWithTitle:(NSString *)title highlightColor:(UIColor *)highlightColor{
    //进度提示
    UILabel *progressTipLabel = [[UILabel alloc] init];
    progressTipLabel.textColor = CYTBarTipLabelColor;
    progressTipLabel.textAlignment = NSTextAlignmentCenter;
    progressTipLabel.font = CYTFontWithPixel(23.f);
    progressTipLabel.text = title;
    [self addSubview:progressTipLabel];
    _progressTipLabel = progressTipLabel;
    
    //圆角进度
    UIView *roundView = [[UIView alloc] init];
    roundView.backgroundColor = CYTBarNormalColor;
    roundView.layer.cornerRadius = CYTAutoLayoutV(32)*0.5;
    roundView.layer.masksToBounds = YES;
    [self addSubview:roundView];
    _roundView = roundView;
    
    UIView *leftBarView = [[UIView alloc] init];
    leftBarView.backgroundColor = CYTBarNormalColor;
    [self addSubview:leftBarView];
    _leftBarView = leftBarView;
    
    UIView *rightBarView  = [[UIView alloc] init];
    rightBarView.backgroundColor = CYTBarNormalColor;
    [self addSubview:rightBarView];
    _rightBarView = rightBarView;
    
    //高亮状态颜色
    self.highlightColor = highlightColor;
}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithStyle:(CYTCommonOrderStatusBarType)commonOrderStatusBarType{
    //原点
    [_roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(32), CYTAutoLayoutV(32)));
    }];
    //左边进度条
    [_leftBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(_roundView.mas_left);
        make.height.equalTo(CYTAutoLayoutV(4.f));
        make.centerY.equalTo(_roundView);
    }];
    //右边进度条
    [_rightBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(_roundView.mas_right);
        make.height.equalTo(_leftBarView);
        make.centerY.equalTo(_roundView);
    }];
    
    CGFloat progressTipLabelH =  _progressTipLabel.font.pointSize+2;
    if (commonOrderStatusBarType == CYTCommonOrderStatusBarTitleUp) {
        [_progressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_roundView.mas_top).offset(-CYTAutoLayoutV(10.f));
            make.left.right.equalTo(self);
            make.height.equalTo(progressTipLabelH);
        }];
    }else{
        [_progressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_roundView.mas_bottom).offset(CYTAutoLayoutV(10.f));
            make.left.right.equalTo(self);
            make.height.equalTo(progressTipLabelH);
        }];
    }
}
/**
 * 隐藏左条
 */
- (void)setHideLeftBar:(BOOL)hideLeftBar{
    _hideLeftBar = hideLeftBar;
    _leftBarView.hidden = hideLeftBar;
}
/**
 * 隐藏右条
 */
- (void)setHideRightBar:(BOOL)hideRightBar{
    _hideRightBar = hideRightBar;
    _rightBarView.hidden = hideRightBar;
}
/**
 * 高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted{
    _highlighted = highlighted;
    if (highlighted) {
        _progressTipLabel.textColor = _highlightColor;
        _roundView.backgroundColor = _highlightColor;
        _rightBarView.backgroundColor = _highlightColor;
    }

}
/**
 * 设置左条高亮状态
 */
- (void)setHighlightedLeftBar:(BOOL)highlightedLeftBar{
    _highlightedLeftBar = highlightedLeftBar;
    if (highlightedLeftBar) {
        _leftBarView.backgroundColor = _highlightColor;
    }
}

@end
