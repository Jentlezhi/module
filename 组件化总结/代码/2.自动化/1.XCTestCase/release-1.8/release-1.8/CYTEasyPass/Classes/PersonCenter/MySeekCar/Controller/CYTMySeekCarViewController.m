//
//  CYTMySeekCarViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMySeekCarViewController.h"
#import "CYTMyOutOfStockSeekCarViewController.h"
#import "CYTSeekCarListsModel.h"
#import "CYTSeekCarCell.h"
#import "CYTSeekCarDetailViewController.h"
#import "CYTShareActionView.h"
#import "CYTShareManager.h"
#import "CYTSeekCarNeedPublishViewController.h"
#import "CYTBuyCarSourceItemParemeters.h"
#import "CYTSeekCarParemeters.h"

@interface CYTMySeekCarViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 滚动视图 */
@property(strong, nonatomic) UITableView *mySeekCarTableView;

/** 车源列表 */
@property(strong, nonatomic) NSMutableArray *seekCarList;

/** 末尾ID 首次0 */
@property(assign, nonatomic) NSInteger lastId;

@property (nonatomic, strong) CYTShareActionView *shareActionView;

@end

@implementation CYTMySeekCarViewController

- (NSMutableArray *)seekCarList{
    if (!_seekCarList) {
        _seekCarList = [NSMutableArray array];
    }
    return _seekCarList;
}

- (UITableView *)mySeekCarTableView{
    if (!_mySeekCarTableView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _mySeekCarTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _mySeekCarTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mySeekCarTableView.estimatedSectionFooterHeight = 0;
            _mySeekCarTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _mySeekCarTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mySeekCarBasicConfig];
    [self configorderMySeekCarTableView];
    [self initMySeekCarViewComponents];
    [self refreshData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShareView) name:kHideWindowSubviewsKey object:nil];
}

- (void)hideShareView {
    [self.shareActionView dismissWithAnimation:YES];
}

/**
 *  基本配置
 */
- (void)mySeekCarBasicConfig{
    if ([self isKindOfClass:[CYTMyOutOfStockSeekCarViewController class]]) {
        [self createNavBarWithBackButtonAndTitle:@"已下架寻车"];
    }else{
        [self createNavBarWithTitle:@"我的寻车" andShowBackButton:YES showRightButtonWithTitle:@"已下架"];
    }
    
    self.interactivePopGestureEnable = YES;
    
    //刷新界面
    CYTWeakSelf
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRefreshMySeekCarKey object:nil] subscribeNext:^(id x) {
        [weakSelf refreshData];
    }];
    
}

/**
 *  配置表格
 */
- (void)configorderMySeekCarTableView{
    self.mySeekCarTableView.backgroundColor = [UIColor whiteColor];
    self.mySeekCarTableView.delegate = self;
    self.mySeekCarTableView.dataSource = self;
    self.mySeekCarTableView.tableFooterView = [[UIView alloc] init];
    self.mySeekCarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mySeekCarTableView.estimatedRowHeight = CYTAutoLayoutV(290);
    self.mySeekCarTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mySeekCarTableView];
    
    //上拉刷新
    self.mySeekCarTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestmySeekCarDataWithRequestType:CYTRequestTypeRefresh];
    }];
    
    //下拉加载更多
    self.mySeekCarTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestmySeekCarDataWithRequestType:CYTRequestTypeLoadMore];
    }];
    
}

/**
 *  初始化子控件
 */
- (void)initMySeekCarViewComponents{
    
}
/**
 *  加载数据
 */
- (void)refreshData{
    [self.mySeekCarTableView.mj_header beginRefreshing];
}
/**
 *  已下架按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    CYTMyOutOfStockSeekCarViewController *myOutOfStockSeekCarViewController = [[CYTMyOutOfStockSeekCarViewController alloc] init];
    [self.navigationController pushViewController:myOutOfStockSeekCarViewController animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.seekCarList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarCell *cell = [CYTSeekCarCell seekCarCellForTableView:tableView indexPath:indexPath];
    CYTSeekCarListModel *seekCarListModel = self.seekCarList[indexPath.row];
    cell.seekCarListModel = seekCarListModel;
    CYTWeakSelf
    if ([self isKindOfClass:[CYTMyOutOfStockSeekCarViewController class]]) {
        //重新发布
        cell.btnTitle = @"重新发布";
        cell.onSale = NO;
        cell.soldOutOrRepublishClickBack = ^{
            [CYTAlertView alertViewWithTitle:@"提示" message:@"确认要重新发布吗？" confirmAction:^{
                [weakSelf buyCarSourceItemWithType:1 seekCarModel:seekCarListModel];
            } cancelAction:nil];
        };
        
    }else{
        //下架停售
        cell.btnTitle = @"下架";
        cell.onSale = YES;
        cell.soldOutOrRepublishClickBack = ^{
            [CYTAlertView alertViewWithTitle:@"提示" message:@"确定要下架停售吗？" confirmAction:^{
                [weakSelf buyCarSourceItemWithType:0 seekCarModel:seekCarListModel];
            } cancelAction:nil];
        };
        
        //分享
        @weakify(self);
        [cell setShareBlock:^(CYTSeekCarListModel *model){
            @strongify(self);
            [self shareMethodWithModel:model];
        }];
        //刷新
        [cell setRefreshBlock:^(CYTSeekCarListModel *model){
            @strongify(self);
            [self refreshMethodWithModel:model];
        }];
        //编辑
        [cell setEditBlock:^(CYTSeekCarListModel *model){
            @strongify(self);
            [self editMethodWithModel:model];
        }];
    }
    return cell;
}
#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTSeekCarListModel *seekCarModel = self.seekCarList[indexPath.row];
    CYTSeekCarDetailViewController *detail = [[CYTSeekCarDetailViewController alloc] init];
    detail.seekCarId = seekCarModel.seekCarInfo.seekCarId;
    [self.navigationController pushViewController:detail animated:YES];
}


/**
 * 获取寻车数据
 */
- (void)requestmySeekCarDataWithRequestType:(CYTRequestType)requestType{
    if (requestType == CYTRequestTypeRefresh) {
        self.lastId = 0;
        [self.seekCarList removeAllObjects];
    }
    
    CYTSeekCarParemeters *seekCarParemeters = [[CYTSeekCarParemeters alloc] init];
    seekCarParemeters.lastId = self.lastId;
    seekCarParemeters.seekCarStatus = 1;
    if ([self isKindOfClass:[CYTMyOutOfStockSeekCarViewController class]]) {
        seekCarParemeters.seekCarStatus = 0;
    }else{
        seekCarParemeters.seekCarStatus = 1;
    }
    
    [CYTNetworkManager GET:kURL.car_seek_myList parameters:seekCarParemeters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.errorCode>=400) {
            [self showNoNetworkView];
            [self.mySeekCarTableView.mj_header endRefreshing];
            [self.mySeekCarTableView.mj_footer endRefreshing];
        }else {
            [self dismissNoNetworkView];
            if (requestType == CYTRequestTypeRefresh) {
                [self.mySeekCarTableView.mj_header endRefreshing];
            }else{
                [self.mySeekCarTableView.mj_footer endRefreshing];
            }
            CYTSeekCarListsModel *seekCarListsModel = [CYTSeekCarListsModel mj_objectWithKeyValues:responseObject.dataDictionary];
            [self.seekCarList addObjectsFromArray:seekCarListsModel.list];
            self.seekCarList.count?[self dismissNoDataView]:[self showNoDataView];
            CYTSeekCarListModel *seekCarListModel = [seekCarListsModel.list lastObject];
            self.lastId = seekCarListModel.seekCarInfo.rowId;
            if (!seekCarListsModel.isMore) {
                [self.mySeekCarTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.mySeekCarTableView.mj_footer endRefreshing];
            }
            [self.mySeekCarTableView reloadData];
        }
    }];

}

/**
 * 重新发布/下架
 */
- (void)buyCarSourceItemWithType:(NSInteger)type seekCarModel:(CYTSeekCarListModel *)seekCarModel{
    CYTBuyCarSourceItemParemeters *buyCarSourceItemParemeters = [[CYTBuyCarSourceItemParemeters alloc] init];
    buyCarSourceItemParemeters.type = type;
    buyCarSourceItemParemeters.seekCarId = seekCarModel.seekCarInfo.seekCarId;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.car_seek_pushOnOffLineSeekCar parameters:buyCarSourceItemParemeters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [CYTToast toastWithType:CYTToastTypeSuccess message:responseObject.resultMessage];
            if (type == 1) {
                //发通知刷新我的寻车列表
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMySeekCarKey object:nil];
            }else{
                [self.mySeekCarTableView.mj_header beginRefreshing];
            }

        }
    }];
}
/**
 * 重新加载
 */
- (void)reloadData{
    [self.mySeekCarTableView.mj_header beginRefreshing];
}


#pragma mark- method
- (void)shareMethodWithModel:(CYTSeekCarListModel *)model {
    CYTLog(@"shareMethod");
    CYTShareActionView *share = [CYTShareActionView new];
    share.type = ShareViewType_carInfo;
    
    [share setClickedBlock:^(NSInteger tag) {
        if (tag == 0) {
            //好友
            [MobClick event:@"FX_WXHY_WDXC"];
        }else {
            //朋友圈
            [MobClick event:@"FX_WXPYQ_WDXC"];
        }
        CYTShareRequestModel *reModel = [CYTShareRequestModel new];
        reModel.plant = tag;
        reModel.type = ShareTypeId_seekCar;
        reModel.idCode = model.seekCarInfo.seekCarId.integerValue;
        kAppdelegate.wxShareType = ShareTypeId_seekCar;
        kAppdelegate.wxShareBusinessId = reModel.idCode;
        [CYTShareManager shareWithRequestModel:reModel];
    }];
    [share showWithSuperView:self.view];
    self.shareActionView = share;
}

- (void)refreshMethodWithModel:(CYTSeekCarListModel *)model {
    CYTLog(@"refreshMethod");
    NSString *dataId = model.seekCarInfo.seekCarId;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    @weakify(self);
    
    NSDictionary *parameters = @{@"seekCarId":dataId};
    [CYTNetworkManager POST:kURL.car_seek_refresh parameters:parameters dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        @strongify(self);

        if (responseObject.resultEffective) {
            //刷新成功则刷新列表并发送通知，让寻车列表刷新
            [self reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_FindCarList object:nil];
        }
    }];

}

- (void)editMethodWithModel:(CYTSeekCarListModel *)model {
    CYTSeekCarNeedPublishViewController *seekCarNeedPublishVC = [[CYTSeekCarNeedPublishViewController alloc] init];
    seekCarNeedPublishVC.seekCarNeedPublishType = CYTSeekCarNeedPublishTypeEdit;
    seekCarNeedPublishVC.seekCarModel = model;
    [self.navigationController pushViewController:seekCarNeedPublishVC animated:YES];
}

@end
