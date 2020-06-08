//
//  CYTManageTypeViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTManageTypeViewController.h"
#import "CYTManageTypeCell.h"
#import "CYTManageTypeModel.h"
#import "CYTManageTypeResult.h"

#define  CYTLevelidsKey @"CYTLevelids"
#define  CYTManageTypeCellHight CYTAutoLayoutV(90)

@interface CYTManageTypeViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 视图表格 */
@property(strong, nonatomic) UITableView *manageTypeTableView;
/** 数据 */
@property(strong, nonatomic) NSMutableArray *manageTypeData;
/** 确认按钮 */
@property(weak, nonatomic) UIButton *confirmBtn;
/** LevelIds */
@property(strong, nonatomic) NSMutableArray *levelIds;

@end

@implementation CYTManageTypeViewController

- (NSArray *)selectTypeData{
    if (!_selectTypeData) {
        _selectTypeData = [NSArray array];
    }
    return _selectTypeData;
}

- (NSMutableArray *)levelIds{
    if (!_levelIds) {
        _levelIds = [NSMutableArray array];
    }
    return _levelIds;
}

- (CYTManageTypeModel *)manageTypeModel{
    if (!_manageTypeModel) {
        _manageTypeModel = [[CYTManageTypeModel alloc] init];
    }
    return _manageTypeModel;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
        confirmBtn.layer.cornerRadius = 6;
        confirmBtn.layer.masksToBounds = YES;
        confirmBtn.titleLabel.font = CYTFontWithPixel(38.f);
        confirmBtn.enabled = NO;
        [self.view addSubview:confirmBtn];
        _confirmBtn = confirmBtn;
    }
    return _confirmBtn;
}

- (NSMutableArray *)manageTypeData{
    if (!_manageTypeData) {
        _manageTypeData = [NSMutableArray array];
    }
    return _manageTypeData;
}

- (UITableView *)manageTypeTableView{
    if (!_manageTypeTableView) {
        CGRect mbFrame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _manageTypeTableView = [[UITableView alloc] initWithFrame:mbFrame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _manageTypeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _manageTypeTableView.estimatedSectionFooterHeight = 0;
            _manageTypeTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _manageTypeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configmanageTypeTableView];
    [self manageTypeBasicConfig];
    [self initmanageTypeComponents];
    [self refreshData];
}

/**
 *  基本配置
 */
- (void)manageTypeBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"选择公司类型"];
    self.interactivePopGestureEnable = NO;
}
/**
 *  初始化子控件
 */
- (void)initmanageTypeComponents{
    //确认按钮
    [self.confirmBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTMarginH);
        make.right.equalTo(self.view).offset(-CYTMarginH);
        make.bottom.equalTo(self.view).offset(-CYTAutoLayoutV(25));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    CYTWeakSelf
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !weakSelf.companyTypeBack?:weakSelf.companyTypeBack(weakSelf.manageTypeModel);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

/**
 *  配置表格
 */
- (void)configmanageTypeTableView{
    self.manageTypeTableView.backgroundColor = [UIColor whiteColor];
    self.manageTypeTableView.delegate = self;
    self.manageTypeTableView.dataSource = self;
    self.manageTypeTableView.tableFooterView = [[UIView alloc] init];
    self.manageTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.manageTypeTableView];
    //上拉刷新
    self.manageTypeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestManageTypeDataWithRequestType:CYTRequestTypeRefresh];
    }];
    
}
/**
 *  加载数据
 */
- (void)refreshData{
    [self.manageTypeTableView.mj_header beginRefreshing];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.manageTypeData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTManageTypeCell *cell = [CYTManageTypeCell manageTypeCellForTableView:tableView indexPath:indexPath];
    cell.manageTypeModel = self.manageTypeData[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CYTManageTypeCellHight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTManageTypeModel *typeModel = self.manageTypeData[indexPath.row];
    self.manageTypeModel = typeModel;
    self.confirmBtn.enabled = YES;
}
/**
 *  获取公司类型
 */
- (void)requestManageTypeDataWithRequestType:(CYTRequestType)requestType{
    
    [CYTNetworkManager GET:kURL.user_info_GetBusinessModel parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [self.manageTypeTableView.mj_header endRefreshing];
        if (responseObject.resultEffective) {
            [self.view bringSubviewToFront:self.confirmBtn];
            [self dismissNoNetworkView];
            
            [self.manageTypeData removeAllObjects];
            NSArray *tempArray = [CYTManageTypeModel mj_objectArrayWithKeyValuesArray:[responseObject.dataDictionary valueForKey:@"data"]];
            [self.manageTypeData addObjectsFromArray:tempArray];
            if (self.manageTypeData.count) {
                [self.view bringSubviewToFront:self.confirmBtn];
                [self dismissNoDataView];
            }else{
                [self.view bringSubviewToFront:self.manageTypeTableView];
                [self showNoDataView];
            }
            [self.levelIds removeAllObjects];
            for (CYTManageTypeModel *item in self.manageTypeData) {
                [self.levelIds addObject:item.levelId];
            }
            [self.manageTypeTableView reloadData];
            
            //记录上次选择
            if (self.manageTypeModel.levelId) {
                NSUInteger selectRow = [self.levelIds indexOfObject:self.manageTypeModel.levelId];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectRow inSection:0];
                self.confirmBtn.enabled = YES;
                [self.manageTypeTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            }else{
                self.confirmBtn.enabled = NO;
            }
        }else{
            [self.view bringSubviewToFront:self.manageTypeTableView];
            [self showNoNetworkView];
        }

    }];
    
}

- (void)reloadData{
    [self refreshData];
}



@end
