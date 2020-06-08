//
//  NSString+Extension.m
//  Budejie
//
//  Created by Jentle on 2016/11/23.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (NSString *)replaceOccurrences:(NSString *)occurrenceString{
    return [self stringByReplacingOccurrencesOfString:occurrenceString withString:@""];
}

- (NSString *)replaceBlank{
    return [self replaceOccurrences:@" "];
}

+ (NSString *)tokenValueOf16 {
    NSString *tokenValue = Token_Value;
    NSInteger currentLength = tokenValue.length;
    if (currentLength == 16) {
        return tokenValue;
    } else if (currentLength > 16) {
        return [tokenValue substringToIndex:16];
    } else {
        for (int i = 0; i < 16 - currentLength; i++) {
            tokenValue = [tokenValue stringByAppendingString:@"0"];
        }
        return tokenValue;
    }
}

- (NSString *)removeZeroLastNumber
{
    //获取字符串的最后一位
    if (self.length < 3) {
        return self;
    }
    
    if ([[self substringFromIndex:(self.length - 3)] isEqualToString:@".00"]) {
        return [self substringToIndex:(self.length -3)];
    }
    
    if ([[self substringFromIndex:(self.length - 1)] isEqualToString:@"0"]) {
        return [self substringToIndex:(self.length -1)];
    }
    
    return self;
}

- (NSString *)separateMomeny
{
    //NSNumber *numberTotlal = [NSNumber numberWithFloat:[self floatValue]];
    //NSString *totlal = [NSString stringWithFormat:@"%@元",[numberTotlal formatNumberDecimal]];
    
    //判定是否有负值
    if([self rangeOfString:@"-"].location !=NSNotFound)//_roaldSearchText
    {
        return [NSString stringWithFormat:@"%@元",self];
    }
    
    NSMutableString *mutString = [[NSMutableString alloc] init];
    
    NSArray *sepArray = [self componentsSeparatedByString:@"."];
    
    /*
     for (id temp in sepArray) {
     if ([temp isKindOfClass:[NSString class]]) {
     NSString *str = (NSString *)temp;
     [mutString appendString:[self hanleNums:str]];
     [mutString appendString:@"."];
     }
     }
     */
    id strFrist = [sepArray firstObject];
    if ([strFrist isKindOfClass:[NSString class]]) {
        NSString *strFristNav = (NSString *)strFrist;
        [mutString appendString:[self hanleNums:strFristNav]];
    }
    
    //判定小数后面的位数是否多于2为
    if (sepArray.count > 1) {
        [mutString appendString:@"."];
        
        NSString *lastString = [sepArray lastObject];
        if (lastString.length > 3) {
            lastString = [NSString stringWithFormat:@"0.%@",lastString];
            lastString = [NSString stringWithFormat:@"%.2f",[lastString floatValue]];
            lastString = [lastString substringFromIndex:2];
            [mutString appendString:lastString];
        }else{
            [mutString appendString:lastString];
        }
        
    }
    return [NSString stringWithFormat:@"%@元",mutString];
    /*
     if (mutString.length > 1 ) {
     return [NSString stringWithFormat:@"%@元",[mutString substringToIndex:(mutString.length -1)]];
     }else{
     return @"";
     }
     */
}

- (NSString *)hanleNums:(NSString *)numbers{
    NSString *str = [numbers substringWithRange:NSMakeRange(numbers.length%3, numbers.length-numbers.length%3)];
    NSString *strs = [numbers substringWithRange:NSMakeRange(0, numbers.length%3)];
    for (int  i =0; i < str.length; i =i+3) {
        NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
    }
    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
    }
    return strs;
}

- (NSString *)displayedNumber{
    if ([self integerValue] >= 100) {
        return @"99+";
    }
    
    return self;
}
+ (NSString *)hostWithUrl:(NSString *)urlString{
    NSString *encodingString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:encodingString].host;
}

@end
