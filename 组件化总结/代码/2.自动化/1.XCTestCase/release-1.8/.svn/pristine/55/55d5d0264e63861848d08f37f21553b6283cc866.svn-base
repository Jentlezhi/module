//
//  FFNavigationView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 1）可定制itemView样式，ok
 2）可重写itemView，ok
 */


#import "FFExtendView.h"
#import "FFNavigationContentView.h"


@interface FFNavigationView : FFExtendView
///背景图片
@property (nonatomic, strong) UIImageView *bgImageView;
///内容视图
@property (nonatomic, strong) FFNavigationContentView *contentView;
///底部线
@property (nonatomic, strong) UIImageView *bottomLineView;

//点击事件
@property (nonatomic, copy) void (^leftClickBlock) (FFNavigationItemView *);
@property (nonatomic, copy) void (^titleClickBlock) (FFNavigationItemView *);
@property (nonatomic, copy) void (^rightClickBlock) (FFNavigationItemView *);


///显示titleView
- (void)showTitleItem:(BOOL)show;
- (void)showTitleItemWithTitle:(NSString *)title;

///显示返回按钮
- (void)showLeftItem:(BOOL)show;
- (void)showLeftItemWithTitle:(NSString *)title;

///显示rightView
- (void)showRightItem:(BOOL)show;
- (void)showRightItemWithTitle:(NSString *)title;


///设置导航底部线的颜色，透明度，偏移值
- (void)setBottomLineColor:(UIColor *)color andOpacity:(float)opacity andOffset:(float)offset;

@end
