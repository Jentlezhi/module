//
//  UIButton+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/8.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "UIButton+Extension.h"

static const char *key = "originStatusKey";

@implementation UIButton (Extension)

- (void)setOriginStatus:(BOOL)originStatus{
    objc_setAssociatedObject(self, key, [NSNumber numberWithBool:originStatus], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)originStatus{
    return [objc_getAssociatedObject(self, key) boolValue];
}

+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage{
   return [UIButton buttonWithBackgroundNormalImage:normalImage highlightImage:highlightImage target:nil action:nil];
}

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage{
    return [UIButton buttonWithNormalImage:normalImage highlightImage:highlightImage target:nil action:nil];
}

- (instancetype)setTitleColorWithNormalColor:(UIColor *)normalColor  highlightColor:(UIColor *)highlightColor{
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
    return self;
}

+ (instancetype)buttonWithTitle:(NSString *)btnTitle titleFont:(CGFloat)fontPixel titleColor:(UIColor *)titleColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    UIButton *defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [defaultBtn setTitle:btnTitle forState:UIControlStateNormal];
    [defaultBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [defaultBtn setBackgroundImage:[UIImage imageWithColor:titleColor] forState:UIControlStateHighlighted];
    defaultBtn.layer.borderWidth = borderWidth;
    defaultBtn.layer.borderColor = titleColor.CGColor;
    defaultBtn.layer.cornerRadius = cornerRadius;
    defaultBtn.layer.masksToBounds = YES;
    defaultBtn.titleLabel.font = CYTFontWithPixel(fontPixel);
    return defaultBtn;
}

+ (instancetype)buttonWithTitle:(NSString *)title{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:title forState:UIControlStateNormal];
    [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
    customBtn.layer.cornerRadius = 4.f;
    customBtn.layer.masksToBounds = YES;
    customBtn.titleLabel.font = CYTFontWithPixel(32.f);
    return customBtn;
}

+ (instancetype)borderButtonWithTitle:(NSString *)title titleFontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)cornerRadius{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:title forState:UIControlStateNormal];
    [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
    customBtn.layer.cornerRadius = cornerRadius;
    customBtn.layer.masksToBounds = YES;
    customBtn.titleLabel.font = CYTFontWithPixel(fontPixel);
    return customBtn;
}


+ (instancetype)buttonWithTitle:(NSString *)title enabled:(BOOL)enabled{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:title forState:UIControlStateNormal];
    [customBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageWithColor:CYTBtnDisableColor] forState:UIControlStateDisabled];
    customBtn.layer.cornerRadius = 4.f;
    customBtn.layer.masksToBounds = YES;
    customBtn.titleLabel.font = CYTFontWithPixel(32.f);
    customBtn.enabled = enabled;
    return customBtn;
}
/**
 * 设置带有border的按钮,“复制”类型按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title textFontPixel:(CGFloat)fontPixel textColor:(UIColor *)textColor cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:title forState:UIControlStateNormal];
    customBtn.titleLabel.font = CYTFontWithPixel(fontPixel);
    [customBtn setTitleColor:textColor forState:UIControlStateNormal];
    [customBtn radius:radius borderWidth:borderWidth borderColor:borderColor];
    return customBtn;
}

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(CYTButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space{
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case CYTButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case CYTButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case CYTButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case CYTButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

+ (instancetype)tagButtonWithTextColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor{
    return [self tagButtonWithText:nil textColor:textColor fontPixel:fontPixel cornerRadius:radius backgroundColor:bgColor];
}

+ (instancetype)tagButtonWithText:(NSString *)text textColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor{
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:text.length?text:@"" forState:UIControlStateNormal];
    [tagBtn setTitleColor:textColor forState:UIControlStateNormal];
    tagBtn.titleLabel.font = CYTFontWithPixel(fontPixel);
    [tagBtn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateNormal];
    CGFloat margin = CYTAutoLayoutV(4.f);
    tagBtn.contentEdgeInsets = UIEdgeInsetsMake(margin*0.5f, margin, margin*0.5f, margin);
    tagBtn.adjustsImageWhenHighlighted = NO;
    tagBtn.adjustsImageWhenDisabled = NO;
    tagBtn.userInteractionEnabled = NO;
    tagBtn.layer.cornerRadius = radius;
    tagBtn.layer.masksToBounds = YES;
    return tagBtn;
}


@end
