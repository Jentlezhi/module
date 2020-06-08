//
//  FFTableTemplateView.m
//  FoundationFramework
//
//  Created by xujunquan on 16/3/1.
//  Copyright © 2016年 FollowDreams. All rights reserved.
//

#import "FFMainView.h"

@interface FFMainView ()
///是否使用下拉动画
@property (nonatomic, assign) BOOL pullWithAnimation;
///headerView
@property (nonatomic, strong) UIView *headerView;
///footerView
@property (nonatomic, strong) UIView *footerView;

@end

@implementation FFMainView

- (void)ff_bindViewModel {
    @weakify(self);
    [self.dznCustomViewModel.requestAgainSubject subscribeNext:^(id x) {
        @strongify(self);
        //request
        if (self.mjrefreshSupport == MJRefreshSupportNone || self.mjrefreshSupport == MJRefreshSupportLoadMore) {
            //没有下拉刷新
            self.dznCustomViewModel.shouldDisplay = YES;
            self.dznCustomView.type = DZNViewTypeLoading;
            [self reloadMethod];
        }else {
            //有下拉刷新
            [self autoRefreshWithInterval:0 andPullRefresh:self.pullWithAnimation];
        }
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    _configVM = viewModel;
}

- (void)ff_addSubViewAndConstraints {
    UITableViewStyle style = (self.configVM)?self.configVM.style:UITableViewStylePlain;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.backgroundColor = [UIColor whiteColor];
    self.mjrefreshSupport = MJRefreshSupportAll;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark- get
- (FFDZNCustomView *)dznCustomView {
    if (!_dznCustomView) {
        _dznCustomView = [[FFDZNCustomView alloc] initWithViewModel:self.dznCustomViewModel];
        _dznCustomView.type = DZNViewTypeEmpty;
    }
    return _dznCustomView;
}

- (FFDZNCustomViewModel *)dznCustomViewModel {
    if (!_dznCustomViewModel) {
        _dznCustomViewModel = [[FFDZNCustomViewModel alloc] init];
    }
    return _dznCustomViewModel;
}

- (FFMainViewConfigViewModel *)configVM {
    if (!_configVM) {
        _configVM = [FFMainViewConfigViewModel new];
    }
    return _configVM;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [UIView new];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [UIView new];
    }
    return _footerView;
}

#pragma mark- set
- (void)setDelegate:(id<FFMainViewDelegate,UITableViewDelegate,UITableViewDataSource>)delegate {
    _delegate = delegate;
    self.tableView.delegate = delegate;
    self.tableView.dataSource = delegate;
}

- (void)setMjrefreshSupport:(MJRefreshSupport)mjrefreshSupport {
    _mjrefreshSupport = mjrefreshSupport;
    switch (mjrefreshSupport) {
        case MJRefreshSupportNone:
        {
            self.tableView.mj_header = nil;
            self.tableView.mj_footer = nil;
        }
            break;
        case MJRefreshSupportRefresh:
        {
            [self offerRefreshwithTable:self.tableView andSelector:@selector(refreshMethod)];
            self.tableView.mj_footer = nil;
        }
            break;
        case MJRefreshSupportLoadMore:
        {
            [self offerLoadMorewithTable:self.tableView andSelector:@selector(loadMoreMethod)];
            self.tableView.mj_header = nil;
            self.tableView.mj_footer.hidden = YES;
        }
            break;
        case MJRefreshSupportAll:
        {
            [self offerRefreshwithTable:self.tableView andSelector:@selector(refreshMethod)];
            [self offerLoadMorewithTable:self.tableView andSelector:@selector(loadMoreMethod)];
            self.tableView.mj_footer.hidden = YES;
        }
            break;
        default:
            break;
    }
}

#pragma mark - DZNEmptyDataSetDelegate & DZNEmptyDataSetSource
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.dznCustomView;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return self.dznCustomViewModel.shouldDisplay;
}

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.dznCustomViewModel.dznOffsetY;
}

#pragma mark- refresh/loadMore
- (void)offerRefreshwithTable:(UIScrollView *)table andSelector:(SEL)selMethodName{
    if ([self.delegate respondsToSelector:@selector(mainViewMJHeaderWithTarget:refreshingAction:)]) {
        table.mj_header = [self.delegate mainViewMJHeaderWithTarget:self refreshingAction:selMethodName];
    }else{
        table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:selMethodName];
    }
}

- (void)offerLoadMorewithTable:(UIScrollView *)table andSelector:(SEL)selMethodName{
    if ([self.delegate respondsToSelector:@selector(mainViewMJFooterWithTarget:loadMoreAction:)]) {
        table.mj_footer = [self.delegate mainViewMJFooterWithTarget:self loadMoreAction:selMethodName];
    }else{
        table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:selMethodName];
    }
}

- (void)refreshMethod{
    if (_delegate && [_delegate respondsToSelector:@selector(mainViewWillRefresh:)]) {
        [_delegate mainViewWillRefresh:self];
    }
}

- (void)loadMoreMethod{
    if (_delegate && [_delegate respondsToSelector:@selector(mainViewWillLoadMore:)]) {
        [_delegate mainViewWillLoadMore:self];
    }
}

- (void)reloadMethod {
    if (_delegate && [_delegate respondsToSelector:@selector(mainViewWillReload:)]) {
        [_delegate mainViewWillReload:self];
    }
}

#pragma mark- otherMethod
- (void)registerCellWithIdentifier:(NSArray *)identifierArray {
    for (NSString *identifier in identifierArray) {
        [self.tableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }
}

#pragma mark- animation
- (void)autoRefreshWithInterval:(NSTimeInterval)interval andPullRefresh:(BOOL)pull{
    self.pullWithAnimation = pull;
    
    self.tableView.mj_footer.hidden = YES;
    if (pull) {
        //下拉刷新
        self.tableView.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((interval) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableView.userInteractionEnabled = YES;
            if (self.tableView.mj_header.isRefreshing || self.tableView.mj_footer.isRefreshing) {
                return;
            }
            [self.tableView.mj_header beginRefreshing];
        });
        
    }else{
        if (self.tableView.mj_header.isRefreshing || self.tableView.mj_footer.isRefreshing) {
            return;
        }
        self.dznCustomViewModel.shouldDisplay = YES;
        self.dznCustomView.type = DZNViewTypeLoading;
        [self refreshMethod];
    }
}

- (void)autoReloadWithInterval:(NSTimeInterval)Interval andMainViewModelBlock:(FFMainViewModel* (^) (void)) modelBlock {
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((Interval) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        //从闭包中获取数据并刷新table
        FFMainViewModel *model = modelBlock();
        BOOL hasMore = model.dataHasMore;
        BOOL empty = model.dataEmpty;
        self.dznCustomView.type = (model.netEffective)?DZNViewTypeEmpty:DZNViewTypeReload;
        self.dznCustomViewModel.shouldDisplay = YES;
        //解决dzn控件bug
        if (empty) {
            self.tableView.contentSize = self.tableView.bounds.size;
        }
        [self.tableView reloadData];

        //处理table的mj控件显示情况
        if (self.tableView.mj_header) {
            [self.tableView.mj_header endRefreshing];
        }

        UIEdgeInsets contentInset = self.tableView.contentInset;
        if (empty) {
            //如果是空数据，则隐藏footer
            contentInset.bottom = 0;
            self.tableView.mj_footer.hidden = YES;
        }else{
            if (hasMore) {
                [self.tableView.mj_footer endRefreshing];
                contentInset.bottom = 44;
                self.tableView.mj_footer.hidden = NO;
            }else{
                contentInset.bottom = 0;
                self.tableView.mj_footer.hidden = YES;
            }
        }
        self.tableView.contentInset = contentInset;
    });
}

@end
