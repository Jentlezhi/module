//
//  NSString+Extension.h
//  Budejie
//
//  Created by Jentle on 2016/11/23.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  字符串尺寸计算
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//加密用，token前16位
+ (NSString *)tokenValueOf16;
/**
 *  去除指定的字符
 */
- (NSString *)replaceOccurrences:(NSString *)occurrenceString;
/**
 *  去除空格
 */
- (NSString *)replaceBlank;

///数据的处理 二位小数 如果是 0 就删除
- (NSString *)removeZeroLastNumber;

///钱数用,隔开separate
- (NSString *)separateMomeny;

///显示数字 超过100 就显示 99+
- (NSString *)displayedNumber;
/**
 *  获取url中host
 */
+ (NSString *)hostWithUrl:(NSString *)urlString;

@end
