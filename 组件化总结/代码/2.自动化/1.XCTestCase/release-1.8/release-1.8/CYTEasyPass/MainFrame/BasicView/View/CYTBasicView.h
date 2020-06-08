//
//  CYTBasicView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTBasicView : UIView
/**
 *  基本配置
 */
- (void)basicConfig;
/**
 *  初始化子控件
 */
- (void)initSubComponents;
/**
 *  布局子控件
 */
- (void)makeSubConstrains;


@end
