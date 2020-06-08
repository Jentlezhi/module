//
//  UIViewController+FFCommon.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FFCommon)
///当前控制器正在显示
@property (nonatomic, assign, getter = isShowing) BOOL showing;

@end
