//
//  FFTableTemplateView.h
//  FoundationFramework
//
//  Created by xujunquan on 16/3/1.
//  Copyright © 2016年 FollowDreams. All rights reserved.
//
/*
 实现功能
 1、支持mjrefresh模式
 2、dzn：实现loading、empty、reload页面默认样式、文字图片控件间隔设置、页面的完全自定义
 3、mjrefresh：实现上拉下拉默认动画、自定义header、footer
 */

#import "FFExtendView.h"
#import "FFDZNCustomView.h"
#import "FFDZNCustomViewModel.h"
#import "FFMainViewModel.h"
#import "FFMainViewDelegate.h"
#import "FFMainViewConfigViewModel.h"

///table的刷新和加载更多
typedef NS_ENUM(NSInteger, MJRefreshSupport) {
    //提供刷新和加载更多功能
    MJRefreshSupportAll,
    //不提供
    MJRefreshSupportNone,
    //提供刷新
    MJRefreshSupportRefresh,
    //提供加载更多
    MJRefreshSupportLoadMore
};

@interface FFMainView : FFExtendView<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
///configVM
@property (nonatomic, strong) FFMainViewConfigViewModel *configVM;

///tableView
@property (nonatomic, strong)UITableView *tableView;
///dznview
@property (nonatomic, strong) FFDZNCustomView *dznCustomView;
///dznVM
@property (nonatomic, strong) FFDZNCustomViewModel *dznCustomViewModel;
///默认是全部
@property (nonatomic, assign)MJRefreshSupport mjrefreshSupport;
///delegate
@property (nonatomic, weak)id <FFMainViewDelegate,UITableViewDelegate,UITableViewDataSource>delegate;

///registerCell
- (void)registerCellWithIdentifier:(NSArray *)identifierArray;

///ns后自动调用下拉刷新方法，在interval期间内table不响应事件,可用于先展示一段时间缓存然后开始请求新数据的情况
- (void)autoRefreshWithInterval:(NSTimeInterval)interval andPullRefresh:(BOOL)pull;
///ns后自动调用方法刷新table
- (void)autoReloadWithInterval:(NSTimeInterval)Interval andMainViewModelBlock:(FFMainViewModel* (^) (void)) modelBlock;


@end
