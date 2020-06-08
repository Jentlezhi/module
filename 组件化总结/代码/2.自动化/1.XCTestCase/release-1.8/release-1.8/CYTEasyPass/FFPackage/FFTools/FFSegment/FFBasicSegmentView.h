//
//  FFBasicSegmentView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 使用说明
 1、使用默认itemView，可以对item相关参数进行设置，然后设置titlesArray。
 
 2、使用自定义item，自定义item，然后将item的数组返回给 customItemArray
 
 */

#import "FFExtendView.h"
#import "FFBasicSegmentItemView.h"

typedef NS_ENUM(NSInteger,FFBasicSegmentType) {
    ///动态计算
    FFBasicSegmentTypeDynamic,
    ///平分,当前屏幕大小平分。
    FFBasicSegmentTypeAverage,
};

@interface FFBasicSegmentView : FFExtendView

///使用默认itemView
@property (nonatomic, strong) NSArray *titlesArray;
///自定义item
@property (nonatomic, strong) NSArray *customItemArray;

#pragma mark- index
///控件已经显示出来后设置index。
@property (nonatomic, assign) NSInteger index;
///回调
@property (nonatomic, copy) void (^indexChangeBlock) (NSInteger);

#pragma mark- 整体参数设置
///显示底部细线
@property (nonatomic, assign) BOOL showBottomLine;
///左右偏移量
@property (nonatomic, assign) float bottomLineOffset;

///显示底部指示条
@property (nonatomic, assign) BOOL showIndicatorLine;
@property (nonatomic, strong) UIColor *indicatorBgColor;
@property (nonatomic, strong) UIColor *indicatorSelColor;
@property (nonatomic, assign) float lineHeight;
@property (nonatomic, assign) float lineBottomOffset;


#pragma mark- 设置item参数，针对自定义和默认itemView都有效
///宽度计算类型
@property (nonatomic, assign) FFBasicSegmentType type;
///默认为0，不限制
@property (nonatomic, assign) float itemMinWidth;
///设置segmentItem insect
@property (nonatomic, assign) UIEdgeInsets itemContentInsect;
///设置title颜色
@property (nonatomic, strong) UIColor *titleNorColor;
///设置title选中颜色
@property (nonatomic, strong) UIColor *titleSelColor;
///设置气泡是否显示
@property (nonatomic, assign) BOOL showBubble;
///气泡背景色
@property (nonatomic, strong) UIColor *bubbleBgColor;
///气泡数值
- (void)bubbleNumber:(NSString *)bubble withIndex:(NSInteger)index;


///根据index获取item
- (id)itemWithIndex:(NSInteger)index;

@end
