//
//  TTTAttributedLabel+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "TTTAttributedLabel+Extension.h"

@implementation TTTAttributedLabel (Extension)

+ (TTTAttributedLabel *)attributeWithContent:(NSString *)content keyWord:(NSString *)keyWord keyWordFontSize:(CGFloat)aSize keyWordColor:(UIColor *)aColor linkUrlStr:(NSString *)urlStr andDelegate:(id)delegate{
    TTTAttributedLabel *attributedLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    attributedLabel.delegate = delegate;
    attributedLabel.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    [attributedLabel setText:content afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString){
         NSRange boldRange = [[mutableAttributedString string] rangeOfString:keyWord options:NSCaseInsensitiveSearch];
         UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:aSize];
         CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
         if (font) {
             [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
             [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[aColor CGColor] range:boldRange];
             CFRelease(font);
             
         }
         return mutableAttributedString;
    }];
    NSRange linkRange = [content rangeOfString:keyWord];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [attributedLabel addLinkToURL:url withRange:linkRange];
    return attributedLabel;
}


@end
