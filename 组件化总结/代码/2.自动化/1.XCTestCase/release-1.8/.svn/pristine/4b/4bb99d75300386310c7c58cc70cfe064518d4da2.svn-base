//
//  CYTAlertView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAlertView.h"


static CFTimeInterval const kDefaultAnimationDuration = 0.25f;

#define kBgColor CYTHexColor(@"#000000")


@interface CYTAlertView()<CAAnimationDelegate>


/** 弹框 */
@property(weak, nonatomic) UIImageView *alertView;

/** 标题 */
@property(weak, nonatomic) UILabel *titleLabel;

/** 消息 */
@property(weak, nonatomic) UILabel *messageLabel;

/** 取消按钮 */
@property(weak, nonatomic) UIButton *cancelBtn;

/** 确定按钮 */
@property(weak, nonatomic) UIButton *confirmBtn;

/** 单个按钮 */
@property(weak, nonatomic) UIButton *signalBtn;

/** 水平分割线 */
@property(weak, nonatomic) UILabel *hLineLabel;

/** 上下分割线 */
@property(weak, nonatomic) UILabel *upDowmLineLabel;

/** 模糊视图 */
@property(weak, nonatomic) UIVisualEffectView *effectView;

/** 移除标致 */
@property(assign, nonatomic) BOOL flag;

@end


@implementation CYTAlertView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self alertViewBasicConfig];
    }
    return  self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmAction:(void (^)())confirmAction cancelAction:(void (^)())cancelAction signalButton:(BOOL)showSignalBtn autoDismiss:(BOOL)autoDismiss{
    //退出键盘
    [kWindow endEditing:YES];
    CYTAlertView *alertViewBg = [[CYTAlertView alloc] init];
    [alertViewBg initAlertViewComponentsWithSignalButton:showSignalBtn];
    [kWindow addSubview:alertViewBg];
    [alertViewBg addShowAnimationWithView:alertViewBg.alertView];
    [alertViewBg addShowAnimationWithView:alertViewBg.effectView];
    [alertViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    if (title.length) {
        alertViewBg.titleLabel.text = title;
    }
    if (msg.length) {
        alertViewBg.messageLabel.text = msg;
    }
    
    CGFloat alertViewWidth = CYTAutoLayoutH(540.f);
    CGFloat alertMarginW = CYTAutoLayoutH(40.f);
    CGFloat alertMarginH = CYTAutoLayoutV(40.f);
    CGFloat buttonH = CYTAutoLayoutV(90.f);
    CGSize labelMaxSize = CGSizeMake(alertViewWidth-2*alertMarginW, CGFLOAT_MAX);
    CGFloat titleHight = 0;
    CGFloat messageHight = 0;
    //标题适配
    if (title.length) {
        //设置字体大小
        alertViewBg.titleLabel.font = CYTBoldFontWithPixel(32);
        alertViewBg.messageLabel.font = CYTFontWithPixel(30);
        //计算字体高度
        titleHight = [title sizeWithFont:alertViewBg.titleLabel.font maxSize:labelMaxSize].height;
        messageHight = [msg sizeWithFont:alertViewBg.messageLabel.font maxSize:labelMaxSize].height;
        //标题布局
        [alertViewBg.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertViewBg.alertView).offset(alertMarginH);
            make.left.equalTo(alertViewBg.alertView).offset(CYTAutoLayoutH(alertMarginW));
            make.right.equalTo(alertViewBg.alertView).offset(-CYTAutoLayoutH(alertMarginW));
        }];
        
        //内容布局
        [alertViewBg.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertViewBg.titleLabel.mas_bottom).offset(alertMarginH*0.5);
            make.left.equalTo(alertViewBg.alertView).offset(CYTAutoLayoutH(alertMarginW));
            make.right.equalTo(alertViewBg.alertView).offset(-CYTAutoLayoutH(alertMarginW));
        }];
    }else{
        alertViewBg.messageLabel.font = CYTFontWithPixel(32);
        //计算字体高度
        messageHight = [msg sizeWithFont:alertViewBg.messageLabel.font maxSize:labelMaxSize].height;
        //内容布局
        [alertViewBg.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertViewBg.alertView).offset(alertMarginH);
            make.left.equalTo(alertViewBg.alertView).offset(CYTAutoLayoutH(alertMarginW));
            make.right.equalTo(alertViewBg.alertView).offset(-CYTAutoLayoutH(alertMarginW));
        }];
    }
    
    //布局按钮
    [alertViewBg.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertViewBg.alertView);
        make.width.equalTo(alertViewBg.alertView).dividedBy(2);
        make.height.equalTo(buttonH);
        make.bottom.equalTo(alertViewBg.alertView);
    }];
    
    [alertViewBg.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(alertViewBg.alertView);
        make.width.equalTo(alertViewBg.alertView).dividedBy(2);
        make.height.equalTo(buttonH);
        make.bottom.equalTo(alertViewBg.alertView);
    }];
    
    [alertViewBg.signalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(alertViewBg.alertView);
        make.bottom.equalTo(alertViewBg.alertView);
        make.height.equalTo(buttonH);
    }];
    
    //布局分割线
    [alertViewBg.hLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(alertViewBg.alertView);
        make.bottom.equalTo(alertViewBg.cancelBtn.mas_top);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [alertViewBg.upDowmLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertViewBg.alertView);
        make.top.equalTo(alertViewBg.hLineLabel.mas_bottom);
        make.width.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(alertViewBg.alertView);
    }];
    
    
    
    //布局弹框
    [alertViewBg.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(alertViewBg);
        make.width.equalTo(alertViewWidth);
        if (title.length) {
            make.height.equalTo(alertMarginH+titleHight+alertMarginH*0.5+messageHight+alertMarginH+CYTDividerLineWH+buttonH);
        }else{
            make.height.equalTo(alertMarginH+messageHight+alertMarginH+CYTDividerLineWH+buttonH);
        }
        
    }];
    
    [alertViewBg.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(alertViewBg.alertView);
    }];
    if (showSignalBtn) {
        //自定义右边文字
        [alertViewBg.signalBtn setTitle:confirmTitle forState:UIControlStateNormal];
        [[alertViewBg.signalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !confirmAction?:confirmAction();
            if (autoDismiss) {
                [alertViewBg dismissActionWithAnimation:NO];
            }
        }];
    }else{
        //自定义右边文字
        [alertViewBg.confirmBtn setTitle:confirmTitle forState:UIControlStateNormal];
        [[alertViewBg.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [alertViewBg dismissActionWithAnimation:NO];
            !cancelAction?:cancelAction();
            
        }];
        [[alertViewBg.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [alertViewBg dismissActionWithAnimation:NO];
            !confirmAction?:confirmAction();
            
        }];
    }
    
    return alertViewBg;

}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmAction:(void (^)())confirmAction signalButton:(BOOL)showSignalBtn autoDismiss:(BOOL)autoDismiss{
    return [self alertViewWithTitle:title message:msg confirmTitle:confirmTitle confirmAction:confirmAction cancelAction:nil signalButton:showSignalBtn autoDismiss:autoDismiss];
}

/**
 *  基本配置
 */
- (void)alertViewBasicConfig{
    self.backgroundColor = [kBgColor colorWithAlphaComponent:0.0];
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        self.backgroundColor = [kBgColor colorWithAlphaComponent:0.4];
    }];
}
/**
 *  自定义view
 */
+ (instancetype)alertViewWithTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle customView:(UIView *)customView confirmAction:(void(^)(UIView *))confirmAction{
    //退出键盘
    [kWindow endEditing:YES];
    CYTAlertView *alertViewBg = [[CYTAlertView alloc] init];
    [alertViewBg initAlertViewComponentsWithSignalButton:NO];
    [kWindow addSubview:alertViewBg];
    [alertViewBg addShowAnimationWithView:alertViewBg.alertView];
    [alertViewBg addShowAnimationWithView:alertViewBg.effectView];
    [alertViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    if (title.length) {
        alertViewBg.titleLabel.text = title;
    }
    CGFloat alertViewWidth = kScreenWidth - CYTAutoLayoutH(180.f);
    CGFloat alertMarginW = CYTAutoLayoutH(20.f);
    CGFloat alertMarginH = CYTAutoLayoutV(45.f);
    CGFloat buttonH = CYTAutoLayoutV(90.f);
    CGFloat titleHight = 0;
    CGSize labelMaxSize = CGSizeMake(alertViewWidth-2*alertMarginW, CGFLOAT_MAX);
    if (title.length) {
        //设置字体大小
        alertViewBg.titleLabel.font = CYTBoldFontWithPixel(32);
        //计算字体高度
        titleHight = [title sizeWithFont:alertViewBg.titleLabel.font maxSize:labelMaxSize].height;
        //标题布局
        [alertViewBg.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertViewBg.alertView).offset(alertMarginH);
            make.left.equalTo(alertViewBg.alertView).offset(CYTAutoLayoutH(alertMarginW));
            make.right.equalTo(alertViewBg.alertView).offset(-CYTAutoLayoutH(alertMarginW));
        }];
    }
    
    //布局自定义view
    [alertViewBg.alertView addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(alertViewBg.titleLabel.mas_bottom).offset(alertMarginH);
        make.left.right.equalTo(alertViewBg.alertView);
        [customView layoutIfNeeded];
        make.height.equalTo(customView.height);
    }];
    
    //布局按钮
    [alertViewBg.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(alertViewBg.alertView);
        make.width.equalTo(alertViewBg.alertView).dividedBy(2);
        make.height.equalTo(buttonH);
        make.bottom.equalTo(alertViewBg.alertView);
    }];
    
    [alertViewBg.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(alertViewBg.alertView);
        make.width.equalTo(alertViewBg.alertView).dividedBy(2);
        make.height.equalTo(buttonH);
        make.bottom.equalTo(alertViewBg.alertView);
    }];
    
    [alertViewBg.signalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(alertViewBg.alertView);
        make.bottom.equalTo(alertViewBg.alertView);
        make.height.equalTo(buttonH);
    }];
    
    //布局分割线
    [alertViewBg.hLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(alertViewBg.alertView);
        make.bottom.equalTo(alertViewBg.cancelBtn.mas_top);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [alertViewBg.upDowmLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alertViewBg.alertView);
        make.top.equalTo(alertViewBg.hLineLabel.mas_bottom);
        make.width.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(alertViewBg.alertView);
    }];
    
    
    
    //布局弹框
    [alertViewBg.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(alertViewBg);
        make.width.equalTo(alertViewWidth);
        if (title.length) {
            make.height.equalTo(alertMarginH+titleHight+alertMarginH*0.5+alertMarginH+CYTDividerLineWH+buttonH+customView.height+alertMarginH);
        }else{
            make.height.equalTo(alertMarginH+alertMarginH+CYTDividerLineWH+buttonH+customView.height+alertMarginH);
        }
        
    }];
    
    [alertViewBg.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(alertViewBg.alertView);
    }];
    //自定义右边文字
    [alertViewBg.confirmBtn setTitle:confirmTitle forState:UIControlStateNormal];
    [[alertViewBg.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !confirmAction?:confirmAction(customView);
        [alertViewBg dismissActionWithAnimation:NO];
    }];
    
    return alertViewBg;


}


+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmAction:(void(^)())confirmAction{    
    [CYTAlertView alertViewWithTitle:title message:msg confirmTitle:@"确定" confirmAction:^{
        !confirmAction?:confirmAction();
    } signalButton:NO autoDismiss:YES];
}

+ (void)alertViewWithMessage:(NSString *)msg confirmAction:(void(^)())confirmAction{
    [CYTAlertView alertViewWithTitle:nil message:msg confirmTitle:@"确定" confirmAction:^{
        !confirmAction?:confirmAction();
    } signalButton:NO autoDismiss:YES];
}

+ (void)singleButtonWithMessage:(NSString *)msg buttonTitle:(NSString *)title confirmAction:(void(^)())confirmAction autoDismiss:(BOOL)autoDismiss{
    [CYTAlertView alertViewWithTitle:nil message:msg confirmTitle:title confirmAction:^{
        !confirmAction?:confirmAction();
    } signalButton:YES autoDismiss:autoDismiss];
}

/**
 *  初始化子控件
 */
- (void)initAlertViewComponentsWithSignalButton:(BOOL)showSignalBtn{
    //添加毛玻璃效果
    CGFloat cornerRadius = 13.f;
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:beffect];
    effectView.layer.cornerRadius = cornerRadius;
    effectView.clipsToBounds = YES;
    effectView.userInteractionEnabled = YES;
    effectView.alpha = 0.9f;
    [self addSubview:effectView];
    _effectView = effectView;
    //弹框
    UIImageView *alertView = [[UIImageView alloc] init];
    alertView.userInteractionEnabled = YES;
    UIColor *alertViewBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    alertView.backgroundColor = alertViewBgColor;
    alertView.layer.cornerRadius = cornerRadius;
    alertView.clipsToBounds = YES;
    [self addSubview:alertView];
    _alertView = alertView;
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //内容
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:messageLabel];
    _messageLabel = messageLabel;
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#eeeeee")] forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = CYTBoldFontWithPixel(34.f);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
    [cancelBtn setTitleColor:CYTGreenHighlightColor forState:UIControlStateHighlighted];
    [alertView addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissActionWithAnimation:YES];
    }];

    
    //确认按钮
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#eeeeee")] forState:UIControlStateHighlighted];
    confirmBtn.titleLabel.font = CYTBoldFontWithPixel(34.f);
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
    [confirmBtn setTitleColor:CYTGreenHighlightColor forState:UIControlStateHighlighted];
    [alertView addSubview:confirmBtn];
    _confirmBtn = confirmBtn;
    
    //水平分割线
    UILabel *hLineLabel = [[UILabel alloc] init];
    hLineLabel.backgroundColor = kFFColor_line;
    [alertView addSubview:hLineLabel];
    _hLineLabel = hLineLabel;

    
    //上下分割线
    UILabel *upDowmLineLabel = [[UILabel alloc] init];
    upDowmLineLabel.backgroundColor = kFFColor_line;
    [alertView addSubview:upDowmLineLabel];
    _upDowmLineLabel = upDowmLineLabel;
    
    if (showSignalBtn) {
        _cancelBtn.hidden = YES;
        _confirmBtn.hidden = YES;
        _upDowmLineLabel.hidden = YES;
        UIButton *signalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        signalBtn.layer.cornerRadius = cornerRadius;
        signalBtn.clipsToBounds = YES;
        [signalBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#eeeeee")] forState:UIControlStateHighlighted];
        signalBtn.titleLabel.font = CYTBoldFontWithPixel(34.f);
        [signalBtn setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
        [signalBtn setTitleColor:CYTGreenHighlightColor forState:UIControlStateHighlighted];
        [self.alertView addSubview:signalBtn];
        _signalBtn = signalBtn;
    }
    

    
}
/**
 *  显示动画
 */
- (void)addShowAnimationWithView:(UIView *)view{
    view.transform = CGAffineTransformMakeScale(0.2f, 0.2f);
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:kDefaultAnimationDuration];
    view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}

/**
 *  消失动画
 */
- (void)addDismissAnimationWithView:(UIView *)view{
    view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:kDefaultAnimationDuration];
    view.transform = CGAffineTransformMakeScale(0.2f, 0.2f);
    [UIView setAnimationDidStopSelector:@selector(dismissActionWithAnimation:)];
    [UIView commitAnimations];
}
/**
 *  移除操作
 */
- (void)dismissActionWithAnimation:(BOOL)animation{
    if (!animation) {
        [self removeFromSuperview];
        return;
    }
    [self addDismissAnimationWithView:_alertView];
    [self addDismissAnimationWithView:_effectView];
    self.backgroundColor = [kBgColor colorWithAlphaComponent:0.4];
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        self.backgroundColor = [kBgColor colorWithAlphaComponent:0.0];
    }completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}



/**
 *  图片选择
 */
+ (void)selectPhotoAlertWithTakePhoto:(void(^)(UIAlertAction *action))takePhotoAction album:(void(^)(UIAlertAction *action))albumAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle:@"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        !takePhotoAction?:takePhotoAction(action);
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        !albumAction?:albumAction(action);
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    [[CYTCommonTool currentViewController] presentViewController: alertController animated: YES completion: nil];
}

/**
 *  Alert 提示
 */
+ (void)alertTipWithTitle:(NSString *)title message:(NSString *)message confiemAction:(void(^)(UIAlertAction *action))confiemAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confiemAction) {
            confiemAction(action);
        }
    }];
    [alert addAction:okAction];
    [[CYTCommonTool currentViewController] presentViewController:alert animated:true completion:nil];
}
/**
 *  Alert 确定取消
 */
+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmAction:(void (^)())confirmAction cancelAction:(void (^)())cancelAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmAction) {
            confirmAction(action);
        }
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancelAction) {
            cancelAction(action);
        }
    }];
    [alert addAction:cancleAction];
    [alert addAction:okAction];
    [[CYTCommonTool currentViewController] presentViewController:alert animated:true completion:nil];
}

/**
 * ActionSheet
 */
+ (void)actionSheetWithTitle:(NSString *)title confirmAction:(void (^)())confirmAction cancelAction:(void (^)())cancelAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle:title style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        !confirmAction?:confirmAction(action);
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        !cancelAction?:cancelAction(action);
    }]];
    [[CYTCommonTool currentViewController] presentViewController: alertController animated: YES completion: nil];
}




@end
