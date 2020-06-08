//
//  UITextField+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

+ (instancetype)textFieldWithTextColor:(UIColor *)textColor fontPixel:(CGFloat)fontPixel textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType clearButtonMode:(UITextFieldViewMode)clearButtonMode placeholder:(NSString *)placeholder{
    return [self textFieldWithTextColor:textColor font:CYTFontWithPixel(fontPixel) textAlignment:textAlignment keyboardType:keyboardType clearButtonMode:clearButtonMode placeholder:placeholder];
}

+ (instancetype)textFieldWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType clearButtonMode:(UITextFieldViewMode)clearButtonMode placeholder:(NSString *)placeholder{
    UITextField *customTF = [[UITextField alloc] init];
    customTF.font = font;
    customTF.textColor =  textColor;
    customTF.keyboardType = keyboardType;
    customTF.textAlignment = textAlignment;
    customTF.placeholder = placeholder;
    customTF.clearButtonMode = clearButtonMode;
    [customTF setValue:CYTHexColor(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
    return customTF;
}

@end
