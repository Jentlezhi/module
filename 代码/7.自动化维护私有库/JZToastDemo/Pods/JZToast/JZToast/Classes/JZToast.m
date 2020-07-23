//
//  JZToast.m
//  JZToast
//
//  Created by Jentle on 2017/4/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "JZToast.h"

#define kBgColor [ColorWithDark(cFF000000, cFF262629) colorWithAlphaComponent:0.7f];
@interface JZTipLabel()


/** 字体内边距 */
@property(assign, nonatomic) UIEdgeInsets textInsets;

/** 最大宽度 */
@property(assign, nonatomic) CGFloat maxWidth;
/** 最小宽度 */
@property(assign, nonatomic) CGFloat minWidth;
/** 最小高度 */
@property(assign, nonatomic) CGFloat minHeight;

@end

@implementation JZTipLabel

- (instancetype)initWithText:(NSString *)text{
    if([self initWithFrame:CGRectZero]){
        self.text = text;
        [self sizeToFit];
    }
    
    return self;
}

- (instancetype)initWithText:(NSString *)text textEdgeInsets:(UIEdgeInsets)textInsets maxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth minHeight:(CGFloat)minHeight{
    if([self initWithFrame:CGRectZero]){
        self.textInsets = textInsets;
        self.maxWidth = maxWidth;
        self.minWidth = minWidth;
        self.minHeight = minHeight;
        self.text = text;
        [self sizeToFit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self tipLabelBasicConfig];
        [self initTipLabelComponents];
        [self makeConstrains];
    }
    
    return self;
}


/**
 *  基本配置
 */
- (void)tipLabelBasicConfig{
    self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.7f];
    self.numberOfLines = 0;
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:14.5f];
    self.textColor = UIColor.whiteColor;
}

/**
 *  初始化子控件
 */
- (void)initTipLabelComponents{
    
}

/**
 *  布局
 */
- (void)makeConstrains{

}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (void)sizeToFit{
    [super sizeToFit];
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(self.bounds) + self.textInsets.left + self.textInsets.right;
    frame.size.width = width > self.maxWidth?self.maxWidth : width;
    frame.size.width = width < self.minWidth?self.minWidth : width;
    CGFloat height = CGRectGetHeight(self.bounds) + self.textInsets.top + self.textInsets.bottom;
    frame.size.height = MAX(height, self.minHeight);
    self.frame = frame;
}

/**
 *  窗口的大小
 */
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    if (bounds.size.width<self.minWidth) {
        bounds.size.width=self.minWidth;
    }
    return bounds;
}

@end




static CFTimeInterval const kStayDuration = 1.75f;

static CFTimeInterval const kAnimationDismissDuration = 0.25f;

@interface JZToast()

/** 主背景 */
@property(weak, nonatomic) UIView *bg;

/** 文字提示 */
@property(weak, nonatomic) JZTipLabel *tipLabel;

/** 动画消失时间 */
@property(assign, nonatomic) CFTimeInterval animationDismissDuration;

/** 动画消失回调 */
@property(copy, nonatomic) void(^dismissBlock)(void);

@end

@implementation JZToast

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self toastBasicConfig];
        [self initToastComponents];
    }
    return  self;
}

+ (void)messageToastWithMessage:(NSString *)message{
    [self toastWithType:JZToastTypeDefault message:message];
}

+ (void)messageToastWithMessage:(NSString *)message completion:(void(^)(void))completionBlock{
    [self toastWithType:JZToastTypeDefault message:message completion:completionBlock];
    
}

+ (void)successToastWithMessage:(NSString *)message{
    [self toastWithType:JZToastTypeSuccess message:message];
}
+ (void)successToastWithMessage:(NSString *)message completion:(void(^)(void))completionBlock{
    [self toastWithType:JZToastTypeSuccess message:message completion:completionBlock];
}

+ (void)errorToastWithMessage:(NSString *)message{
    [self toastWithType:JZToastTypeError message:message];
}
+ (void)errorToastWithMessage:(NSString *)message completion:(void(^)(void))completionBlock{
    [self toastWithType:JZToastTypeError message:message completion:completionBlock];
}

+ (void)errorToastKeepResponderWithMessage:(NSString *)message {
    if (!message.length)return;
    JZToast *toast = [[JZToast alloc] init];
    for (UIView *itemView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([itemView isKindOfClass:[JZToast class]]){
            [itemView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
                obj = nil;
            }];
            [itemView removeFromSuperview];
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:toast];
    toast.frame = UIScreen.mainScreen.bounds;
    [toast setCommponentsWithType:JZToastTypeError message:message dismiss:nil];
}

+ (void)warningToastWithMessage:(NSString *)message{
    [self toastWithType:JZToastTypeWarning message:message];
}
+ (void)warningToastWithMessage:(NSString *)message completion:(void(^)(void))completionBlock{
    [self toastWithType:JZToastTypeWarning message:message completion:completionBlock];
}

/**
 * 自定义提示（自定义键盘的情况）
 */
+ (void)customKeyboardToastWithType:(JZToastType)toastType message:(NSString *)message{
    [self toastWithType:toastType message:message handelCustonKayboard:YES];
}

+ (void)toastWithType:(JZToastType)toastType message:(NSString *)message{
    [self toastWithType:toastType message:message handelCustonKayboard:NO];
}
+ (void)toastWithType:(JZToastType)toastType message:(NSString *)message completion:(void(^)(void))dismissBlock{
    [self toastWithType:toastType message:message handelCustonKayboard:NO dismiss:dismissBlock];
}

+ (void)toastWithType:(JZToastType)toastType message:(NSString *)message handelCustonKayboard:(BOOL)handelCustonKayboard{
    [self toastWithType:toastType message:message handelCustonKayboard:handelCustonKayboard dismiss:nil];
}
+ (void)toastWithType:(JZToastType)toastType message:(NSString *)message handelCustonKayboard:(BOOL)handelCustonKayboard dismiss:(void(^)(void))dismissBlock{
    if (![message isKindOfClass:[NSString class]] ||!message.length)return;
    dispatch_async(dispatch_get_main_queue(), ^{
        JZToast *toast = [[JZToast alloc] init];
        for (UIView *itemView in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([itemView isKindOfClass:[JZToast class]]){
                [itemView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj removeFromSuperview];
                    obj = nil;
                }];
                [itemView removeFromSuperview];
            }
        }
        [[UIApplication sharedApplication].keyWindow addSubview:toast];
        toast.frame = UIScreen.mainScreen.bounds;
        [toast setCommponentsWithType:toastType message:message dismiss:dismissBlock];
    });
//    //退出键盘
//    [kWindow endEditing:YES];

}
/**
 *  设置子控件
 */
- (void)setCommponentsWithType:(JZToastType)toastType message:(NSString *)message{
    [self setCommponentsWithType:toastType message:message dismiss:nil];
}
- (void)setCommponentsWithType:(JZToastType)toastType message:(NSString *)message dismiss:(void(^)(void))dismissBlock{
    switch (toastType) {
        case JZToastTypeDefault:
            [self toastTypeDefaultWithMessage:message dismiss:dismissBlock];
            break;
        case JZToastTypeSuccess:
            [self toastTypeSuccessWithMessage:message dismiss:dismissBlock];
            break;
        case JZToastTypeError:
            [self toastTypeErrorWithMessage:message dismiss:dismissBlock];
            break;
        case JZToastTypeWarning:
            [self toastTypeWarningWithMessage:message dismiss:dismissBlock];
            break;
    }
}
/**
 *  默认模式
 */
- (void)toastTypeDefaultWithMessage:(NSString *)message{
    [self toastTypeDefaultWithMessage:message dismiss:nil];
    
}

- (void)toastTypeDefaultWithMessage:(NSString *)message dismiss:(void(^)(void))dismissBlock{
    //文字信息
    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 60.f;
    CGFloat textMargin = 10.f;
    UIEdgeInsets textInsets = UIEdgeInsetsMake(textMargin, textMargin, textMargin, textMargin);
    JZTipLabel *tipLabel = [[JZTipLabel alloc] initWithText:message textEdgeInsets:textInsets maxWidth:maxWidth minWidth:200.f minHeight:50.f];
    tipLabel.layer.cornerRadius = 10;
    tipLabel.layer.masksToBounds = YES;
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
    
    //自动消失
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kStayDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf addDismissAnimationWithView:tipLabel];
        weakSelf.dismissBlock = ^{
            !dismissBlock?:dismissBlock();
        };
    });
    
}

/**
 *  成功操作
 */
- (void)toastTypeSuccessWithMessage:(NSString *)message {
    [self iconToastWithType:JZToastTypeSuccess message:message];
}
- (void)toastTypeSuccessWithMessage:(NSString *)message dismiss:(void(^)(void))dismissBlock{
    [self iconToastWithType:JZToastTypeSuccess message:message dismiss:dismissBlock];
}
/**
 *  错误操作
 */
- (void)toastTypeErrorWithMessage:(NSString *)message{
    [self iconToastWithType:JZToastTypeError message:message];
}
- (void)toastTypeErrorWithMessage:(NSString *)message dismiss:(void(^)(void))dismissBlock{
    [self iconToastWithType:JZToastTypeError message:message dismiss:dismissBlock];
}
/**
 *  警告操作
 */
- (void)toastTypeWarningWithMessage:(NSString *)message{
    [self iconToastWithType:JZToastTypeWarning message:message];
}
- (void)toastTypeWarningWithMessage:(NSString *)message dismiss:(void(^)(void))dismissBlock{
    [self iconToastWithType:JZToastTypeWarning message:message dismiss:dismissBlock];
}

/**
 * 设置类型显示图片
 */
- (void)iconToastWithType:(JZToastType)toastType message:(NSString *)message{
    [self iconToastWithType:toastType message:message dismiss:nil];
}
- (void)iconToastWithType:(JZToastType)toastType message:(NSString *)message dismiss:(void(^)(void))dismissBlock{
    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds])*0.5;
    CGFloat minWidth = 90.f;
    CGFloat textMargin = 14.f;
    CGFloat picTopMargin = 25.f;
    CGFloat picBottomMargin = 13.f;
    CGFloat picWH = 32.f;
    UIEdgeInsets textInsets = UIEdgeInsetsMake(picTopMargin+picWH+picBottomMargin, textMargin, textMargin, textMargin);
    JZTipLabel *tipLabel = [[JZTipLabel alloc] initWithText:message textEdgeInsets:textInsets maxWidth:maxWidth minWidth:minWidth minHeight:0];
    tipLabel.layer.cornerRadius = 6.f;
    tipLabel.layer.masksToBounds = YES;
    UIImageView *successIcon = [[UIImageView alloc] initWithImage:[self imageWithType:toastType]];
    [tipLabel addSubview:successIcon];
    successIcon.frame = CGRectMake(0, picTopMargin, picWH, picWH);
    successIcon.center = CGPointMake(tipLabel.center.x, successIcon.center.y);
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
    [self autoDismissWithBlock:dismissBlock];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _tipLabel.center = self.center;
}

/**
 *  基本配置
 */
- (void)toastBasicConfig{
    self.userInteractionEnabled = NO;
}

/**
 *  初始化子控件
 */
- (void)initToastComponents{
    //主背景
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = UIColor.blackColor;
    [self addSubview:bg];
    _bg = bg;
}

/**
 *  显示动画
 */
- (void)addShowAnimationWithView:(UIView *)view {
    
    view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kAnimationDismissDuration];
    view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}

/**
 *  消失动画
 */
- (void)addDismissAnimationWithView:(UIView *)view{
    view.alpha = 1.0f;
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kAnimationDismissDuration];
    view.alpha = 0.2f;
    view.transform = CGAffineTransformMakeScale(0.85f, 0.85f);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView commitAnimations];
}

/**
 *  自动消失
 */
- (void)autoDismissWithBlock:(void(^)(void))dismissBlock{
    //自动消失
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kStayDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf addDismissAnimationWithView:weakSelf.tipLabel];
        weakSelf.dismissBlock = ^{
            !dismissBlock?:dismissBlock();
        };
    });
}

/**
 *  移除控件
 */
- (void)dismissToast{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
    !self.dismissBlock?:self.dismissBlock();
}
/**
 *  获取图片
 */
- (UIImage *)imageWithType:(JZToastType)toastType{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSBundle *imageBundle = nil;
    if(bundle){
        NSURL *url = [bundle URLForResource:@"JZToast" withExtension:@"bundle"];
        if (url) {
            imageBundle = [NSBundle bundleWithURL:url];
        }
    }
    if (!imageBundle) return nil;
    switch (toastType) {
        case JZToastTypeDefault:
            return nil;
            break;
        case JZToastTypeSuccess:
            return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"succeed" ofType:@"png"]];
            break;
        case JZToastTypeError:
            return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
            break;
        case JZToastTypeWarning:
            return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"warning" ofType:@"png"]];
            break;
    }
}


@end
