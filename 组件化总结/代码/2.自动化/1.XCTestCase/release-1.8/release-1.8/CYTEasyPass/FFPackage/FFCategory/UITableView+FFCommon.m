//
//  UITableView+FFCommon.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UITableView+FFCommon.h"

static char bgColorKey;

@implementation UITableView (FFCommon)

- (void)setFfBgColor:(UIColor *)ffBgColor {
    objc_setAssociatedObject(self, &bgColorKey, ffBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIView *bgView = [UIView new];
    bgView.backgroundColor = ffBgColor;
    self.backgroundView = bgView;
}

- (UIColor *)ffBgColor {
    return nil;
}

@end
