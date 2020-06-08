//
//  UIView+FFCommon.m
//  FFObjC
//
//  Created by xujunquan on 16/12/6.
//  Copyright © 2016年 org_ian. All rights reserved.
//

#import "UIView+FFCommon.h"

@implementation UIView (FFCommon)
///设置圆角
- (void)radius:(float)radius borderWidth:(float)width borderColor:(UIColor *)color{
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}

@end
