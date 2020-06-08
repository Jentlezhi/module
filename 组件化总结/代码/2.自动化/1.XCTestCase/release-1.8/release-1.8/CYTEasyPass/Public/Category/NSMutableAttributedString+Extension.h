//
//  NSMutableAttributedString+Extension.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Extension)

+ (instancetype)attributedStringWithContent:(NSString *)text keyWord:(NSString *)keyWord keyFontPixel:(CGFloat)keyFontPixel keyWordColor:(UIColor *)keyWordColor;

@end
