//
//  CYTProfitLossDetailsViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTProfitLossDetailsViewController.h"
#import "CYTProfitLossDetailsCell.h"
#import "CYTCoinCardView.h"
#import "CYTProfitLossDetailsViewModel.h"

@interface CYTProfitLossDetailsViewController ()
/** 说明 */
@property(strong, nonatomic) UIButton *warningBtn;
/** viewModel */
@property(strong, nonatomic) CYTProfitLossDetailsViewModel *viewModel;
@end

@implementation CYTProfitLossDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self profitLossDetailsBasicConfig];
    [self initProfitLossDetailsComponents];
    [self makeContrains];
    [self configDetailTableView];
    [self requestData];
}
/**
 *  基本配置
 */
- (void)profitLossDetailsBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"易车币收支明细"];
    self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTItemMarginV, 0);
}
/**
 *  初始化子控件
 */
- (void)initProfitLossDetailsComponents{
    [self.view addSubview:self.warningBtn];
}
/**
 *  约束
 */
- (void)makeContrains{
    [self.warningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTAutoLayoutH(18.f));
        make.centerY.equalTo(self.navigationBar);
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
    }];
}
/**
 *  配置表格
 */
- (void)configDetailTableView{
    //下拉刷新
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataWithRequestType:CYTRequestTypeRefresh];
    }];
    //上拉加载更多
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestDataWithRequestType:CYTRequestTypeLoadMore];
    }];
    self.mainTableView.mj_footer.hidden = YES;
}
- (void)requestDataWithRequestType:(CYTRequestType)requestType{
    self.viewModel.requestType = requestType;
    [[self.viewModel.getCoinRecordsCommand execute:nil] subscribeNext:^(CYTRootResponseModel *responseModel) {
        [self.mainTableView.mj_header endRefreshing];
        self.mainTableView.mj_footer.hidden = !responseModel.arrayData;
        if (requestType == CYTRequestTypeRefresh && !responseModel.arrayData.count) {
            [self.dataSource removeAllObjects];
        }
        if (responseModel.isMore) {
            [self.mainTableView.mj_footer endRefreshing];
        }else{
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (responseModel.arrayData.count) {
            [self dismissNoNetworkView];
            [self dismissNoDataView];
        }else{
            if (responseModel.networkError) {
                [self showNoNetworkView];
            }else{
                [self showNoDataView];
            }
        }
        self.dataSource = responseModel.arrayData;
        [self.mainTableView reloadData];
    }];
}
#pragma mark - 懒加载
- (UIButton *)warningBtn{
    if(!_warningBtn){
        _warningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_warningBtn setBackgroundImage:[UIImage imageNamed:@"ic_tanhao_hl"] forState:UIControlStateNormal];
        [[_warningBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeExpiredDesc model:nil];
        }];
    }
    return _warningBtn;
}

- (CYTProfitLossDetailsViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = CYTProfitLossDetailsViewModel.new;
    }
    return _viewModel;
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTProfitLossDetailsCell *cell = [CYTProfitLossDetailsCell celllForTableView:tableView indexPath:indexPath];
    CYTCoinRecordModel *coinRecordModel = self.dataSource[indexPath.row];
    coinRecordModel.hideDividerLine = indexPath.row == self.dataSource.count -1;
    cell.coinRecordModel = coinRecordModel;
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = UIView.new;
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTItemMarginV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

#pragma mark - 数据请求
/**
 *  加载数据
 */
- (void)requestData{
   [self.mainTableView.mj_header beginRefreshing];
}
- (void)reloadData{
    [self requestData];
}

@end
