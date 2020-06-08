//
//  CYTCarContactsViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarContactsViewController.h"
#import "CYTContactsContentCell.h"
#import "CYTCarContactsListModel.h"
#import "CYTCarContactsModel.h"
#import "CYTEditCarContactsViewController.h"
#import "CYTCarContactsListParemeters.h"
#import "CYTCarContactsSetDefaulParemeters.h"
#import "CYTDeleteCarContactsParemeters.h"

@interface CYTCarContactsViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 联系人表格 */
@property(strong, nonatomic) UITableView *carContactsTableView;
/** 数据 */
@property(strong, nonatomic) NSMutableArray *carContactsData;
/** 新增联系人 */
@property(weak, nonatomic) UIButton *addNewContactBtn;

/** 请求参数:0:收车 1:发车 */
@property(assign, nonatomic) NSInteger type;

/** 是否为选择模式 */
@property(assign, nonatomic,getter=isSelectType) BOOL selectType;

/** 联系人类型 */
@property(assign, nonatomic) CYTCarContactsType contactsType;

@end

@implementation CYTCarContactsViewController

- (NSMutableArray *)carContactsData{
    if (!_carContactsData) {
        _carContactsData = [NSMutableArray array];
    }
    return _carContactsData;
}

+ (instancetype)carContactsWithType:(CYTCarContactsType)carContactsType{
    CYTCarContactsViewController *carContactsViewController = [[CYTCarContactsViewController alloc] init];
    carContactsViewController.contactsType = carContactsType;
    return carContactsViewController;
}

- (UITableView *)carContactsTableView{
    if (!_carContactsTableView) {
        CGFloat tableH = tableH = kScreenHeight - CYTViewOriginY - CYTAutoLayoutV(80+30);
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth,tableH);
        _carContactsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _carContactsTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _carContactsTableView.estimatedSectionFooterHeight = 0;
            _carContactsTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _carContactsTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self carContactsBasicConfig];
    [self configCarContactsTableView];
    [self initCarContactsComponents];
    [self refreshData];
}

/**
 *  基本配置
 */
- (void)carContactsBasicConfig{
    NSString *navTitle = [NSString string];
    if (self.type == 0) {
        navTitle = @"收车联系人";
    }else{
        navTitle = @"发车联系人";
    }
    [self createNavBarWithBackButtonAndTitle:navTitle];
    self.view.backgroundColor = CYTLightGrayColor;
}
/**
 *  配置表格
 */
- (void)configCarContactsTableView{
    self.carContactsTableView.backgroundColor = CYTLightGrayColor;
    self.carContactsTableView.delegate = self;
    self.carContactsTableView.dataSource = self;
    self.carContactsTableView.tableFooterView = [[UIView alloc] init];
    self.carContactsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.carContactsTableView.estimatedRowHeight = CYTAutoLayoutV(90);
    self.carContactsTableView.rowHeight = UITableViewAutomaticDimension;
    self.carContactsTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(20), 0);
    [self.view addSubview:self.carContactsTableView];
    //上拉刷新
    self.carContactsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestCarContactsDataWithRequestType:CYTRequestTypeRefresh showLoading:NO];
    }];
    
}
/**
 *  初始化子控件
 */
- (void)initCarContactsComponents{
    //新增联系人
    UIButton *addNewContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewContactBtn.hidden = YES;
    [addNewContactBtn setTitle:@"新增联系人" forState:UIControlStateNormal];
    [addNewContactBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
    addNewContactBtn.layer.cornerRadius = 6;
    addNewContactBtn.layer.masksToBounds = YES;
    addNewContactBtn.titleLabel.font = CYTFontWithPixel(38.f);
    [self.view addSubview:addNewContactBtn];
    _addNewContactBtn = addNewContactBtn;

    [_addNewContactBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTMarginH);
        make.right.equalTo(self.view).offset(-CYTMarginH);
        make.bottom.equalTo(self.view).offset(-CYTAutoLayoutV(30));
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
    CYTWeakSelf
    //添加新联系人
    CYTEditCarContactsType  editCarContactsType = 0;
    if (self.type== 0) {
        editCarContactsType = CYTEditCarContactsTypeReceiverSave;
    }else{
        editCarContactsType = CYTEditCarContactsTypeSenderSave;
    }
    [[addNewContactBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        CYTEditCarContactsViewController *editCarContactsViewController = [CYTEditCarContactsViewController editCarContactsWithType:editCarContactsType];
        editCarContactsViewController.editSuccess = ^{
            [weakSelf refreshData];
        };
        [weakSelf.navigationController pushViewController:editCarContactsViewController animated:YES];
    }];
}

/**
 *  加载数据
 */
- (void)refreshData{
    [self.carContactsTableView.mj_header beginRefreshing];
}

/**
 * 获取数据
 */
- (void)requestCarContactsDataWithRequestType:(CYTRequestType)requestType showLoading:(BOOL)showLoading{
    if (requestType == CYTRequestTypeRefresh) {
        [self.carContactsData removeAllObjects];
    }
    !showLoading?:[CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    CYTCarContactsListParemeters *par = [[CYTCarContactsListParemeters alloc] init];
    par.type = self.type;
    
    [CYTNetworkManager GET:kURL.user_contacts_getList parameters:par.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            _addNewContactBtn.hidden = NO;
            [self.carContactsTableView.mj_header endRefreshing];
            [self dismissNoNetworkView];
            CYTCarContactsListModel *carContactsListModel = [CYTCarContactsListModel mj_objectWithKeyValues:responseObject.dataDictionary];
            NSArray *temArray = [CYTCarContactsModel mj_objectArrayWithKeyValuesArray:carContactsListModel.list];
            [self.carContactsData addObjectsFromArray:temArray];
            self.carContactsData.count?[self dismissNoDataView]:[self showNoDataView];
            [self.carContactsTableView reloadData];
        }else{
            _addNewContactBtn.hidden = YES;
            [self showNoNetworkViewInView:self.view];
            [self.carContactsTableView.mj_header endRefreshing];
        }
    }];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.carContactsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
    CYTContactsContentCell *cell = [CYTContactsContentCell contactsContentCellForTableView:tableView indexPath:indexPath containToolBar:!self.isSelectType];
    CYTCarContactsModel *carContactsModel = self.carContactsData.count?self.carContactsData[indexPath.row]:nil;
    cell.carContactsModel = carContactsModel;
    //设置为默认联系人
    cell.defaultSetBlock = ^{
        [weakSelf setDefaultCarContactWithCarContactsModel:carContactsModel];
    };
    //编辑
    CYTEditCarContactsType  editCarContactsType = 0;
    if (self.type==0) {
        editCarContactsType = CYTEditCarContactsTypeReceiverEdit;
    }else{
        editCarContactsType = CYTEditCarContactsTypeSenderEdit;
    }
    
    cell.editBlock = ^{
        CYTEditCarContactsViewController *editCarContactsViewController = [CYTEditCarContactsViewController editCarContactsWithType:editCarContactsType];
        editCarContactsViewController.editSuccess = ^{
            [weakSelf refreshData];
        };
        editCarContactsViewController.carContactsModel = carContactsModel;
        [weakSelf.navigationController pushViewController:editCarContactsViewController animated:YES];
    };
    //删除
    cell.deleteBlock = ^{
        [CYTAlertView alertViewWithTitle:@"提示" message:@"一旦删除，无法恢复，确定要删除吗？" confirmAction:^{
            [self deleteCarContactWithCarContactsModel:carContactsModel];
        } cancelAction:nil];
    };
    return cell;
}
/**
 * 设置默认的收发车联系人
 */
- (void)setDefaultCarContactWithCarContactsModel:(CYTCarContactsModel *)carContactsModel{
    CYTCarContactsSetDefaulParemeters *par = [[CYTCarContactsSetDefaulParemeters alloc] init];
    par.contactid = carContactsModel.contactId.intValue;
    par.isdefault = carContactsModel.isDefault;
    par.type = self.type;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_contacts_setDefault parameters:par.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
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
- (void)deleteCarContactWithCarContactsModel:(CYTCarContactsModel *)carContactsModel{
    CYTDeleteCarContactsParemeters *par = [[CYTDeleteCarContactsParemeters alloc] init];
    par.contactid = carContactsModel.contactId.intValue;
    par.type = self.type;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_contacts_delete parameters:par.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
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
    //选择模式下回调数据
    CYTLog(@"%lu",(unsigned long)self.contactsType);
    if (self.isSelectType) {
        CYTCarContactsModel *carContactsModel = self.carContactsData[indexPath.row];
        !self.carContactBlock?:self.carContactBlock(carContactsModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
/**
 * 处理请求参数和页面模式
 */
- (void)setContactsType:(CYTCarContactsType)contactsType{
    //选择模型
    if (contactsType == CYTCarContactsTypeReceiverDefault || contactsType == CYTCarContactsTypeSenderDefault) {
        self.selectType = NO;
    }else{
        self.selectType = YES;
    }
    
    //请求参数
    if (contactsType == CYTCarContactsTypeReceiverDefault||contactsType == CYTCarContactsTypeReceiverSelect) {
        self.type = 0;
        
    }else{
        self.type = 1;
        
    }
}
/**
 * 重新加载
 */
- (void)reloadData{
    [self requestCarContactsDataWithRequestType:CYTRequestTypeRefresh showLoading:YES];
}

@end
