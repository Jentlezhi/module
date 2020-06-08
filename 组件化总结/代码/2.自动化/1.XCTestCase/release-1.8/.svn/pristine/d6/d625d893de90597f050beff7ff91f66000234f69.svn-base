//
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 //设置排他性
 [[UIButton appearance] setExclusiveTouch:YES];
 */
#import <UIKit/UIKit.h>

@interface UIButton (FFCommon)

#pragma mark- 增加exState状态参数
///增加通用状态属性exState,默认为0
@property (nonatomic, assign) NSInteger exState;

#pragma mark- 扩大点击事件范围

/**
 扩大点击事件范围

 @param value 上下左右扩大范围
 */
- (void)enlargeWithValue:(CGFloat)value;

/**
 扩大点击事件范围

 @param top top
 @param left left
 @param bottom bottom
 @param right right
 */
- (void)enlargeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

#pragma mark- 快速创建button

/**
 快速创建button

 @param pxSize 字体大小
 @param color 颜色
 @param text 文字
 @return button
 */
+ (UIButton *)buttonWithFontPxSize:(float)pxSize textColor:(UIColor *)color text:(NSString *)text;


@end
