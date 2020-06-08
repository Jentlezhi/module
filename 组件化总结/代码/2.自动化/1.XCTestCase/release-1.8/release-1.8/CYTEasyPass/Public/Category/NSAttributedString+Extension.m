//
//  NSAttributedString+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

+ (instancetype)attributedWithLabel:(UILabel *)label lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dict = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.2f };
    if (!label.text.length) return nil;
    return [[NSAttributedString alloc] initWithString:label.text attributes:dict];
}

@end
