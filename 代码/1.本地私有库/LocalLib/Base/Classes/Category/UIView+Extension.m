//
//  UIView+Extension.m
//  
//
//  Created by Jentle on 2020/6/10.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/**
 *  size的setter和getter方法
 */
- (void)setSize:(CGSize)aSize{
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


@end
