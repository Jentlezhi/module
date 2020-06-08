//
//  CYTMyContactSubViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyContactSubViewController.h"
#import "CYTMyContactSubViewController.h"
#import "ContactMeConfig.h"
#import "CYTCarListInfoCell.h"
#import "CYTGetMyContactListViewModel.h"
#import "CYTGetMyContactListPar.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarDetailViewController.h"
#import "CYTSeekCarListModel.h"

@interface CYTMyContactSubViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 类型 */
@property(assign, nonatomic) CYTMyContactSubViewType myContactSubViewType;
/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;
/** 数据 */
@property(strong, nonatomic) NSMutableArray *listData;
/** 获取数据 */
@property(strong, nonatomic) CYTGetMyContactListViewModel *getMyContactListViewModel;

@end

@implementation CYTMyContactSubViewController

+ (instancetype)subViewControllerWithType:(CYTMyContactSubViewType)myContactSubViewType{
    CYTMyContactSubViewController *myContactSubVC = [CYTMyContactSubViewController new];
    myContactSubVC.myContactSubViewType = myContactSubViewType;
    return myContactSubVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myContactSubViewBasicConfig];
    [self initMyContactSubViewComponents];
    [self configMainTableView];
    [self requestData];
}
/**
 *  基本配置
 */
- (void)myContactSubViewBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    self.interactivePopGestureEnable = NO;
    [self.navigationZone removeFromSuperview];
}
/**
 *  初始化子控件
 */
- (void)initMyContactSubViewComponents{
    [self.view addSubview:self.mainView];
}
/**
 *  配置
 */
- (void)configMainTableView{
    //上拉刷新
    self.mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataWithRequestType:CYTRequestTypeRefresh];
    }];
    
    //下拉加载更多
    self.mainView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestDataWithRequestType:CYTRequestTypeLoadMore];
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

- (CYTGetMyContactListViewModel *)getMyContactListViewModel{
    if (!_getMyContactListViewModel) {
        _getMyContactListViewModel = [CYTGetMyContactListViewModel new];
    }
    return _getMyContactListViewModel;
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCarListInfoType carListInfoType = self.myContactSubViewType == CYTMyContactSubViewTypeSeekCar?CYTCarListInfoTypeSeekCar:CYTCarListInfoTypeCarSource;
    CYTCarListInfoCell *cell = [CYTCarListInfoCell cellWithType:carListInfoType forTableView:tableView indexPath:indexPath hideTopBar:NO];
    if (self.myContactSubViewType == CYTMyContactSubViewTypeSeekCar) {
        CYTSeekCarListModel *seekCarListModel = self.listData[indexPath.row];
        seekCarListModel.myContect = YES;
        cell.seekCarListModel = seekCarListModel;
    }else{
        CYTCarSourceListModel *carSourceListModel = self.listData[indexPath.row];
        carSourceListModel.myContect = YES;
        cell.carSourceListModel = carSourceListModel;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myContactSubViewType == CYTMyContactSubViewTypeCarSource) {
        CYTCarSourceListModel *carSourceListModel = self.listData[indexPath.row];
        CYTCarSourceDetailTableController *detail = CYTCarSourceDetailTableController.new;
        detail.viewModel.carSourceId = carSourceListModel.carSourceInfo.carSourceId;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        CYTSeekCarListModel *seekCarListModel = self.listData[indexPath.row];
        CYTSeekCarDetailViewController *seekCarDetailVC =  CYTSeekCarDetailViewController.new;
        seekCarDetailVC.seekCarId = seekCarListModel.seekCarInfo.seekCarId;
        [self.navigationController pushViewController:seekCarDetailVC animated:YES];
    }
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
- (void)requestDataWithRequestType:(CYTRequestType)requestType{
    [self.listData removeAllObjects];
    self.getMyContactListViewModel.requestType = requestType;
    if (self.myContactSubViewType == CYTMyContactSubViewTypeSeekCar) {
        [[self.getMyContactListViewModel.getMyContactedSeekCarListCommand execute:nil] subscribeNext:^(CYTRootResponseModel *responseModel) {
            [self settingTableViewWithResponseModel:responseModel];
        }];
    }else{
        [[self.getMyContactListViewModel.getMyContactedCarSourceListCommand execute:nil] subscribeNext:^(CYTRootResponseModel *responseModel) {
            [self settingTableViewWithResponseModel:responseModel];
        }];
    }
}

- (void)settingTableViewWithResponseModel:(CYTRootResponseModel *)responseModel{
    responseModel.showNoDataView?[self showNoDataView]:[self dismissNoDataView];
    responseModel.showNoNetworkView?[self showNoNetworkView]:[self dismissNoNetworkView];
    [self.mainView.mj_header endRefreshing];
    responseModel.isMore?[self.mainView.mj_footer endRefreshing]:[self.mainView.mj_footer endRefreshingWithNoMoreData];
    [self.listData addObjectsFromArray:responseModel.arrayData];
    [self.mainView reloadData];
}
@end
