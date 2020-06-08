//
//  TTTAttributedLabel+Extension.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface TTTAttributedLabel (Extension)
/**
 *  富文本
 *
 *  @param content    内容
 *  @param keyWord    关键字
 *  @param aSize      关键字字体大小
 *  @param aColor     关键字颜色
 *  @param urlStr     可点内容
 *  @param delegate   代理
 *
 *  @return 富文本
 */
+ (TTTAttributedLabel *)attributeWithContent:(NSString *)content keyWord:(NSString *)keyWord keyWordFontSize:(CGFloat)aSize keyWordColor:(UIColor *)aColor linkUrlStr:(NSString *)urlStr andDelegate:(id)delegate;

@end
