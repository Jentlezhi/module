//
//  FFMainViewDelegate.h
//  FFMainTableView
//
//  Created by xujunquan on 16/11/22.
//  Copyright © 2016年 org_name. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
@class FFMainView;

@protocol FFMainViewDelegate <NSObject>
@optional
///刷新
- (void)mainViewWillRefresh:(FFMainView *)mainView;
///加载更多
- (void)mainViewWillLoadMore:(FFMainView *)mainView;
///reload,一般使用刷新即可，但是有的页面没有刷新但是有reload需求，此时使用该代理
- (void)mainViewWillReload:(FFMainView *)mainView;

///自定义header
- (MJRefreshHeader *)mainViewMJHeaderWithTarget:(id)target refreshingAction:(SEL)action;
///自定义footer
- (MJRefreshFooter *)mainViewMJFooterWithTarget:(id)target loadMoreAction:(SEL)action;

@end
