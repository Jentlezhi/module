//
//  CYTMyYicheCoinViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyYicheCoinViewController.h"
#import "CYTYiCheCoinHeaderView.h"
#import "MyYicheCoinConfig.h"
#import "CYTCoinHeaderView.h"
#import "CYTCoinSectionModel.h"
#import "CYTExchangeCell.h"
#import "CYTGoodsModel.h"
#import "CYTCoinTaskCell.h"
#import "CYTTaskModel.h"
#import "CYTComonRewardCell.h"
#import "CYTYiCheCoinViewModel.h"
#import "CYTCoinCardView.h"
#import "CYTProfitLossDetailsViewController.h"
#import "CYTGetCoinModel.h"
#import "CYTTaskModel.h"
#import "CYTCarSourcePublishViewController.h"

@interface CYTMyYicheCoinViewController ()<UIScrollViewDelegate>
/** headerView */
@property(strong, nonatomic) CYTYiCheCoinHeaderView *headerView;
/** viewModel */
@property(strong, nonatomic) CYTYiCheCoinViewModel *viewModel;
/** 偏移量 */
@property(assign, nonatomic) CGFloat contentOffsetY;
/** 实时偏移量 */
@property(assign, nonatomic) CGFloat tempContentOffsetY;

@end

@implementation CYTMyYicheCoinViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestDataWithReloadData:YES];
    self.statusBarStyle = CYTStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self myYicheCoinBasicConfig];
    [self initMyYicheCoinComponents];
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.contentOffsetY = self.tempContentOffsetY;
}
/**
 *  基本配置
 */
- (void)myYicheCoinBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"我的易车币"];
    self.interactivePopGestureEnable = NO;
    UIColor *themColor = [UIColor whiteColor];
    self.navTitleColor = themColor;
    self.backBtnColor = themColor;
    self.navigationBarColor = CYTHexColor(@"#27272F");
}
/**
 *  初始化子控件
 */
- (void)initMyYicheCoinComponents{
    self.basicTableView.backgroundColor = CYTLightGrayColor;
    [self.view addSubview:self.basicTableView];
    self.basicTableView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
    self.headerView.frame = CGRectMake(0, 0, 0, CYTAutoLayoutV(kMyYicheCoinInfoHeight + kMyYicheCoinSignHeight) + CYTItemMarginV);
    self.basicTableView.tableHeaderView = self.headerView;
}

/**
 *  加载数据
 */
- (void)requestDataWithReloadData:(BOOL)reloadData{
    BOOL firstLoad = self.viewModel.finishRequestData == nil;
    if (firstLoad) {
        [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    }else{
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    }
    [self.viewModel requestData];
    CYTWeakSelf
    self.viewModel.finishRequestData = ^(CYTNetworkResponse *signInStateData, CYTNetworkResponse *goodsData, CYTNetworkResponse *tasksData) {
        [CYTLoadingView hideLoadingView];
        BOOL dataRight = signInStateData.resultEffective && signInStateData.resultEffective && signInStateData.resultEffective;
        if (dataRight) {
            [weakSelf dismissNoNetworkView];
        }else{
            [weakSelf showNoNetworkView];
        }
        CYTCoinSignResultModel *signResultModel = [CYTCoinSignResultModel mj_objectWithKeyValues:signInStateData.dataDictionary];
        if (signResultModel) {
            weakSelf.headerView.signResultModel = signResultModel;
        }
        if (!reloadData) return;
        [weakSelf.basicTableView reloadData];
        if (!dataRight) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.basicTableView setContentOffset:CGPointMake(0, weakSelf.contentOffsetY) animated:NO];
        });
    };
}
/**
 *  重新加载
 */
- (void)reloadData{
    [self requestDataWithReloadData:YES];
}
#pragma mark - 懒加载
- (CYTYiCheCoinHeaderView *)headerView{
    if (!_headerView) {
        _headerView = CYTYiCheCoinHeaderView.new;
        CYTWeakSelf
        _headerView.signBtnClick = ^{
            [[weakSelf.viewModel.signInCommand execute:nil] subscribeNext:^(CYTNetworkResponse *responseObject) {
                if (!responseObject.resultEffective){
                    [CYTToast errorToastWithMessage:responseObject.resultMessage];
                    return;
                }
                CYTCoinSignResultModel *signResultModel = [CYTCoinSignResultModel mj_objectWithKeyValues:responseObject.dataDictionary];
                if (!signResultModel)return;
                [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeSignSuccess model:signResultModel];
                weakSelf.headerView.signResultModel = signResultModel;
            }];
        };
        _headerView.profitLossDetails = ^{
            CYTProfitLossDetailsViewController *profitLossDetailsVC = CYTProfitLossDetailsViewController.new;
            [weakSelf.navigationController pushViewController:profitLossDetailsVC animated:YES];
        };

    }
    return _headerView;
}

- (CYTYiCheCoinViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = CYTYiCheCoinViewModel.new;
    }
    return _viewModel;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.sectionModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CYTCoinSectionModel *sectionModel = self.viewModel.sectionModels[section];
    return sectionModel.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCoinSectionModel *sectionModel = self.viewModel.sectionModels[indexPath.section];
    if ([sectionModel.title isEqualToString:@"兑换商品"]) {
        CYTExchangeCell *cell = [CYTExchangeCell celllForTableView:tableView indexPath:indexPath];
        cell.goodsModels = sectionModel.items[indexPath.row];
        CYTWeakSelf
        cell.exchangeCallback = ^(NSString *userBitautoCoin) {
            CYTCoinSignResultModel *signResultModel = weakSelf.headerView.signResultModel;
            signResultModel.amount = userBitautoCoin;
            weakSelf.headerView.signResultModel = signResultModel;
        };
        cell.clickCallback = ^(CYTGoodsModel *goodsModel) {
            if (!goodsModel.goodId.length){
                [CYTToast errorToastWithMessage:@"商品ID异常"];
                return;
            };
            CYTH5WithInteractiveCtr *h5 = CYTH5WithInteractiveCtr.new;
            h5.requestURL = [NSString stringWithFormat:@"%@?goodsId=%@",kURL.mall_goodsDetail,goodsModel.goodId];
            [weakSelf.navigationController pushViewController:h5 animated:YES];
        };
        return cell;
    }

    if ([sectionModel.title isEqualToString:@"新手任务"] || [sectionModel.title isEqualToString:@"活动任务"]) {
        CYTCoinTaskCell *cell = [CYTCoinTaskCell celllForTableView:tableView indexPath:indexPath];
        CYTTaskModel *taskModel = sectionModel.items[indexPath.row];
        cell.taskModel = taskModel;
        CYTWeakSelf
        cell.receiveAward = ^(CYTGetCoinModel *getCoinModel) {
            if (!getCoinModel) return;
            CYTCoinSignResultModel *signResultModel = weakSelf.headerView.signResultModel;
            signResultModel.amount = getCoinModel.amount;
            weakSelf.headerView.signResultModel = signResultModel;
            if (taskModel.taskType == 1) {
                [sectionModel.items removeObject:taskModel];
            }else if(taskModel.taskType == 3){
                [weakSelf requestDataWithReloadData:NO];
            }
            CYTCoinCardView *coinCardView = [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeGetSuccess model:getCoinModel];
            coinCardView.completion = ^{
                [weakSelf.basicTableView reloadDataAtSection:indexPath.section animation:YES];
                if (getCoinModel.isAllFinished && taskModel.taskType == 1) {
                    [weakSelf.viewModel.sectionModels removeObject:sectionModel];
                    [weakSelf.basicTableView reloadData];
                    [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeTaskCompletion model:@"恭喜您完成全部新手任务"];
                }
            };
        };
        return cell;
    }

    if ([sectionModel.title isEqualToString:@"常规奖励"]) {
        CYTComonRewardCell *cell = [CYTComonRewardCell celllForTableView:tableView indexPath:indexPath];
        cell.taskModel = sectionModel.items[indexPath.row];
        return cell;
    }
    UITableViewCell *cell = UITableViewCell.new;
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CYTCoinHeaderView *headerView = CYTCoinHeaderView.new;
    headerView.backgroundColor = UIColor.whiteColor;
    CYTCoinSectionModel *sectionModel = self.viewModel.sectionModels[section];
    headerView.sectionModel = sectionModel;
    CYTWeakSelf
    if ([sectionModel.title isEqualToString:@"兑换商品"]) {
        headerView.clickCallBack = ^{
            CYTH5WithInteractiveCtr *mall = [[CYTH5WithInteractiveCtr alloc] initWithViewModel:NSStringFromUIEdgeInsets(UIEdgeInsetsZero)];
            mall.requestURL = kURL.KURL_mall_goodsList;
            mall.showIndicator = YES;
            [weakSelf.navigationController pushViewController:mall animated:YES];
        };
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(80.f);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = UIView.new;
    footerView.backgroundColor = CYTHexColor(@"#F6F6F6");
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CYTAutoLayoutV(20.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTCoinSectionModel *sectionModel = self.viewModel.sectionModels[indexPath.section];
    if ([sectionModel.title isEqualToString:@"新手任务"] || [sectionModel.title isEqualToString:@"活动任务"]) {
        CYTCoinSectionModel *sectionModel = self.viewModel.sectionModels[indexPath.section];
        CYTTaskModel *taskModel = sectionModel.items[indexPath.row];
        if (taskModel.taskStatus == 1 || taskModel.taskStatus == 6 ){
            [[CYTMessageCenterVM manager] handleMessageURL:taskModel.scheme];
        }
    }
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    self.tempContentOffsetY = offsetY;
    self.basicTableView.backgroundColor = offsetY<=1 ? CYTHexColor(@"#27272F") : CYTLightGrayColor;
}

@end
