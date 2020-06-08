//
//  CYTMyCarSourceViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyCarSourceViewController.h"
#import "CYTMyOutOfStockCarSourceViewController.h"
#import "CYTCarSourceCell.h"
#import "CYTDetailModel.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarSourcePublishViewController.h"
#import "CYTShareActionView.h"
#import "CYTShareManager.h"
#import "CYTCarSourceParemeters.h"
#import "CYTCarSourceListsModel.h"
#import "CYTSaleCarSourceItemParemeters.h"

@interface CYTMyCarSourceViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 滚动视图 */
@property(strong, nonatomic) UITableView *myCarSourceTableView;

///刷新按钮
@property (nonatomic, strong) UIButton *refreshButton;

/** 车源列表 */
@property(strong, nonatomic) NSMutableArray *carSourceList;

/** 末尾ID 首次0 */
@property(copy, nonatomic) NSString *lastId;

@property (nonatomic, strong) CYTShareActionView *shareActionView;

@end

@implementation CYTMyCarSourceViewController

- (NSMutableArray *)carSourceList{
    if (!_carSourceList) {
        _carSourceList = [NSMutableArray array];
    }
    return _carSourceList;
}

- (UITableView *)myCarSourceTableView{
    if (!_myCarSourceTableView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _myCarSourceTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _myCarSourceTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myCarSourceTableView.estimatedSectionFooterHeight = 0;
            _myCarSourceTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _myCarSourceTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myCarSourceViewwBasicConfig];
    [self configordermyCarSourceTableView];
    [self initMyCarSourceViewComponents];
    [self configRefreshButton];
    [self refreshData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShareView) name:kHideWindowSubviewsKey object:nil];
}

- (void)hideShareView {
    [self.shareActionView dismissWithAnimation:YES];
}

/**
 *  基本配置
 */
- (void)myCarSourceViewwBasicConfig{
    if ([self isKindOfClass:[CYTMyOutOfStockCarSourceViewController class]]) {
        [self createNavBarWithBackButtonAndTitle:@"已下架车源"];
    }else{
        [self createNavBarWithTitle:@"我的车源" andShowBackButton:YES showRightButtonWithTitle:@"已下架"];
    }
    
    self.interactivePopGestureEnable = YES;
    
    //刷新类别（子级页面的通知）
    CYTWeakSelf
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRefreshMyCarSourceKey object:nil] subscribeNext:^(id x) {
        [weakSelf refreshData];
    }];
}
/**
 *  配置表格
 */
- (void)configordermyCarSourceTableView{
    self.myCarSourceTableView.backgroundColor = [UIColor whiteColor];
    self.myCarSourceTableView.delegate = self;
    self.myCarSourceTableView.dataSource = self;
    self.myCarSourceTableView.tableFooterView = [[UIView alloc] init];
    self.myCarSourceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myCarSourceTableView.estimatedRowHeight = CYTAutoLayoutV(290);
    self.myCarSourceTableView.rowHeight = UITableViewAutomaticDimension;
    
    //上拉刷新
    self.myCarSourceTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestmyCardataSourceWithRequestType:CYTRequestTypeRefresh];
    }];
    
    //下拉加载更多
    self.myCarSourceTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestmyCardataSourceWithRequestType:CYTRequestTypeLoadMore];
    }];
    
}
/**
 *  加载数据
 */
- (void)refreshData{
    [self.myCarSourceTableView.mj_header beginRefreshing];
}
/**
 *  初始化子控件
 */
- (void)initMyCarSourceViewComponents{
     [self.view addSubview:self.myCarSourceTableView];
}
/**
 *  配置一键刷新
 */
- (void)configRefreshButton{
    [self.view addSubview:self.refreshButton];
    [self.refreshButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo((-CYTMarginH));
        make.bottom.equalTo(-CYTAutoLayoutV(30));
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
    float offset = (self.hideRefreshButton)?0:(CYTAutoLayoutV(30+80+30));
    self.myCarSourceTableView.contentInset = UIEdgeInsetsMake(0, 0, offset, 0);
}
/**
 *  已下架按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    CYTMyOutOfStockCarSourceViewController *myOutOfStockViewController = [[CYTMyOutOfStockCarSourceViewController alloc] init];
    myOutOfStockViewController.hideRefreshButton = YES;
    [self.navigationController pushViewController:myOutOfStockViewController animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carSourceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
    CYTCarSourceCell *cell = [CYTCarSourceCell carSourceCellForTableView:tableView indexPath:indexPath];
    CYTCarSourceListModel *carSourceListModel = self.carSourceList[indexPath.row];
    cell.carSourceListModel = carSourceListModel;
    if ([self isKindOfClass:[CYTMyOutOfStockCarSourceViewController class]]) {
        //重新发布
        cell.btnTitle = @"重新发布";
        cell.onSale = NO;
        cell.soldOutOrRepublishClickBack = ^{
            [CYTAlertView alertViewWithTitle:@"提示" message:@"确定要重新发布吗？" confirmAction:^{
              [weakSelf saleCarSourceItemWithType:1 carSourceModel:carSourceListModel];
            } cancelAction:nil];
        };
    }else{
        //下架停售
        cell.btnTitle = @"下架";
        cell.onSale = YES;
        cell.soldOutOrRepublishClickBack = ^{
            [CYTAlertView alertViewWithTitle:@"提示" message:@"确定要下架停售吗？" confirmAction:^{
                [weakSelf saleCarSourceItemWithType:0 carSourceModel:carSourceListModel];
            } cancelAction:nil];
        };
        //分享
        @weakify(self);
        [cell setShareBlock:^(CYTCarSourceListModel *model){
            @strongify(self);
            [self shareMethodWithModel:model];
        }];
        //刷新
        [cell setRefreshBlock:^(CYTCarSourceListModel *model){
            @strongify(self);
            [self refreshMethodWithModel:model];
        }];
        //编辑
        [cell setEditBlock:^(CYTCarSourceListModel *model){
            @strongify(self);
            [self editMethodWithModel:model];
        }];
    }

    return cell;
}

- (void)saleCarSourceItemWithType:(NSInteger )type carSourceModel:(CYTCarSourceListModel *)carSourceListModel{
    
    CYTSaleCarSourceItemParemeters *saleCarSourceItemParemeters = [[CYTSaleCarSourceItemParemeters alloc] init];
    saleCarSourceItemParemeters.type = type;
    saleCarSourceItemParemeters.carSourceId = carSourceListModel.carSourceInfo.carSourceId;
    saleCarSourceItemParemeters.salePrice = carSourceListModel.carSourceInfo.salePrice;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.car_source_saleCarSourceItem parameters:saleCarSourceItemParemeters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [CYTToast toastWithType:CYTToastTypeSuccess message:responseObject.resultMessage];
            if (type == 1) {
                //发通知刷新我的车源列表
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMyCarSourceKey object:nil];
            }else{
                [self.myCarSourceTableView.mj_header beginRefreshing];
            }
        }
    }];
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCarSourceListModel *carSourceListModel = self.carSourceList[indexPath.row];
    NSString *carSourceId = carSourceListModel.carSourceInfo.carSourceId;
    CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
    detail.viewModel.carSourceId = carSourceId;
    [self.navigationController pushViewController:detail animated:YES];
}

/**
 * 获取车源数据
 */
- (void)requestmyCardataSourceWithRequestType:(CYTRequestType)requestType{
    if (requestType == CYTRequestTypeRefresh) {
        self.lastId = @"0";
        [self.carSourceList removeAllObjects];
    }
    CYTCarSourceParemeters *carSourceParemeters = [[CYTCarSourceParemeters alloc] init];
    carSourceParemeters.lastId = self.lastId;
    if ([self isKindOfClass:[CYTMyOutOfStockCarSourceViewController class]]) {
        carSourceParemeters.carSourceStatus = 0;
    }else{
        carSourceParemeters.carSourceStatus = 1;
    }
    
    [CYTNetworkManager GET:kURL.car_source_myList parameters:carSourceParemeters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.resultEffective) {
            [self dismissNoNetworkView];
            self.refreshButton.hidden = self.hideRefreshButton;
            [self.view bringSubviewToFront:self.refreshButton];
            if (requestType == CYTRequestTypeRefresh) {
                [self.myCarSourceTableView.mj_header endRefreshing];
            }else{
                [self.myCarSourceTableView.mj_footer endRefreshing];
            }
            CYTCarSourceListsModel *carSourceListsModel = [CYTCarSourceListsModel mj_objectWithKeyValues:responseObject.dataDictionary];
            NSArray *requestData = [CYTCarSourceListModel mj_objectArrayWithKeyValuesArray:carSourceListsModel.list];
            [self.carSourceList addObjectsFromArray:requestData];
            self.carSourceList.count?[self dismissNoDataView]:[self showNoDataView];
            CYTCarSourceListModel *carSourceListModel = [self.carSourceList lastObject];
            self.lastId = [NSString stringWithFormat:@"%ld",carSourceListModel.carSourceInfo.rowId];
            if (!carSourceListsModel.isMore) {
                [self.myCarSourceTableView.mj_footer endRefreshingWithNoMoreData];
                
            }else{
                [self.myCarSourceTableView.mj_footer endRefreshing];
            }
            [self.myCarSourceTableView reloadData];
        }else{
            [self showNoNetworkView];
            self.refreshButton.hidden = YES;
            [self.view bringSubviewToFront:self.myCarSourceTableView];
            [self.myCarSourceTableView.mj_header endRefreshing];
            [self.myCarSourceTableView.mj_footer endRefreshing];
        }
        //更新button
        [self updateRefreshButton];
    }];
    

}
/**
 * 重新加载
 */
- (void)reloadData{
    [self.myCarSourceTableView.mj_header beginRefreshing];
}

#pragma mark- method
- (void)shareMethodWithModel:(CYTCarSourceListModel *)model {
    CYTLog(@"shareMethod");
    CYTShareActionView *share = [CYTShareActionView new];
    share.type = ShareViewType_carInfo;
    [share setClickedBlock:^(NSInteger tag) {
        if (tag == 0) {
            //好友
            [MobClick event:@"FX_WXHY_WDCY"];
        }else {
            //朋友圈
            [MobClick event:@"FX_WXPYQ_WDCY"];
        }
        CYTShareRequestModel *reModel = [CYTShareRequestModel new];
        reModel.plant = tag;
        reModel.type = ShareTypeId_carSource;
        reModel.idCode = [model.carSourceInfo.carSourceId integerValue];
        kAppdelegate.wxShareType = ShareTypeId_carSource;
        kAppdelegate.wxShareBusinessId = reModel.idCode;
        [CYTShareManager shareWithRequestModel:reModel];
    }];
    [share showWithSuperView:self.view];
    self.shareActionView = share;
}

- (void)refreshMethodWithModel:(CYTCarSourceListModel *)model {
    CYTLog(@"refreshMethod");
    NSString *carSourceId;
    NSInteger type;
    if (model) {
        //单个刷新
        carSourceId = model.carSourceInfo.carSourceId;
        type = 0;
    }else {
        //全刷新
        carSourceId = @"0";
        type = 1;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:carSourceId forKey:@"CarSourceId"];
    [parameters setObject:@(type) forKey:@"RefreshType"];
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.car_source_refresh parameters:parameters dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
         [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_CarSourceList object:nil];
        }
    }];
}

- (void)editMethodWithModel:(CYTCarSourceListModel *)model {
    CYTLog(@"editMethod");
    CYTCarSourcePublishViewController *publish = [CYTCarSourcePublishViewController new];
    publish.viewModel.editingState = YES;
    publish.viewModel.editModel = model;
    [self.navigationController pushViewController:publish animated:YES];
}

- (void)updateRefreshButton {
    self.refreshButton.enabled = self.carSourceList.count!=0;
    self.refreshButton.backgroundColor = (self.carSourceList.count==0)?CYTBtnDisableColor:kFFColor_green;
}

#pragma mark- get
- (UIButton *)refreshButton {
    if (!_refreshButton) {
        _refreshButton = [UIButton buttonWithFontPxSize:34 textColor:[UIColor whiteColor] text:@"一键刷新"];
        _refreshButton.hidden = YES;
        [_refreshButton setBackgroundColor:kFFColor_green];
        [_refreshButton radius:2 borderWidth:1 borderColor:[UIColor clearColor]];
        @weakify(self);
        [[_refreshButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self refreshMethodWithModel:nil];
        }];
    }
    return _refreshButton;
}

@end
