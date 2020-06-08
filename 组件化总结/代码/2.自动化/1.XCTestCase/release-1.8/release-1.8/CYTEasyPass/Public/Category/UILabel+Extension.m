//
//  UILabel+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UILabel+Extension.h"


@implementation UILabel (Extension)

+ (instancetype)tagLabelWithTextColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor{
    return [self tagLabelWithText:nil textColor:textColor fontPixel:fontPixel cornerRadius:radius backgroundColor:bgColor];
}

+ (instancetype)tagLabelWithText:(NSString *)text textColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor{
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    tagLabel.text = text.length?text:@"";
    tagLabel.textColor = textColor;
    tagLabel.font = CYTFontWithPixel(fontPixel);
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.layer.cornerRadius = CYTAutoLayoutH(radius);
    tagLabel.layer.masksToBounds = YES;
    tagLabel.backgroundColor = bgColor;
    return tagLabel;
}

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width{
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.text = text;
    tagLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    tagLabel.textColor = textColor;
    tagLabel.font = CYTFontWithPixel(fontPixel);
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.layer.cornerRadius = radius;
    tagLabel.layer.borderWidth = width;
    tagLabel.layer.borderColor = textColor.CGColor;
    tagLabel.layer.masksToBounds = YES;
    return tagLabel;
}

+ (instancetype)dividerLineLabel{
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#DBDBDB"];
    return lineLabel;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment fontPixel:(CGFloat)fontPixel setContentPriority:(BOOL)setPriority{
    return [self labelWithText:nil textColor:textColor textAlignment:textAlignment fontPixel:fontPixel setContentPriority:setPriority];
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font setContentPriority:(BOOL)setPriority{
    return [self labelWithText:nil textColor:textColor textAlignment:textAlignment font:font setContentPriority:setPriority];
}

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment fontPixel:(CGFloat)fontPixel setContentPriority:(BOOL)contentPriority{
   return [self labelWithText:text textColor:textColor textAlignment:textAlignment font:CYTFontWithPixel(fontPixel) setContentPriority:contentPriority];
}

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font setContentPriority:(BOOL)contentPriority{
    UILabel *itemLabel = [[UILabel alloc] init];
//    if (iPhone5_s) {
//        itemLabel.adjustsFontSizeToFitWidth = YES;
//    }
    itemLabel.backgroundColor = [UIColor clearColor];
    itemLabel.textColor = textColor;
    itemLabel.textAlignment = textAlignment;
    itemLabel.font = font;
    itemLabel.text = text?text:@"";
    if (contentPriority) {
        [itemLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [itemLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return itemLabel;
}

@end
