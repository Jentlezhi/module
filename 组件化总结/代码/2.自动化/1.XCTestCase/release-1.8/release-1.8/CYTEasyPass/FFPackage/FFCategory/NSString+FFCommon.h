//
//  FFBasicProject
//
//  Created by xujunquan on 17/6/2.
//  Copyright © 2017年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FFCommon)

/**
 计算字符串尺寸

 @param font 字体大小
 @param maxSize 最大尺寸
 @return 字符串尺寸
 */
- (CGSize)ff_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

@end
