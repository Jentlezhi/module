//
//  FFBaseTableViewCell.h
//  FFObjC
//
//  Created by xujunquan on 16/10/19.
//  Copyright © 2016年 org_ian. All rights reserved.
//
/*
 1、布局约束不要修改任何代码
 2、tableView使用时候使用cellForRow、不要使用willDisplayCell方法进行cell赋值
 */

#import <UIKit/UIKit.h>
#import "FFBasicEnum.h"
#import "FFExtendTableViewCellModel.h"

@interface FFBasicTableViewCell : UITableViewCell
//顶部line
@property (nonatomic, strong) UIColor *ffTopLineColor;
@property (nonatomic, assign) BOOL hideTopLine;

@property (nonatomic, assign) float topLeftOffset;
@property (nonatomic, assign) float topRightOffset;
@property (nonatomic, assign) float topHeight;

//底部line
@property (nonatomic, strong) UIColor *ffBottomLineColor;
@property (nonatomic, assign) BOOL hideBottomLine;

@property (nonatomic, assign) float bottomLeftOffset;
@property (nonatomic, assign) float bottomRightOffset;
@property (nonatomic, assign) float bottomHeight;

///contentView
@property (nonatomic, strong) FFExtendView *ffContentView;


/**
 加载子视图

 @param block 设置line高度、颜色等
 */
- (void)ffSubviewsAndConfig:(void(^)(NSArray *subviews,ffDefaultBlock config))block;

///cell自定义样式
@property (nonatomic, strong) FFExtendTableViewCellModel *ffCustomizeCellModel;
///cell数据
@property (nonatomic, strong) id ffModel;

@end
