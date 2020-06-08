//
//  CYTCarSourceListViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceListViewController.h"
#import "CYTCustomNavBar.h"
#import "CYTCarSourceSearchTableController.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarSourcePublishViewController.h"
#import "CYTCarListInfoCell.h"
#import "CYTCarSourceListFrequentlyBrandView.h"
#import "CYTBrandSelectViewController.h"
#import "CYTCarFilterTableController.h"

@interface CYTCarSourceListViewController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
///自定义导航
@property (nonatomic, strong) CYTCustomNavBar *navView;
///常用品牌
@property (nonatomic, strong) CYTCarSourceListFrequentlyBrandView *frequentlyBrandView;

@end

@implementation CYTCarSourceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    [self addUI];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kRefresh_CarSourceList object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kloginSucceedKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kResiterSuccessKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kResetPwdSucceedKey object:nil];
    
}

- (void)refreshMethod {
    [self.frequentlyBrandView reloadBrandView];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
}

- (void)addUI {
    self.hiddenNavigationBarLine = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.mainView];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTStatusBarHeight);
        make.height.equalTo(44);
    }];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTViewOriginY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
}

- (void)bindViewModel {
    self.viewModel.requestModel = [CYTCarSourceListRequestModel new];
    self.viewModel.requestModel.orderByPrice = -1;
    
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = self.viewModel.listArray.count == 0 ? YES :NO;
            model.dataHasMore = self.viewModel.isMore;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
    }];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTCarListInfoCell *cell = [CYTCarListInfoCell cellWithType:CYTCarListInfoTypeCarSource forTableView:self.mainView.tableView indexPath:indexPath hideTopBar:NO];
    cell.carSourceListModel = self.viewModel.listArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CYTCarSourceListModel *model = self.viewModel.listArray[indexPath.row];
    CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
    detail.viewModel.carSourceId = model.carSourceInfo.carSourceId;
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    self.viewModel.requestModel.lastId = 0;
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)publishMethod {
    @weakify(self);
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
        @strongify(self);
        [CYTLoadingView hideLoadingView];
        if (state == AccountStateAuthenticationed) {
            CYTCarSourcePublishViewController *publish = [CYTCarSourcePublishViewController new];
            [self.navigationController pushViewController:publish animated:YES];
        }
    }];
}

- (void)filterWithBrand:(CYTBrandSelectModel *)model {
    CYTBrandSelectViewController *brandSelect = [CYTBrandSelectViewController new];
    __weak typeof(self)bself = self;
    brandSelect.ffobj = bself;
    brandSelect.viewModel.type = CYTBrandSelectTypeSeries;
    brandSelect.viewModel.selectedBrandModel = (model)?model:nil;
    brandSelect.viewModel.needBack = NO;
    
    @weakify(self);
    [brandSelect setBrandSelectBlock:^(CYTBrandSelectResultModel *brandModel) {
        @strongify(self);
        self.viewModel.brandSelectModel = brandModel;
        CYTCarFilterTableController *filterController = [CYTCarFilterTableController new];
        filterController.viewModel.titleString = @"车源筛选";
        filterController.viewModel.source = CarViewSourceCarSource;
        
        filterController.viewModel.requestModel.type = 3;
        filterController.viewModel.requestModel.sourceTypeId = 1;
        filterController.viewModel.requestModel.businessId = brandModel.seriesModel.serialId;
        
        filterController.viewModel.listRequestModel.carSerialId = brandModel.seriesModel.serialId;;
        filterController.viewModel.listRequestModel.source = 2;
        
        [self.navigationController pushViewController:filterController animated:YES];
    }];
    [self.navigationController pushViewController:brandSelect animated:YES];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.dznCustomViewModel.dznOffsetY = 50;
        self.frequentlyBrandView.bounds = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(220));
        _mainView.tableView.tableHeaderView = self.frequentlyBrandView;
    }
    return _mainView;
}

- (CYTCarSourceListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarSourceListViewModel new];
        _viewModel.type = ListTypeCarSource;
    }
    return _viewModel;
}

- (CYTCustomNavBar *)navView {
    if (!_navView) {
        _navView = [CYTCustomNavBar new];
        _navView.rightImageView.image = [UIImage imageNamed:@"carSource_nav_publish"];
        _navView.rightTitleLabel.text = @"发布车源";
        
        @weakify(self);
        [_navView setPublishBlock:^{
            @strongify(self);
            [MobClick event:@"CYFB_CYLB"];
            [self publishMethod];
        }];
        [_navView setSearchBlock:^{
            @strongify(self);
            CYTCarSourceSearchTableController *ctr = [CYTCarSourceSearchTableController new];
            [self.navigationController pushViewController:ctr animated:YES];
        }];
    }
    return _navView;
}

- (CYTCarSourceListFrequentlyBrandView *)frequentlyBrandView {
    if (!_frequentlyBrandView) {
        _frequentlyBrandView = [CYTCarSourceListFrequentlyBrandView new];
        @weakify(self);
        [_frequentlyBrandView setBrandFilterBlock:^{
            @strongify(self);
            [self filterWithBrand:nil];
        }];
        [_frequentlyBrandView setBrandModelBlock:^(CYTBrandSelectModel *model) {
            @strongify(self);
            [self filterWithBrand:model];
        }];
    }
    return _frequentlyBrandView;
}

@end
