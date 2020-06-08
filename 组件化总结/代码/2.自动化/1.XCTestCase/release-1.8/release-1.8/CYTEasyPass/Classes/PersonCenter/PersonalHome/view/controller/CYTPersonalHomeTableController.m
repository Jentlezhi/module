//
//  CYTPersonalHomeTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalHomeTableController.h"
#import "CYTSettingViewController.h"
#import "CYTPersonalHomeCell.h"
#import "CYTUserHeaderCell.h"
#import "CYTPersonalHomeCellHeader.h"
#import "CYTMySeekCarViewController.h"
#import "CYTMyCarSourceViewController.h"
#import "CYTMyAccountCtr.h"
#import "CYTMyCouponViewController.h"
#import "CYTWithdrawPwdSetTableController.h"
#import "CYTGetCashCtr.h"
#import "CYTConnectedCarSourceCtr.h"
#import "CYTDealerMeHomeTableController.h"
#import "CYTCarOrderListViewController.h"
#import "CYTLogisticsNeedList.h"
#import "CYTLogisticsOrderList.h"
#import "CYTContactMeViewController.h"
#import "CYTMyContactViewController.h"
#import "CYTMyYicheCoinViewController.h"

@interface CYTPersonalHomeTableController ()
/** 个人信息模型 */
@property(strong, nonatomic) CYTUserInfoModel *userInfoModel;
///刷新参数
@property (nonatomic, assign) BOOL needRefresh;
///计算高度
@property (nonatomic, strong) CYTUserHeaderCell *headCell;
@property (nonatomic, strong) CYTPersonalHomeCell *itemCell;

@end

@implementation CYTPersonalHomeTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    self.itemCell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTPersonalHomeCell identifier]];
    
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = NO;
            model.dataHasMore = NO;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.needRefresh = YES;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kMeRefreshKey object:nil] subscribeNext:^(id x) {
        self.needRefresh = YES;
    }];
    
    [CYTTools updateNavigationBarWithController:self showBackView:NO showLine:NO];
    self.ffTitle = @"我";
    self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L2;
    [self.ffNavigationView showRightItemWithTitle:@"设置"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.needRefresh) {
        self.needRefresh = NO;
        [self refreshData];
    }
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberWithSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section==0)?0.01:CYTAutoLayoutV(70);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CYTItemMarginV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (!self.headCell) {
            self.headCell = [CYTUserHeaderCell cellForTableView:self.mainView.tableView indexPath:indexPath];
        }
        self.headCell.userInfoModel = self.userInfoModel;
        float height = [self.headCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height +1.0f;
        return height;
    }else {
        self.itemCell.model = [self.viewModel cellModelWithIndexPath:indexPath];
        float height = [self.itemCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height +1.0f;
        return height;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CYTPersonalHomeCellHeader *header = [CYTPersonalHomeCellHeader new];
    header.titleLabel.text = [self.viewModel sectinTitleWithSection:section];
    header.hidden = (section == 0);
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CYTUserHeaderCell *cell = [CYTUserHeaderCell cellForTableView:tableView indexPath:indexPath];
        cell.userInfoModel = self.userInfoModel;
        return cell;
    }else {
        CYTPersonalHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTPersonalHomeCell identifier] forIndexPath:indexPath];
        cell.model = [self.viewModel cellModelWithIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self authenticateAlertWithBlock:^{
        if (indexPath.section == 0) {
            [self dealerHome];
        }else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                [self mySeeCar];
            }else {
                [self boughtOrder];
            }
        }else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                [self myCarSource];
            }else {
                [self soldOrder];
            }
        }else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                [self logisticsNeed];
            }else {
                [self logsiticsOrder];
            }
        }else if (indexPath.section == 4) {
            if (indexPath.row == 0) {
                [self account];
            }else if (indexPath.row == 1) {
                [self coupon];
            }else if (indexPath.row == 2) {
                [self dealPwd];
            }else if (indexPath.row == 3) {
                [self getCash];
            }else if (indexPath.row == 4) {
                [self myCurrency];
            }
        }else if (indexPath.section == 5) {
            if (indexPath.row == 0) {
                [self myConnected];
            }else if (indexPath.row == 1) {
                [self connectedMe];
            }
        }
    }];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    //请求认证相关信息
    [[CYTAuthManager manager] getUserDealerInfoFromLocal:NO result:^(CYTUserInfoModel *model) {
        self.userInfoModel = model;
        //实体店认证数据保存到本地
        if (model.isStoreAuth) {
            [CYTCommonTool setValue:@"IsStoreAuth" forKey:CYTIsStoreAuthKey];
        }else{
            [CYTCommonTool removeValueForKey:CYTIsStoreAuthKey];
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        [self.mainView.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    //请求订单状态数据
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    CYTSettingViewController *ctr = [[CYTSettingViewController alloc] init];
    ctr.changeHeaderSuccess = ^{
        [self refreshData];
    };
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)refreshData {
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

#pragma mark- 所有跳转方法进行权限验证
- (void)authenticateAlertWithBlock:(void(^)(void))block {
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:YES result:^(AccountState state) {
        if (state == AccountStateAuthenticationed) {
            if (block) {
                block();
            }
        }
    }];
}

#pragma mark-
- (void)dealerHome {
    //点击就算
    [MobClick event:@"CSZY_WD"];
    self.needRefresh = YES;
    
    CYTDealerMeHomeTableController *meHome = [CYTDealerMeHomeTableController new];
    meHome.viewModel.userId = CYTUserId;
    [self.navigationController pushViewController:meHome animated:YES];
}

#pragma mark-
- (void)mySeeCar {
    self.needRefresh = YES;
    
    CYTMySeekCarViewController *mySeekCarViewController = [[CYTMySeekCarViewController alloc] init];
    [self.navigationController pushViewController:mySeekCarViewController animated:YES];
}

- (void)boughtOrder {
    self.needRefresh = YES;
    
    CYTCarOrderListViewController *orderList = [CYTCarOrderListViewController new];
    orderList.viewModel.orderType = CarOrderTypeBought;
    [self.navigationController pushViewController:orderList animated:YES];
}

#pragma mark-
- (void)myCarSource {
    self.needRefresh = YES;
    
    CYTMyCarSourceViewController *myCarSourceViewController = [[CYTMyCarSourceViewController alloc] init];
    [self.navigationController pushViewController:myCarSourceViewController animated:YES];
}

- (void)soldOrder {
    self.needRefresh = YES;
    
    CYTCarOrderListViewController *orderList = [CYTCarOrderListViewController new];
    orderList.viewModel.orderType = CarOrderTypeSold;
    [self.navigationController pushViewController:orderList animated:YES];
}

#pragma mark-
- (void)logisticsNeed {
    [MobClick event:@"WLFW_W"];
    self.needRefresh = YES;
    
    [self.navigationController pushViewController:[CYTLogisticsNeedList new] animated:YES];
}

- (void)logsiticsOrder {
    [MobClick event:@"WLFW_W"];
    self.needRefresh = YES;
    
    [self.navigationController pushViewController:[CYTLogisticsOrderList new] animated:YES];
}

#pragma mark-
- (void)account {
    CYTMyAccountCtr *ctr = [[CYTMyAccountCtr alloc] init];
    ctr.requestURL = kURL.kURL_myAccount;
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)coupon {
    CYTMyCouponViewController *seekCarNeedPublishVC = [CYTMyCouponViewController myCouponWithCouponCardType:CYTMyCouponCardTypeDefault];
    [self.navigationController pushViewController:seekCarNeedPublishVC animated:YES];
}

- (void)dealPwd {
    CYTWithdrawPwdSetTableController *ctr = [CYTWithdrawPwdSetTableController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)getCash {
    CYTGetCashCtr *ctr = [CYTGetCashCtr new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)myCurrency {
    //我的易车币
    CYTMyYicheCoinViewController *yichebi = [CYTMyYicheCoinViewController new];
    [self.navigationController pushViewController:yichebi animated:YES];
}

#pragma mark-
- (void)myConnected {
    [MobClick event:@"LXJL_W"];
    [self.navigationController pushViewController:[CYTMyContactViewController new] animated:YES];
}

- (void)connectedMe {
    [self.navigationController pushViewController:[CYTContactMeViewController new] animated:YES];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        //此页面不使用自动布局，因为刷新时页面因为布局高度经常跳动。
        _mainView.tableView.estimatedRowHeight = 0;
        
        _mainView.mjrefreshSupport = MJRefreshSupportRefresh;
        _mainView.tableView.showsVerticalScrollIndicator = NO;
        [_mainView registerCellWithIdentifier:@[[CYTPersonalHomeCell identifier]]];
        
        UIView *footer = [UIView new];
        footer.backgroundColor = kFFColor_bg_nor;
        footer.size = CGSizeMake(kScreenWidth, CYTMarginV);
        _mainView.tableView.tableFooterView = footer;
        
    }
    return _mainView;
}

- (CYTPersonalHomeVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTPersonalHomeVM new];
    }
    return _viewModel;
}

@end
