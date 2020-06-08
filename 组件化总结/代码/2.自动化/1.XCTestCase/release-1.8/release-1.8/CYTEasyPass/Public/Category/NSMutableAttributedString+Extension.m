//
//  NSMutableAttributedString+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+ (instancetype)attributedStringWithContent:(NSString *)text keyWord:(NSString *)keyWord keyFontPixel:(CGFloat)keyFontPixel keyWordColor:(UIColor *)keyWordColor{
    if (!keyWord || !keyWord.length) return nil;
    NSRange keyRange = [text rangeOfString:keyWord];
    if (!text.length || keyRange.location == NSNotFound || keyRange.length == 0) return nil;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributedStr addAttribute:NSFontAttributeName
                          value:CYTFontWithPixel(keyFontPixel)
                          range:keyRange];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:keyWordColor
                          range:keyRange];
    return attributedStr;
}

@end
