//
//  CYTOnSaleCarSourceViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOnSaleCarSourceViewController.h"
#import "CYTMyListDataModel.h"
#import "CYTOtherListDataModel.h"
#import "CYTCarSourceListModel.h"
#import "CYTCarSourceInfo.h"
#import "CYTCarListInfoCell.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTOtherListParameters.h"

@interface CYTOnSaleCarSourceViewController ()
/** 其他人在售车源请求参数 */
@property(strong, nonatomic) CYTOtherListParameters *otherListParameters;

@end

@implementation CYTOnSaleCarSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self onSaleCarSourceBasicConfig];
    [self configOnSaleCarSourceTableView];
    [self initOnSaleCarSourceComponents];
    [self refreshData];
}

/**
 *  基本配置
 */
- (void)onSaleCarSourceBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"在售车源"];
    self.noDataViewText = @"- 暂无更多车源 -";
}
/**
 *  配置表格
 */
- (void)configOnSaleCarSourceTableView{
    //上拉刷新
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestMylistDataWithRequestType:CYTRequestTypeRefresh];
    }];
    
    //下拉加载更多
    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestMylistDataWithRequestType:CYTRequestTypeLoadMore];
    }];
}
/**
 *  初始化子控件
 */
- (void)initOnSaleCarSourceComponents{
    
}

#pragma mark - 懒加载

- (CYTOtherListParameters *)otherListParameters{
    if (!_otherListParameters) {
        _otherListParameters = [[CYTOtherListParameters alloc] init];
        _otherListParameters.userId = self.userId;
    }
    return _otherListParameters;
}
/**
 * 获取数据
 */
- (void)requestMylistDataWithRequestType:(CYTRequestType)requestType{
    if (requestType == CYTRequestTypeRefresh) {
        self.otherListParameters.lastId = -1;
        [self.dataSource removeAllObjects];
    }
    
    [CYTNetworkManager GET:kURL.car_source_hisList parameters:self.otherListParameters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.errorCode>=400) {
            [self showNoNetworkView];
            [self.mainTableView.mj_header endRefreshing];
            [self.mainTableView.mj_footer endRefreshing];
        }else {
            [self dismissNoNetworkView];
            if (requestType == CYTRequestTypeRefresh) {
                [self.mainTableView.mj_header endRefreshing];
            }else{
                [self.mainTableView.mj_footer endRefreshing];
            }
            CYTOtherListDataModel *otherListDataModel = [CYTOtherListDataModel mj_objectWithKeyValues:responseObject.dataDictionary];
            if (!otherListDataModel.isMore) {
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                
            }else{
                [self.mainTableView.mj_footer endRefreshing];
            }
            NSArray *requestData = [CYTCarSourceListModel mj_objectArrayWithKeyValuesArray:otherListDataModel.list];
            CYTCarSourceListModel *lastListModel = [requestData lastObject];
            CYTCarSourceInfo *carSourceInfo = [CYTCarSourceInfo mj_objectWithKeyValues:lastListModel.carSourceInfo];
            self.otherListParameters.lastId = carSourceInfo.rowId;
            [self.dataSource addObjectsFromArray:requestData];
            self.dataSource.count ? [self dismissNoDataView]:[self showNoDataView];
            [self.mainTableView reloadData];
        }
    }];

}

/**
 *  加载数据
 */
- (void)refreshData{
    [self.mainTableView.mj_header beginRefreshing];
}

- (void)reloadData{
    [self.mainTableView.mj_header beginRefreshing];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCarListInfoCell *cell = [CYTCarListInfoCell cellWithType:CYTCarListInfoTypeCarSource forTableView:tableView indexPath:indexPath hideTopBar:NO];
    CYTCarSourceListModel *carSourceListModel = self.dataSource[indexPath.row];
    cell.carSourceListModel = carSourceListModel;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCarSourceListModel *model = self.dataSource[indexPath.row];
    CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
    detail.viewModel.carSourceId = model.carSourceInfo.carSourceId;
    detail.viewModel.fromHisCarSource = (self.userId != [CYTUserId integerValue]);
    [self.navigationController pushViewController:detail animated:YES];
}


@end
