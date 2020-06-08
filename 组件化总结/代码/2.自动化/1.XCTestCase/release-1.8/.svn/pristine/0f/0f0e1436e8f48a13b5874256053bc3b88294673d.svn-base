//
//  CYTBasicTableViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@interface CYTBasicTableViewController : CYTBasicViewController

/** 表格 */
@property(strong, nonatomic) UITableView *mainTableView;
/** 数据源 */
@property(strong, nonatomic) NSMutableArray *dataSource;

/** 显示测试数据 */
@property(assign, nonatomic,getter=isShowTestData) BOOL showTestData;

/** 允许下拉刷新 */
@property(assign, nonatomic,getter=isHeaderRefreshEnable) BOOL headerRefreshEnable;

/** 允许上拉加载更多 */
@property(assign, nonatomic,getter=isFooterRefreshEnable) BOOL footerRefreshEnable;

/** 下拉刷新回调 */
@property(copy, nonatomic) void(^headerRefreshBlock)();

/** 上拉加载更多回调 */
@property(copy, nonatomic) void(^footerRefreshBlock)();

/** 当前页面已选择item */
@property(strong, nonatomic) NSIndexPath *itemSelectedIndexPath;



@end
