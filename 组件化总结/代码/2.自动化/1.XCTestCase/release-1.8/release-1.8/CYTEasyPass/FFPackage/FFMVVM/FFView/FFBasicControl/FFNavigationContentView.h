//
//  FFNavigationContentView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "FFNavigationItemView.h"

@interface FFNavigationContentView : FFExtendView
@property (nonatomic, strong) FFNavigationItemView *leftView;
@property (nonatomic, strong) FFNavigationItemView *titleView;
@property (nonatomic, strong) FFNavigationItemView *rightView;

@property (nonatomic, copy) void (^leftClickBlock) (FFNavigationItemView *);
@property (nonatomic, copy) void (^titleClickBlock) (FFNavigationItemView *);
@property (nonatomic, copy) void (^rightClickBlock) (FFNavigationItemView *);

///显示titleView
- (void)showTitleItem:(BOOL)show;
///显示leftView
- (void)showLeftItem:(BOOL)show;
///显示rightView
- (void)showRightItem:(BOOL)show;

///设置宽度约束
- (void)updateView:(FFNavigationItemView *)item width:(float)width;

@end
