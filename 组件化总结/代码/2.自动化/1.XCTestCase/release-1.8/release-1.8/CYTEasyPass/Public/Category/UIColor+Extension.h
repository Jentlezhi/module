//
//  UIColor+Extension.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**  十六进制色值转化为UIColor
 *
 *  @param hexValue 十六进制色值
 *  @param alpha  透明度
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexColor:(NSString *)hexValue alpha:(float)alpha;
/**  十六进制色值转化为UIColor
 *
 *  @param hexValue 十六进制色值
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexColor:(NSString *)hexValue;
/**
 *  随机颜色
 */
+ (instancetype)randomColor;

@end
