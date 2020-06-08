//
//  FFBasicProject
//
//  Created by xujunquan on 17/6/2.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "NSString+FFCommon.h"

@implementation NSString (FFCommon)

- (CGSize)ff_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;
}

@end
