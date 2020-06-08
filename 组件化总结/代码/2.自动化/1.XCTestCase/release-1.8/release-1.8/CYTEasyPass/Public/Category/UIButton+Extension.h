//
//  UIButton+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/8.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CYTButtonEdgeInsetsStyle) {
    CYTButtonEdgeInsetsStyleTop, // image在上，label在下
    CYTButtonEdgeInsetsStyleLeft, // image在左，label在右
    CYTButtonEdgeInsetsStyleBottom, // image在下，label在上
    CYTButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Extension)

/** 按钮状态 */
@property(assign, nonatomic) BOOL originStatus;

/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *  @param target         SEL目标
 *  @param action         按钮点击行为
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *  @param action         按钮点击行为
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithBackgroundNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage;
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *  @param target         SEL目标
 *  @param action         按钮点击行为
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action;
/**
 *  创建按钮
 *
 *  @param normalImage    普通状态下图片
 *  @param highlightImage 高亮状态下图片
 *
 *  @return 按钮
 */
+ (instancetype)buttonWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlightImage;
/**
 *  设置状态颜色
 *
 *  @param normalColor    普通状态下颜色
 *  @param highlightColor 高亮状态下颜色
 *
 *  @return 该按钮
 */
- (instancetype)setTitleColorWithNormalColor:(UIColor *)normalColor  highlightColor:(UIColor *)highlightColor;
/**
 * 设置带有border的按钮 普通按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)btnTitle titleFont:(CGFloat)fontPixel titleColor:(UIColor *)titleColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;
/**
 * 设置普通按钮 绿色按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title enabled:(BOOL)enabled;
/**
 * 设置普通按钮 绿色按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title;
/**
 * 设置带有border的按钮,“复制”类型按钮
 */
+ (instancetype)buttonWithTitle:(NSString *)title textFontPixel:(CGFloat)fontPixel textColor:(UIColor *)textColor cornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(CYTButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
/**
 *  设置自定义圆角和字体大小的按钮
 *
 *  @param title        标题
 *  @param fontPixel    标题字体大小
 *  @param cornerRadius 圆角大小
 */
+ (instancetype)borderButtonWithTitle:(NSString *)title titleFontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)cornerRadius;
/**
 *  标签
 */
+ (instancetype)tagButtonWithTextColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;
/**
 *  标签
 */
+ (instancetype)tagButtonWithText:(NSString *)text textColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;

@end
