//
//  UIView+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objc/runtime.h"

typedef enum : NSUInteger {
    CYTGradientDirectionHorizontal = 0, //水平方向渐变
    CYTGradientDirectionVertical,  //垂直方向渐变
} CYTGradientDirection;

@interface UIView (Extension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

+ (UIView *)foundViewInView:(UIView *)view clazzName:(NSString *)clazzName;

- (void)setCornerRadius:(CGFloat)cornerRadius withBackgroundColor:(UIColor *)bgColor;

- (void)addTapGestureRecognizerWithTap:(void(^)(UITapGestureRecognizer *tap))tapBlock;

- (void)addLongTapGestureRecognizerWithTap:(void(^)(UILongPressGestureRecognizer *longTap))tapBlock;
/**
 *  渐变颜色
 *  @param direction    渐变方向
 *  @param colors       渐变颜色数组
 */
- (void)gradientColorWithDirection:(CYTGradientDirection)direction colors:(NSArray *)colors frame:(CGRect)frame;
/**
 *  移除所有子控件
 */
- (void)removeAllSubviews;
/**
 *  是否在当前视图中
 */
- (BOOL)isVisibleOnKeyWindow;
@end
