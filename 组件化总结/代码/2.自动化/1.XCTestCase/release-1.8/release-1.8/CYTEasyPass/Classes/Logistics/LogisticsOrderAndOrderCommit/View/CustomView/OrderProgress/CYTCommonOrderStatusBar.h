//
//  CYTCommonOrderStatusBar.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

//订单状态进度条类型
typedef enum : NSUInteger {
    CYTCommonOrderStatusBarTitleUp = 0,      //标题在上
    CYTCommonOrderStatusBarTitleDown,        //标题在下
} CYTCommonOrderStatusBarType;

@interface CYTCommonOrderStatusBar : UIView

/** 隐藏左条 */
@property(assign, nonatomic) BOOL hideLeftBar;
/** 隐藏右条 */
@property(assign, nonatomic) BOOL hideRightBar;
/** 设置为高亮状态 */
@property(assign, nonatomic) BOOL highlighted;
/** 设置左条为高亮状态 */
@property(assign, nonatomic) BOOL highlightedLeftBar;


+ (instancetype)commonOrderStatusBarWithStyle:(CYTCommonOrderStatusBarType)commonOrderStatusBarType title:(NSString *)title highlightColor:(UIColor *)highlightColor;

@end
