//
//  FFTabControl.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 使用方法说明
 1）使用 tabControllersArray，会使用默认的segmentView，并从数组中的控制器中获取title。
 设置tabControllersArray前，可以对segmentView的参数进行设置来定义它的显示。
 
 
 2）使用 segmentView，自定义segment，
 
 
 */

#import "FFExtendViewController.h"
#import "FFBasicSegmentView.h"

@interface FFTabControl : FFExtendViewController
///标签控制器数组
@property (nonatomic, strong) NSArray *tabControllersArray;
///设置默认index
@property (nonatomic, assign) NSInteger defaultIndex;

///segment
@property (nonatomic, strong) FFBasicSegmentView *segmentView;
///segment height
@property (nonatomic, assign) float segmentHeight;
///设置topMargin
@property (nonatomic, assign) float segmentTopMargin;
///设置bottomMargin
@property (nonatomic, assign) float segmentBottomMargin;
///segment 左右偏移量
@property (nonatomic, assign) float segmentLeftRightOffset;

///获取当前index
@property (nonatomic, assign,readonly) NSInteger currentIndex;
///设置index

///index change
- (void)indexChangeWithIndex:(NSInteger)index;
///提供push方法
- (void)pushViewController:(id)controller withAnimate:(BOOL)animate;

@end
