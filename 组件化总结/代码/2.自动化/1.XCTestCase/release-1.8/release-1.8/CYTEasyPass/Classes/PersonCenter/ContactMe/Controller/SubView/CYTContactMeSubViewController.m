//
//  CYTContactMeSubViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTContactMeSubViewController.h"
#import "ContactMeConfig.h"
#import "CYTContactMeCell.h"
#import "CYTGetContactedMeListViewModel.h"
#import "CYTDealerHisHomeTableController.h"
#import "CYTGetContactedMeListModel.h"
#import "CYTDealer.h"

@interface CYTContactMeSubViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 子控制器类型 */
@property(assign, nonatomic) CYTContactMeSubViewType contactMeSubViewType;
/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;
/** 数据 */
@property(strong, nonatomic) NSMutableArray *listData;
/** 获取列表数据 */
@property(strong, nonatomic) CYTGetContactedMeListViewModel *getContactedMeListViewModel;

@end

@implementation CYTContactMeSubViewController

+ (instancetype)subViewControllerWithType:(CYTContactMeSubViewType)contactMeSubViewType{
    CYTContactMeSubViewController *contactMeSubVC = [CYTContactMeSubViewController new];
    contactMeSubVC.contactMeSubViewType = contactMeSubViewType;
    return contactMeSubVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contactMeSubViewBasicConfig];
    [self initContactMeSubViewComponents];
    [self configMainTableView];
    [self requestData];
}
/**
 *  基本配置
 */
- (void)contactMeSubViewBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    self.interactivePopGestureEnable = NO;
    [self.navigationZone removeFromSuperview];
}
/**
 *  初始化子控件
 */
- (void)initContactMeSubViewComponents{
    [self.view addSubview:self.mainView];
}

/**
 *  配置
 */
- (void)configMainTableView{
    //上拉刷新
    self.mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestmyCarSourceDataWithRequestType:CYTRequestTypeRefresh];
    }];
    
    //下拉加载更多
    self.mainView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestmyCarSourceDataWithRequestType:CYTRequestTypeLoadMore];
    }];
}

#pragma mark - 懒加载

- (NSMutableArray *)listData{
    if (!_listData) {
        _listData = [NSMutableArray array];
    }
    return _listData;
}

- (UITableView *)mainView{
    if (!_mainView) {
        _mainView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainView.estimatedSectionFooterHeight = 0;
            _mainView.estimatedSectionHeaderHeight = 0;
        }
        _mainView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - CYTAutoLayoutV(kContactMeTagViewHeight) - CYTViewOriginY);
        _mainView.backgroundColor = CYTLightGrayColor;
        _mainView.delegate = self;
        _mainView.dataSource = self;
        _mainView.tableFooterView = [[UIView alloc] init];
        _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainView.estimatedRowHeight = CYTAutoLayoutV(100);
        _mainView.rowHeight = UITableViewAutomaticDimension;
        _mainView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(20.f), 0);
    }
    return _mainView;
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTContactMeCell *cell = [CYTContactMeCell celllForTableView:tableView indexPath:indexPath];
    cell.getContactedMeListModel = self.listData[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
        if (state == AccountStateAuthenticationed) {
           CYTGetContactedMeListModel *getContactedMeListModel = self.listData[indexPath.row];
            CYTDealerHisHomeTableController *hisHome = [CYTDealerHisHomeTableController new];
            hisHome.viewModel.userId = [NSString stringWithFormat:@"%ld",getContactedMeListModel.dealer.userId];
            [self.navigationController pushViewController:hisHome animated:YES];
        }
    }];
}
#pragma mark - 懒加载

- (CYTGetContactedMeListViewModel *)getContactedMeListViewModel{
    if (!_getContactedMeListViewModel) {
        _getContactedMeListViewModel = [CYTGetContactedMeListViewModel new];
    }
    return _getContactedMeListViewModel;
}
/**
 *  请求数据
 */
- (void)requestData{
    [self.mainView.mj_header beginRefreshing];
}

- (void)reloadData{
    [self requestData];
}

/**
 * 获取车源数据
 */
- (void)requestmyCarSourceDataWithRequestType:(CYTRequestType)requestType{
    [self.listData removeAllObjects];
    self.getContactedMeListViewModel.getContactedMeListPar.type = self.contactMeSubViewType;
    self.getContactedMeListViewModel.requestType = requestType;
    [[self.getContactedMeListViewModel.getContactedMeListCommand execute:nil] subscribeNext:^(CYTRootResponseModel *responseModel) {
        responseModel.showNoDataView?[self showNoDataView]:[self dismissNoDataView];
        responseModel.showNoNetworkView?[self showNoNetworkView]:[self dismissNoNetworkView];
        [self.mainView.mj_header endRefreshing];
        responseModel.isMore?[self.mainView.mj_footer endRefreshing]:[self.mainView.mj_footer endRefreshingWithNoMoreData];
        [self.listData addObjectsFromArray:responseModel.arrayData];
        [self.mainView reloadData];
    }];
}

@end
