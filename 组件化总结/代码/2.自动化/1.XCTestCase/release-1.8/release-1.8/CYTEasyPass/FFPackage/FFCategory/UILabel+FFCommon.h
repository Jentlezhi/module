//
//  UILabel+FFCommon.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FFCommon)

/**
 快速创建label

 @param pxSize 字体大小
 @param color 颜色
 @return label
 */
+ (UILabel *)labelWithFontPxSize:(float)pxSize textColor:(UIColor *)color;


/**
 为label设置不同的字体、颜色

 @param range 被修改的字符串的range
 @param font 字体
 @param color 颜色
 */
- (void)updateWithRange:(NSRange)range font:(UIFont *)font color:(UIColor *)color;


/**
 设置行间距

 @param string 字符串
 @param space 行间距
 */
- (void)updateWithString:(NSString *)string space:(float)space range:(NSRange)range font:(UIFont *)font color:(UIColor *)color;

@end
