//
//  CYTAddressListViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressListViewController.h"
#import "CYTAddressListCell.h"
#import "CYTAddressListModel.h"
#import "CYTAddressModel.h"
#import "CYTAddressAddOrModifyViewController.h"
#import "CYTSetDefaultReceivingAddresParameters.h"
#import "CYTDeleteReceivingAddressParemeters.h"

@interface CYTAddressListViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 联系人表格 */
@property(strong, nonatomic) UITableView *addressListTableView;
/** 数据 */
@property(strong, nonatomic) NSMutableArray *addressListsData;
/** 新增地址 */
@property(weak, nonatomic) UIButton *addNewAddressBtn;

/** 是否为选择模式 */
@property(assign, nonatomic,getter=isSelectType) BOOL selectType;
/** 联系人类型 */
@property(assign, nonatomic) CYTAddressListType addressListType;

@end

@implementation CYTAddressListViewController

- (NSMutableArray *)addressListsData{
    if (!_addressListsData) {
        _addressListsData = [NSMutableArray array];
    }
    return _addressListsData;
}

+ (instancetype)addressListWithType:(CYTAddressListType)addressListType{
    CYTAddressListViewController *addressListViewController = [[CYTAddressListViewController alloc] init];
    addressListViewController.addressListType = addressListType;
    return addressListViewController;
}

- (UITableView *)addressListTableView{
    if (!_addressListTableView) {
        CGFloat tableH = 0.f;
        tableH = kScreenHeight - CYTViewOriginY - CYTAutoLayoutV(80+30);
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, tableH);
        _addressListTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _addressListTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _addressListTableView.estimatedSectionFooterHeight = 0;
            _addressListTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _addressListTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addressListBasicConfig];
    [self configAddressListTableView];
    [self initAddressListComponents];
    [self makeConstrains];
    [self refreshData];
}

/**
 *  基本配置
 */
- (void)addressListBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    [self createNavBarWithBackButtonAndTitle:@"地址管理"];
}
/**
 *  配置表格
 */
- (void)configAddressListTableView{
    self.addressListTableView.backgroundColor = CYTLightGrayColor;
    self.addressListTableView.delegate = self;
    self.addressListTableView.dataSource = self;
    self.addressListTableView.tableFooterView = [[UIView alloc] init];
    self.addressListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.addressListTableView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.addressListTableView.rowHeight = UITableViewAutomaticDimension;
    self.addressListTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(20), 0);
    [self.view addSubview:self.addressListTableView];
    //上拉刷新
    self.addressListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestaddressListsDataWithRequestType:CYTRequestTypeRefresh showLoading:NO];
    }];
    
}
/**
 *  初始化子控件
 */
- (void)initAddressListComponents{
    //新增地址
    UIButton *addNewContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewContactBtn.hidden = YES;
    [addNewContactBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addNewContactBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
    addNewContactBtn.layer.cornerRadius = 6;
    addNewContactBtn.layer.masksToBounds = YES;
    addNewContactBtn.titleLabel.font = CYTFontWithPixel(38.f);
    [self.view addSubview:addNewContactBtn];
    _addNewAddressBtn = addNewContactBtn;
    
    //添加新联系人
    [[addNewContactBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //code...
        [self addOrModifyAddressWithModel:nil];
    }];
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_addNewAddressBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTMarginH);
        make.right.equalTo(self.view).offset(-CYTMarginH);
        make.bottom.equalTo(self.view).offset(-CYTAutoLayoutV(30));
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
}

/**
 *  加载数据
 */
- (void)refreshData{
    [self.addressListTableView.mj_header beginRefreshing];
}

/**
 * 获取车源数据
 */
- (void)requestaddressListsDataWithRequestType:(CYTRequestType)requestType showLoading:(BOOL)showLoading{
    if (requestType == CYTRequestTypeRefresh) {
        [self.addressListsData removeAllObjects];
    }
    !showLoading?:[CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager GET:kURL.user_address_getList parameters:nil dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self dismissNoNetworkView];
            _addNewAddressBtn.hidden = NO;
            [self.addressListTableView.mj_header endRefreshing];
            CYTAddressListModel *adressListModel = [CYTAddressListModel mj_objectWithKeyValues:responseObject.dataDictionary];
            NSArray *temArray = [CYTAddressModel mj_objectArrayWithKeyValuesArray:adressListModel.list];
            [self.addressListsData addObjectsFromArray:temArray];
            self.addressListsData.count?[self dismissNoDataView]:[self showNoDataView];
            [self.addressListTableView reloadData];
        }else{
            _addNewAddressBtn.hidden = YES;
            [self showNoNetworkViewInView:self.view];
            [self.addressListTableView.mj_header endRefreshing];
        }
    }];
}

- (void)addOrModifyAddressWithModel:(CYTAddressModel *)model {
    CYTAddressAddOrModifyViewController *add = [CYTAddressAddOrModifyViewController new];
    add.viewModel.addressModel = (model)?:[CYTAddressModel new];
    add.viewModel.addressAdd = (model)?NO:YES;
    @weakify(self);
    [add setRefreshBlock:^(CYTAddressAddOrModifyVM *model) {
        @strongify(self);
        [self refreshData];
    }];
    
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressListsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTAddressListCell *cell = [CYTAddressListCell addressListCellForTableView:tableView indexPath:indexPath containToolBar:!self.isSelectType];
    CYTAddressModel *addressModel = self.addressListsData.count?self.addressListsData[indexPath.row]:nil;
    if ([self.addressModel.receivingId isEqualToString:addressModel.receivingId]) {
        addressModel.hasSelected = YES;
    }else{
        addressModel.hasSelected = NO;
    }
    cell.addressModel = addressModel;
    //设置为默认地址
    cell.defaultSetBlock = ^{
        [self setDefaultAddressWithAddressModel:addressModel];
    };
    //编辑
    @weakify(self);
    cell.editBlock = ^{
        @strongify(self);
        [self addOrModifyAddressWithModel:addressModel];
    };
    //删除
    cell.deleteBlock = ^{
        [CYTAlertView alertViewWithTitle:@"提示" message:@"一旦删除，无法恢复，确定要删除吗？" confirmAction:^{
           [self deleteAddressWithAddressModell:addressModel];
        } cancelAction:nil];       
    };
    return cell;
}
/**
 * 设置默认的地址
 */
- (void)setDefaultAddressWithAddressModel:(CYTAddressModel *)addressModel{
    
    CYTSetDefaultReceivingAddresParameters *pars = [[CYTSetDefaultReceivingAddresParameters alloc] init];
    pars.receivingId = addressModel.receivingId.intValue;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_address_setDefault parameters:pars.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self refreshData];
        }
    }];
}

/**
 * 删除收发车联系人
 */
- (void)deleteAddressWithAddressModell:(CYTAddressModel *)addressModel{
    
    CYTDeleteReceivingAddressParemeters *pars = [[CYTDeleteReceivingAddressParemeters alloc] init];
    pars.receivingId = addressModel.receivingId.intValue;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_address_delete parameters:pars.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self refreshData];
        }
    }];
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectType) {
        CYTAddressModel *addressModel = self.addressListsData[indexPath.row];
        !self.addressSelectBlock?:self.addressSelectBlock(addressModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/**
 * 处理请求参数
 */
- (void)setAddressListType:(CYTAddressListType)addressListType{
    _addressListType = addressListType;
    if (addressListType == CYTAddressListTypeSelect) {
        self.selectType = YES;
    }else{
        self.selectType = NO;
    }
}
/**
 * 重新加载
 */
- (void)reloadData{
    [self requestaddressListsDataWithRequestType:CYTRequestTypeRefresh showLoading:YES];
}


@end
