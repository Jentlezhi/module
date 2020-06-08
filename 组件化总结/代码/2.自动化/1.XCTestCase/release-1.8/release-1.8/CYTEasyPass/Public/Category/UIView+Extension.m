//
//  UIView+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/7.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/**
 *  size的setter和getter方法
 */
-(void)setSize:(CGSize)aSize{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGSize)size{
    return self.frame.size;
}
/**
 *  origin的setter和getter方法
 */
- (void)setOrigin:(CGPoint)aOrigin{
    CGRect newframe = self.frame;
    newframe.origin = aOrigin;
    self.frame = newframe;
}

- (CGPoint)origin{
    return self.frame.origin;
}
/**
 *  width的setter和getter方法
 */
-(void)setWidth:(CGFloat)aWidth{
    CGRect newframe = self.frame;
    newframe.size.width = aWidth;
    self.frame = newframe;
}

- (CGFloat)width{
    return self.frame.size.width;
}

/**
 *  height的setter和getter方法
 */

- (void)setHeight:(CGFloat)aHeight{
    CGRect newframe = self.frame;
    newframe.size.height = aHeight;
    self.frame = newframe;
}

- (CGFloat)height{
    return self.frame.size.height;
}

/**
 *  x的setter和getter方法
 */

- (void)setX:(CGFloat)aX{
    CGRect newframe = self.frame;
    newframe.origin.x = aX;
    self.frame = newframe;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

/**
 *  y的setter和getter方法
 */
- (void)setY:(CGFloat)aY{
    CGRect newframe = self.frame;
    newframe.origin.y = aY;
    self.frame = newframe;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

/**
 *  centerX的setter和getter方法
 */

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

/**
 *  centerY的setter和getter方法
 */
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}

- (BOOL)isVisibleOnKeyWindow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (UIView *)foundViewInView:(UIView *)view clazzName:(NSString *)clazzName {
    // 递归出口
    if ([view isKindOfClass:NSClassFromString(clazzName)]) {
        return view;
    }
    // 遍历所有子视图
    for (UIView *subView in view.subviews) {
        UIView *foundView = [self foundViewInView:subView clazzName:clazzName];
        if (foundView) {
            return foundView;
        }
    }
    return nil;
}


- (void)setCornerRadius:(CGFloat)cornerRadius withBackgroundColor:(UIColor *)bgColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.backgroundColor = bgColor;
}

- (void)addTapGestureRecognizerWithTap:(void(^)(UITapGestureRecognizer *))tapBlock{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        !tapBlock?:tapBlock(tap);
    }];
}

- (void)addLongTapGestureRecognizerWithTap:(void(^)(UILongPressGestureRecognizer *))tapBlock{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] init];
    [self addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        if (tap.state == UIGestureRecognizerStateBegan) {
            !tapBlock?:tapBlock(tap);
        }
    }];
}

- (void)gradientColorWithDirection:(CYTGradientDirection)direction colors:(NSArray *)colors frame:(CGRect)frame{
    if (!colors || !colors.count) return;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.locations = @[@0,@0.5,@1.0];
    if (direction == CYTGradientDirectionVertical) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1.0);
    }else{
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIColor *itemColor in colors) {
        [tempArray addObject:(__bridge id)itemColor.CGColor];
    }
    gradientLayer.colors = [NSArray arrayWithArray:tempArray];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)removeAllSubviews{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        obj = nil;
    }];
}

@end
