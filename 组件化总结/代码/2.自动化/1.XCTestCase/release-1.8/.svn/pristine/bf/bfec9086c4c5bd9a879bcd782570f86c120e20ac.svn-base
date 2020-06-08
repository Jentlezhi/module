//
//  CYTToast.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTToast.h"
#import "CYTTipLabel.h"

static CFTimeInterval const kStayDuration = 1.75f;

static CFTimeInterval const kAnimationDismissDuration = 0.25f;

#define kBgNormalColor [[UIColor colorWithHexColor:@"#000000"] colorWithAlphaComponent:0.7f];

BOOL handelKayboard;

@interface CYTToast()

/** 主背景 */
@property(weak, nonatomic) UIView *bg;

/** 文字提示 */
@property(weak, nonatomic) CYTTipLabel *tipLabel;

/** 动画消失时间 */
@property(assign, nonatomic) CFTimeInterval animationDismissDuration;

/** 动画消失回调 */
@property(copy, nonatomic) void(^dismissBlock)();

@end

@implementation CYTToast

+ (instancetype)sharedToast{
    static CYTToast *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self toastBasicConfig];
        [self initToastComponents];
        [self makeConstrains];
    }
    return  self;
}

+ (void)messageToastWithMessage:(NSString *)message{
    [self toastWithType:CYTToastTypeDefault message:message];
}

+ (void)messageToastWithMessage:(NSString *)message completion:(void(^)())completionBlock{
    [self toastWithType:CYTToastTypeDefault message:message completion:completionBlock];
    
}

+ (void)successToastWithMessage:(NSString *)message{
    [self toastWithType:CYTToastTypeSuccess message:message];
}
+ (void)successToastWithMessage:(NSString *)message completion:(void(^)())completionBlock{
    [self toastWithType:CYTToastTypeSuccess message:message completion:completionBlock];
}

+ (void)errorToastWithMessage:(NSString *)message{
    [self toastWithType:CYTToastTypeError message:message];
}
+ (void)errorToastWithMessage:(NSString *)message completion:(void(^)())completionBlock{
    [self toastWithType:CYTToastTypeError message:message completion:completionBlock];
}

+ (void)warningToastWithMessage:(NSString *)message{
    [self toastWithType:CYTToastTypeWarning message:message];
}
+ (void)warningToastWithMessage:(NSString *)message completion:(void(^)())completionBlock{
    [self toastWithType:CYTToastTypeWarning message:message completion:completionBlock];
}

/**
 * 自定义提示（自定义键盘的情况）
 */
+ (void)customKeyboardToastWithType:(CYTToastType)toastType message:(NSString *)message{
    [self toastWithType:toastType message:message handelCustonKayboard:YES];
}

+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message{
    [self toastWithType:toastType message:message handelCustonKayboard:NO];
}
+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message completion:(void(^)())dismissBlock{
    [self toastWithType:toastType message:message handelCustonKayboard:NO dismiss:dismissBlock];
}

+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message handelCustonKayboard:(BOOL)handelCustonKayboard{
    [self toastWithType:toastType message:message handelCustonKayboard:handelCustonKayboard dismiss:nil];
}
+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message handelCustonKayboard:(BOOL)handelCustonKayboard dismiss:(void(^)())dismissBlock{
    handelKayboard = handelCustonKayboard;
    if (!message.length)return;
    CYTToast *toast = [CYTToast sharedToast];
    //退出键盘
    [kWindow endEditing:YES];
    for (UIView *itemView in kWindow.subviews) {
        if ([itemView isKindOfClass:[self class]]){
            [toast.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            [toast setCommponentsWithType:toastType message:message];
            return;
        }
    }
    [kWindow addSubview:toast];
    [toast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [toast setCommponentsWithType:toastType message:message dismiss:dismissBlock];
}
/**
 *  设置子控件
 */
- (void)setCommponentsWithType:(CYTToastType)toastType message:(NSString *)message{
    [self setCommponentsWithType:toastType message:message dismiss:nil];
}
- (void)setCommponentsWithType:(CYTToastType)toastType message:(NSString *)message dismiss:(void(^)())dismissBlock{
    switch (toastType) {
        case CYTToastTypeDefault:
            [self toastTypeDefaultWithMessage:message dismiss:dismissBlock];
            break;
        case CYTToastTypeSuccess:
            [self toastTypeSuccessWithMessage:message dismiss:dismissBlock];
            break;
        case CYTToastTypeError:
            [self toastTypeErrorWithMessage:message dismiss:dismissBlock];
            break;
        case CYTToastTypeWarning:
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

- (void)toastTypeDefaultWithMessage:(NSString *)message dismiss:(void(^)())dismissBlock{
    //文字信息
    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - CYTAutoLayoutH(60)*2;
    CGFloat textMargin = 10.f;
    UIEdgeInsets textInsets = UIEdgeInsetsMake(textMargin, textMargin, textMargin, textMargin);
    CYTTipLabel *tipLabel = [[CYTTipLabel alloc] initWithText:message textEdgeInsets:textInsets maxWidth:maxWidth minWidth:0];
    tipLabel.layer.cornerRadius = CYTAutoLayoutH(6);
    tipLabel.layer.masksToBounds = YES;
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
    
    //自动消失
    CYTWeakSelf
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
    [self iconToastWithType:CYTToastTypeSuccess message:message];
}
- (void)toastTypeSuccessWithMessage:(NSString *)message dismiss:(void(^)())dismissBlock{
    [self iconToastWithType:CYTToastTypeSuccess message:message dismiss:dismissBlock];
}
/**
 *  错误操作
 */
- (void)toastTypeErrorWithMessage:(NSString *)message{
    [self iconToastWithType:CYTToastTypeError message:message];
}
- (void)toastTypeErrorWithMessage:(NSString *)message dismiss:(void(^)())dismissBlock{
    [self iconToastWithType:CYTToastTypeError message:message dismiss:dismissBlock];
}
/**
 *  警告操作
 */
- (void)toastTypeWarningWithMessage:(NSString *)message{
    [self iconToastWithType:CYTToastTypeWarning message:message];
}
- (void)toastTypeWarningWithMessage:(NSString *)message dismiss:(void(^)())dismissBlock{
    [self iconToastWithType:CYTToastTypeWarning message:message dismiss:dismissBlock];
}

/**
 * 设置类型显示图片
 */
- (void)iconToastWithType:(CYTToastType)toastType message:(NSString *)message{
    [self iconToastWithType:toastType message:message dismiss:nil];
}
- (void)iconToastWithType:(CYTToastType)toastType message:(NSString *)message dismiss:(void(^)())dismissBlock{
    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds])*0.5;
    CGFloat minWidth = CYTAutoLayoutH(180.f);
    CGFloat textMargin = 14.f;
    CGFloat picTopMargin = 25.f;
    CGFloat picBottomMargin = 13.f;
    CGFloat picWH = 32.f;
    UIEdgeInsets textInsets = UIEdgeInsetsMake(picTopMargin+picWH+picBottomMargin, textMargin, textMargin, textMargin);
    CYTTipLabel *tipLabel = [[CYTTipLabel alloc] initWithText:message textEdgeInsets:textInsets maxWidth:maxWidth minWidth:minWidth];
    tipLabel.layer.cornerRadius = CYTAutoLayoutH(12);
    tipLabel.layer.masksToBounds = YES;
    UIImageView *successIcon = [[UIImageView alloc] initWithImage:[self imageWithType:toastType]];
    [tipLabel addSubview:successIcon];
    [successIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tipLabel);
        make.top.equalTo(tipLabel).offset(picTopMargin);
        make.width.height.equalTo(picWH);
    }];
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
    [self autoDismissWithBlock:dismissBlock];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    if (handelKayboard) {
        _tipLabel.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.4);
    }else{
       _tipLabel.center = self.center;
    }
    
    
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
    bg.backgroundColor = [UIColor clearColor];
    [self addSubview:bg];
    _bg = bg;
}
/**
 *  布局
 */
- (void)makeConstrains{
    //主背景
    [_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

/**
 *  显示动画
 */
- (void)addShowAnimationWithView:(UIView *)view{
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
- (void)autoDismissWithBlock:(void(^)())dismissBlock{
    //自动消失
    CYTWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kStayDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf addDismissAnimationWithView:_tipLabel];
        weakSelf.dismissBlock = ^{
            !dismissBlock?:dismissBlock();
        };
    });
}

/**
 *  移除控件
 */
- (void)dismissToast{
    CYTToast *toast = [CYTToast sharedToast];
    [toast.tipLabel removeFromSuperview];
    [toast removeFromSuperview];
    toast = nil;
    !self.dismissBlock?:self.dismissBlock();
}
/**
 *  获取图片
 */
- (UIImage *)imageWithType:(CYTToastType)toastType{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSBundle *imageBundle = nil;
    if(bundle){
        NSURL *url = [bundle URLForResource:@"CYTToast" withExtension:@"bundle"];
        if (url) {
            imageBundle = [NSBundle bundleWithURL:url];
        }
    }
    if (!imageBundle) return nil;
    switch (toastType) {
        case CYTToastTypeDefault:
            return nil;
            break;
        case CYTToastTypeSuccess:
            return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"succeed" ofType:@"png"]];
            break;
        case CYTToastTypeError:
            return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
            break;
        case CYTToastTypeWarning:
            return [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"warning" ofType:@"png"]];
            break;
    }
}


@end
