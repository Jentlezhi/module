//
//  CYTMyCouponSubViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyCouponSubViewController.h"
#import "CYTCouponListModel.h"
#import "CYTCouponListItemModel.h"
#import "CYTCouponCardViewCell.h"
#import "CYTCouponTagModel.h"
#import "CYTNoDataView.h"
#import "CYTCouponListParameters.h"

@interface CYTMyCouponSubViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;
/** 数据 */
@property(strong, nonatomic) NSMutableArray *listData;
/** 卡券列表请求参数 */
@property(strong, nonatomic) CYTCouponListParameters *couponListParameters;
/** 卡券视图类型 */
@property(assign, nonatomic) CYTCouponStatusType couponStatusType;
/** 标题tag模型 */
@property(strong, nonatomic) CYTCouponTagModel *couponTagModel;
/** 选择/默认模式 */
@property(assign, nonatomic) CYTMyCouponCardType myCouponCardType;

@end

@implementation CYTMyCouponSubViewController

+ (instancetype)myCouponWithCouponCardType:(CYTCouponStatusType)couponStatusType{
    CYTMyCouponSubViewController *myCouponSubViewController = [[CYTMyCouponSubViewController alloc] initWithType:couponStatusType];
    switch (couponStatusType) {
        case CYTCouponStatusTypeUnused:
        case CYTCouponStatusTypeUsed:
        case CYTCouponStatusTypeExpired:
            myCouponSubViewController.myCouponCardType = CYTMyCouponCardTypeDefault;
            break;
        default:
            myCouponSubViewController.myCouponCardType = CYTMyCouponCardTypeSelect;
            break;
    }
    return myCouponSubViewController;
}

- (instancetype)initWithType:(CYTCouponStatusType)couponStatusType{
    if (self = [super init]) {
        self.couponStatusType = couponStatusType;
    }
    return self;
}
- (CYTCouponListParameters *)couponListParameters{
    if (!_couponListParameters) {
        _couponListParameters = [[CYTCouponListParameters alloc] init];
        if (self.couponStatusType == CYTCouponStatusTypeAvailable || self.couponStatusType == CYTCouponStatusTypeNotAvailable) {
            _couponListParameters.productType = 1;
            _couponListParameters.logicId = self.demandPriceId;
            _couponListParameters.status = self.couponStatusType-3;
        }else{
            _couponListParameters.status = self.couponStatusType;
        }
    }
    return _couponListParameters;
}

- (CYTCouponTagModel *)couponTagModel{
    if (!_couponTagModel) {
        _couponTagModel = [[CYTCouponTagModel alloc] init];
    }
    return _couponTagModel;
}

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
        _mainView.contentInset = UIEdgeInsetsMake(0, 0, CYTItemMarginV, 0);
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myCouponSubViewBasicConfig];
    [self configMyCouponSubTableView];
    [self initMyCouponSubViewComponents];
    [self refreshData];
}

/**
 *  基本配置
 */
- (void)myCouponSubViewBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    self.interactivePopGestureEnable = NO;
}

/**
 *  配置表格
 */
- (void)configMyCouponSubTableView{
    self.mainView.backgroundColor = CYTLightGrayColor;
    self.mainView.delegate = self;
    self.mainView.dataSource = self;
    self.mainView.tableFooterView = [[UIView alloc] init];
    self.mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.mainView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mainView];
    
    //上拉刷新
    self.mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestCouponListDataWithRequestType:CYTRequestTypeRefresh];
    }];
    
    //下拉加载更多
    self.mainView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestCouponListDataWithRequestType:CYTRequestTypeLoadMore];
    }];
}
/**
 *  初始化子控件
 */
- (void)initMyCouponSubViewComponents{
    //添加表格
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - 刷新数据

- (void)refreshData{
    [self.mainView.mj_header beginRefreshing];
}

#pragma mark - 数据请求

- (void)requestCouponListDataWithRequestType:(CYTRequestType)requestType{
    if (requestType == CYTRequestTypeRefresh) {
        self.couponListParameters.lastId = 1;
    }
    
    
    NSString *requestUrl = [NSString string];
    if (self.myCouponCardType == CYTMyCouponCardTypeDefault) {
        requestUrl = kURL.coupon_ExpressCoupon_CouponList;
    }else{
        requestUrl = kURL.coupon_ExpressCoupon_ChooseCouponList;
    }
    
    [CYTNetworkManager POST:requestUrl parameters:self.couponListParameters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.resultEffective) {
            [self dismissNoNetworkView];
            if (requestType == CYTRequestTypeRefresh) {
                [self.mainView.mj_header endRefreshing];
                [self.listData removeAllObjects];
            }
            CYTCouponListModel *couponListModel = [CYTCouponListModel mj_objectWithKeyValues:responseObject.dataDictionary];
            NSArray *tempArray = [CYTCouponListItemModel mj_objectArrayWithKeyValuesArray:couponListModel.list];
            [self.listData addObjectsFromArray:tempArray];
            CYTCouponListItemModel *listItemModel = [self.listData lastObject];
            self.couponListParameters.lastId = listItemModel.index;
            self.listData.count?[self dismissNoNetworkView]:[self showNoDataView];
            if (!couponListModel.isMore) {
                [self.mainView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.mainView.mj_footer endRefreshing];
            }
            [self tagSettingWithCouponListModel:couponListModel];
            [self.mainView reloadData];
        }else{
            [self.mainView.mj_header endRefreshing];
            [self.mainView.mj_footer endRefreshing];
            [self showNoNetworkView];
        }
    }];

}
/**
 *  重新加载数据
 */
- (void)reloadData{
    [self refreshData];
}

- (void)tagSettingWithCouponListModel:(CYTCouponListModel *)couponListModel{
    NSString *unUsedCount = couponListModel.unUsedCount.length?couponListModel.unUsedCount:@"0";
    NSString *usedCount = couponListModel.usedCount.length?couponListModel.usedCount:@"0";
    NSString *expiredCount = couponListModel.expiredCount.length?couponListModel.expiredCount:@"0";
    NSString *usableCount = couponListModel.usableCount.length?couponListModel.usableCount:@"0";
    NSString *disableCount = couponListModel.unableCount.length?couponListModel.unableCount:@"0";
    self.couponTagModel.unusedTag = [NSString stringWithFormat:@"未使用(%@)",unUsedCount];
    self.couponTagModel.usedTag = [NSString stringWithFormat:@"已使用(%@)",usedCount];
    self.couponTagModel.expiredTag = [NSString stringWithFormat:@"已过期(%@)",expiredCount];
    self.couponTagModel.usableTag = [NSString stringWithFormat:@"可用券(%@)",usableCount];
    self.couponTagModel.disableTag = [NSString stringWithFormat:@"不可使用(%@)",disableCount];
    !self.couponTagBlock?:self.couponTagBlock(self.couponTagModel);
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCouponListItemModel *couponListItemModel = self.listData[indexPath.row];
    if ([self.couponListItemModel.couponCode isEqualToString:couponListItemModel.couponCode]) {
        couponListItemModel.selected = YES;
    }else{
        couponListItemModel.selected = NO;
    }
    couponListItemModel.status = self.couponStatusType;
    CYTCouponCardViewCell *cell = [CYTCouponCardViewCell cellForTableView:tableView indexPath:indexPath];
    cell.couponListItemModel = couponListItemModel;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.myCouponCardType == CYTMyCouponCardTypeSelect) {
        CYTCouponListItemModel *couponListItemModel = self.listData[indexPath.row];
        !self.couponSelectBlock?:self.couponSelectBlock(couponListItemModel);
    }
}

@end
