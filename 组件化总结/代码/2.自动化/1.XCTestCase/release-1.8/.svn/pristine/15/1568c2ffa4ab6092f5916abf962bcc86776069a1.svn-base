//
//  UILabel+FFCommon.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UILabel+FFCommon.h"

@implementation UILabel (FFCommon)
+ (UILabel *)labelWithFontPxSize:(float)pxSize textColor:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.textColor = color?:[UIColor blackColor];
    label.font = [UIFont systemFontOfSize:pxSize/2.0];
    label.text = @"label";
    return label;
}

#pragma mark- 为label设置不同字体颜色
- (void)updateWithRange:(NSRange)range font:(UIFont *)font color:(UIColor *)color {
    NSString *text = (self.text)?self.text:@"";
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:font range:range];
    // 为label添加Attributed
    [self setAttributedText:noteStr];
}

- (void)updateWithString:(NSString *)string space:(float)space range:(NSRange)range font:(UIFont *)font color:(UIColor *)color {
    NSString *text = (string)?string:@"";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//调整行间距
    // 改变行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    // 改变颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 改变字体大小及类型
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    self.attributedText = attributedString;
}
@end
