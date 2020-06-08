//
//  CYTHomeViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeViewController.h"
#import "CYTHomeHeaderView.h"
#import "HomeConfig.h"
#import "CYTBannerInfoModel.h"
#import "CYTFunctionModel.h"
#import "CYTDealerRecommendView.h"
#import "CYTSpecialSaleCell.h"
#import "CYTHomeSearchBarView.h"
#import "CYTHomeSearchBgView.h"
#import "CYTCarSourceSearchTableController.h"
#import "CYTMessageCategoryTableController.h"
#import "CYTHomeSectionHeaderView.h"
#import "CYTHomeDataViewModel.h"
#import "CYTRecommendListModel.h"
#import "CYTCarSourceDetailTableController.h"

@interface CYTHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
/** 搜索条半透明 */
@property(assign, nonatomic,getter=isSearchViewTranslucence) BOOL searchViewTranslucence;
/** 表格 */
@property(strong, nonatomic) UITableView *homeTableView;
/** 头视图 */
@property(strong, nonatomic) CYTHomeHeaderView *homeHeaderView;
/** 搜索预留位 */
@property(strong, nonatomic) CYTHomeSearchBgView *searchBgView;
/** 搜索框 */
@property(strong, nonatomic) CYTHomeSearchBarView *searchView;
/** 数据请求（逻辑） */
@property(strong, nonatomic) CYTHomeDataViewModel *homeDataViewModel;
/** 特卖车源 */
@property(strong, nonatomic) NSMutableArray *carSourceLists;
/** 上拉加载 */
@property(strong, nonatomic) MJRefreshFooter *refreshFooter;

@end

@implementation CYTHomeViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.searchViewTranslucence)return;
    self.statusBarStyle = CYTStatusBarStyleLightContent;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.statusBarStyle = CYTStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self homeViewBasicConfig];
    [self initHomeViewComponents];
    [self configHomeTableView];
    [self addObserverTableViewOffset];
    [self refreshData];
    [self addObserver];
}

/**
 *  基本配置
 */
- (void)homeViewBasicConfig{
    @weakify(self);
    self.doubleClickTabBarBlock = ^{
        @strongify(self);
        [self refreshData];
    };
}
/**
 *  初始化子控件
 */
- (void)initHomeViewComponents{
    [self.view addSubview:self.homeTableView];
    self.homeTableView.tableHeaderView = self.homeHeaderView;
    //添加搜索
    [self.view insertSubview:self.searchBgView aboveSubview:self.homeTableView];
    [self.searchBgView addSubview:self.searchView];
}
/**
 *  配置表格
 */
- (void)configHomeTableView{
    //下拉刷新
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestHomeDataWithRequestType:CYTRequestTypeRefresh];
    }];
    //上拉加载更多
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestHomeDataWithRequestType:CYTRequestTypeLoadMore];
    }];
}

/**
 *  监听滚动位置
 */
- (void)addObserverTableViewOffset{
    [RACObserve(self.homeTableView,contentOffset) subscribeNext:^(id x) {
        CGFloat scrollViewOffectY = self.homeTableView.contentOffset.y;
        if (scrollViewOffectY > 0) {
            [self opaqueSearchViewWithOffset:scrollViewOffectY];
        }else{
            [self lucencySearchViewWithOffset:scrollViewOffectY];
        }
    }];
}

/**
 *  透明效果
 */
- (void)lucencySearchViewWithOffset:(CGFloat)offset{
    CGFloat lucencyRatio = fabs(offset/CYTStatusBarHeight);
    CGFloat alphaComponent = kSearchBgViewDefaultAlpha*(1 - lucencyRatio);
    self.searchBgView.hidden = alphaComponent<=0;
    self.searchBgView.backgroundColor = [kSearchBgColor colorWithAlphaComponent:alphaComponent];
    self.searchView.translucence = YES;
    self.searchBgView.showDividerLine = NO;
    if (![self.view isVisibleOnKeyWindow])return;
    self.statusBarStyle = offset >0 ? : CYTStatusBarStyleLightContent;
}
/**
 *  不透明效果
 */
- (void)opaqueSearchViewWithOffset:(CGFloat)offset{
    self.searchBgView.hidden = NO;
    CGFloat defaultRatio = CYTAutoLayoutV(kBannerViewHeightPixel) - CYTViewOriginY;
    CGFloat alphaComponent = kSearchBgViewDefaultAlpha + (1-kSearchBgViewDefaultAlpha)*offset/defaultRatio;
    alphaComponent = alphaComponent >=1.0 ? 1.0:alphaComponent;
    self.searchBgView.backgroundColor = [kSearchBgColor colorWithAlphaComponent:alphaComponent];
    BOOL alphaComponentReachHalf = alphaComponent>=0.5f;
    self.searchBgView.showDividerLine = alphaComponentReachHalf;
    self.searchView.translucence = !alphaComponentReachHalf;
    if (![self.view isVisibleOnKeyWindow])return;
    self.searchViewTranslucence = alphaComponentReachHalf;
}

/**
 *  监听通知
 */
- (void)addObserver{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kloginSucceedKey object:nil] subscribeNext:^(id x) {
        [self refreshData];
    }];
}

#pragma mark - 属性设置

- (void)setSearchViewTranslucence:(BOOL)searchViewTranslucence{
    _searchViewTranslucence = searchViewTranslucence;
    self.statusBarStyle = searchViewTranslucence ? CYTStatusBarStyleDefault : CYTStatusBarStyleLightContent;
}

#pragma mark - 懒加载

- (UITableView *)homeTableView{
    if (!_homeTableView) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - CYTTabBarHeight);
        _homeTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _homeTableView.backgroundColor = CYTLightGrayColor;
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.tableFooterView = [[UIView alloc] init];
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.estimatedRowHeight = CYTAutoLayoutV(100);
        _homeTableView.rowHeight = UITableViewAutomaticDimension;
        if ([_homeTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
    return _homeTableView;
}

- (CYTHomeHeaderView *)homeHeaderView{
    if (!_homeHeaderView) {
        _homeHeaderView = [[CYTHomeHeaderView alloc] init];
        _homeHeaderView.backgroundColor = CYTLightGrayColor;
        _homeHeaderView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(kBannerViewHeightPixel + kToolViewHeightPixel + kDealerRecommendViewHeightPixel + kAdsInfoViewHeightPixel) + 3*CYTItemMarginV);
        @weakify(self);
        _homeHeaderView.bannerImageClick = ^(NSString *url) {
            @strongify(self);
            [self bannerDetailWithUrl:url];
        };
        _homeHeaderView.functionItemClick = ^(CYTFunctionModel *functionModel) {
            @strongify(self);
            [self functionWithFunctionModel:functionModel];
        };
        _homeHeaderView.recommendClick = ^(CYTRecommendListModel *recommendListModel) {
            [[CYTMessageCenterVM manager] handleMessageURL:recommendListModel.protocol];
        };
    }
    return _homeHeaderView;
}
- (CYTHomeSearchBgView *)searchBgView{
    if (!_searchBgView) {
        _searchBgView = [[CYTHomeSearchBgView alloc] init];
        _searchBgView.backgroundColor = [kSearchBgColor colorWithAlphaComponent:kSearchBgViewDefaultAlpha];
        CGFloat searchBgViewX = 0;
        CGFloat searchBgViewY = 0;
        CGFloat searchBgViewW = kScreenWidth - 2*searchBgViewX;
        CGFloat searchBgViewH = CYTViewOriginY;
        _searchBgView.frame = CGRectMake(searchBgViewX, searchBgViewY, searchBgViewW, searchBgViewH);
    }
    return _searchBgView;
}

- (CYTHomeSearchBarView *)searchView {
    if (!_searchView) {
        _searchView = [CYTHomeSearchBarView new];
        CGFloat searchViewW = kScreenWidth - 2*CYTItemMarginH;
        CGFloat searchViewH = 30.f;
        CGFloat searchViewX = CYTItemMarginH;
        CGFloat searchViewY = (CYTNavigationBarHeight - searchViewH)*0.5f + CYTStatusBarHeight;
        _searchView.frame =  CGRectMake(searchViewX, searchViewY, searchViewW, searchViewH);
        @weakify(self);
        [_searchView setSearchBlock:^{
            @strongify(self);
            [self search];
        }];
        [_searchView setMessageBlock:^{
            @strongify(self);
            [self message];
        }];
    }
    return _searchView;
}

- (CYTHomeDataViewModel *)homeDataViewModel{
    if (!_homeDataViewModel) {
        _homeDataViewModel = [[CYTHomeDataViewModel alloc] init];
        @weakify(self);
        _homeDataViewModel.finishRequestData = ^(CYTRootResponseModel *storeAuthListData, CYTRootResponseModel *recommendListData, CYTRootResponseModel *carSourceListDataData) {
            @strongify(self);
            self.homeHeaderView.storeAuthModels = storeAuthListData.arrayData;
            self.homeHeaderView.recommendLists = recommendListData.arrayData;
            //处理推荐空的清空
            CGFloat homeFullHeight = CYTAutoLayoutV(kBannerViewHeightPixel + kToolViewHeightPixel + kDealerRecommendViewHeightPixel + kAdsInfoViewHeightPixel) + 3*CYTItemMarginV;
            CGFloat homeNoAuthRecommentHeight = homeFullHeight - CYTAutoLayoutV(kAdsInfoViewHeightPixel) - 2*CYTItemMarginV;
            CGFloat homeHeight = recommendListData.arrayData.count ? homeFullHeight:homeNoAuthRecommentHeight;
            [UIView animateWithDuration:kAnimationDurationInterval animations:^{
                self.homeHeaderView.frame = CGRectMake(0, 0, kScreenWidth, homeHeight);
            }];
            if (carSourceListDataData.arrayData.count) {
                self.homeTableView.mj_footer = self.refreshFooter;
            }else{
                self.homeTableView.mj_footer = nil;
            }
            if (storeAuthListData.arrayData.count && recommendListData.arrayData.count && carSourceListDataData.arrayData.count) {
                if (storeAuthListData.networkError || recommendListData.networkError || carSourceListDataData.networkError ) {
                    [CYTToast errorToastWithMessage:CYTNetworkError];
                }
            }else{
                if (storeAuthListData.networkError || recommendListData.networkError || carSourceListDataData.networkError ) {
                    [self showNoNetworkView];
                }else{
                    [self dismissNoNetworkView];
                }
            }
            [self homeTableViewSettingWithCarSourceLists:carSourceListDataData withType:CYTRequestTypeRefresh];
        };
    }
    return _homeDataViewModel;
}
- (NSMutableArray *)carSourceLists{
    if (!_carSourceLists) {
        _carSourceLists = [NSMutableArray array];
    }
    return _carSourceLists;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carSourceLists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTSpecialSaleCell *cell = [CYTSpecialSaleCell cellForTableView:tableView indexPath:indexPath];
    cell.carSourceInfoModel = self.carSourceLists[indexPath.item];
    return cell;
}
#pragma mark - <UITableViewDelegate>

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CYTHomeSectionHeaderView *headerView = [[CYTHomeSectionHeaderView alloc] init];
    headerView.title = @"特卖专区";
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(80.f);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTHomeCarSourceInfoModel *carSourceInfoModel = self.carSourceLists[indexPath.item];
    CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
    detail.viewModel.carSourceId = carSourceInfoModel.carSourceId;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - 数据请求

/**
 *  加载数据
 */
- (void)refreshData{
    [self.homeTableView.mj_header beginRefreshing];
}

- (void)requestBannerData{
    [[self.homeDataViewModel.getBannerInfoCommand execute:nil] subscribeNext:^(NSArray *bannerInfoModels) {
        if (bannerInfoModels.count) {
            self.homeHeaderView.bannerInfoLists = bannerInfoModels;
        }
    }];
}
- (void)requestMessageUnreadData{
    [[self.homeDataViewModel.getUnreadCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
        if (responseObject.resultEffective) {
            NSString *haveUnread = [responseObject.dataDictionary valueForKey:@"hasUnRead"];
            NSInteger badgeNumber = [[responseObject.dataDictionary valueForKey:@"num"] integerValue];
            [self.searchView showBubbleView:haveUnread.boolValue];
            [CYTMessageCenterVM manager].badgeNumber = badgeNumber;
        }
    }];
}
- (void)requestFunctionButtonsData{
    self.homeHeaderView.functionData = self.homeDataViewModel.functionArray;
}

- (void)requestOthersData{
    [self.homeDataViewModel requestOtherData];
}

- (void)loadMoreCarSourceListData{
    @weakify(self);
    [[self.homeDataViewModel.getRecommendListCommand execute:nil] subscribeNext:^(CYTRootResponseModel *responseModel) {
        @strongify(self);
        [self homeTableViewSettingWithCarSourceLists:responseModel withType:CYTRequestTypeLoadMore];
    }];
}

- (void)requestHomeDataWithRequestType:(CYTRequestType)requestType{
    self.homeDataViewModel.requestType = requestType;
    if (requestType == CYTRequestTypeRefresh) {
        [self requestBannerData];
        [self requestMessageUnreadData];
        [self requestFunctionButtonsData];
        [self requestOthersData];
    }else{
        [self loadMoreCarSourceListData];
    }
}

- (void)homeTableViewSettingWithCarSourceLists:(CYTRootResponseModel *)carSourceListDataData withType:(CYTRequestType)requestType{
    [self.homeTableView.mj_header endRefreshing];
    if (requestType == CYTRequestTypeRefresh && !carSourceListDataData.arrayData.count) {
        [self.carSourceLists removeAllObjects];
    }
    if (carSourceListDataData.isMore) {
        [self.homeTableView.mj_footer endRefreshing];
    }else{
        [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (carSourceListDataData.arrayData.count) {
        [self dismissNoNetworkView];
        [self dismissNoDataView];
    }else{
        if (carSourceListDataData.networkError) {
           [self showNoNetworkView];
        }else{
           [self showNoDataView];
        }
    }
    self.carSourceLists = carSourceListDataData.arrayData;
    [self.homeTableView reloadData];
}

#pragma mark -  无数据、无网络配置
- (void)showNoNetworkView{
    self.noNetworkView.frame = CGRectMake(0, kNoNetworkViewY, kScreenWidth, kScreenHeight - kNoNetworkViewY);
    [self.homeTableView addSubview:self.noNetworkView];
}

- (void)showNoDataView{
    self.noDataView.frame = CGRectMake(0, kNoDateViewY, kScreenWidth, kScreenHeight - kNoDateViewY);
    self.noDataView.homeLayout = YES;
    [self.homeTableView addSubview:self.noDataView];
}

- (void)reloadData{
    [self refreshData];
}

#pragma mark - 其他
- (void)search{
    CYTCarSourceSearchTableController *ctr = [CYTCarSourceSearchTableController new];
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)message{
    if (![CYTAuthManager manager].isLogin) {
        //弹出登录页面
        [[CYTAuthManager manager] goLoginView];
    }else {
        CYTMessageCategoryTableController *category = [CYTMessageCategoryTableController new];
        @weakify(self);
        [category setRefreshBlock:^{
            @strongify(self);
            [self requestMessageUnreadData];
        }];
        [self.navigationController pushViewController:category animated:YES];
    }
}
- (void)bannerDetailWithUrl:(NSString *)url{
    CYTH5WithInteractiveCtr *h5 = [[CYTH5WithInteractiveCtr alloc] init];
    h5.requestURL = url;
    [self.navigationController pushViewController:h5 animated:YES];
}
- (void)functionWithFunctionModel:(CYTFunctionModel *)functionModel{
    //不需要登录
    if (!functionModel.isNeedLogIn) {
        [[CYTMessageCenterVM manager] handleMessageURL:functionModel.protocol];
        return;
    }
    //需要登录
    //是否登录
    BOOL islogin = [CYTAccountManager sharedAccountManager].isLogin;
    //未登录
    if (!islogin) {
        [[CYTAuthManager manager] goLoginView];
        return;
    }
    
    //已登录
    //是否需要认证
    BOOL isNeedAuth = functionModel.isNeedAuth;
    //不需要认证
    if (!isNeedAuth) {
        [[CYTMessageCenterVM manager] handleMessageURL:functionModel.protocol];
        return;
    }
    //需要认证
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditTabBar];
    [[CYTAccountManager sharedAccountManager] updateUserInfoCompletion:^(CYTUserInfoModel *userAuthenticateInfoModel) {
        [CYTLoadingView hideLoadingView];
        if (userAuthenticateInfoModel) {
            BOOL authed = userAuthenticateInfoModel.authStatus == 2;
            if (authed) {
                [[CYTMessageCenterVM manager] handleMessageURL:functionModel.protocol];
            }else{
                [[CYTAuthManager manager] alert_authenticate];
            }
        }else{
            [CYTToast errorToastWithMessage:CYTNetworkError];
        }
    }];
}
@end
