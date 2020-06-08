//
//  CYTVehicleToolsModelViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTVehicleToolsViewController.h"
#import "CYTVehicleToolsListCell.h"
#import "CYTVehicleToolsListView.h"
#import "CYTPublishRemarkVC.h"
#import "CYTVehicleToolsModel.h"

static const CGFloat bottomBtnHeight = 98.f;

@interface CYTVehicleToolsViewController ()

/** 随车类型 */
@property(assign, nonatomic) CYTVehicleToolsType vehicleToolsType;
/** 已选项 */
@property(strong, nonatomic) NSMutableArray *selectedData;
/** 组数据 */
@property(strong, nonatomic) NSArray *sectionData;
/** 全选 */
@property(strong, nonatomic) CYTVehicleToolsListView *selectAllListView;
/** 全选点击 */
@property(copy, nonatomic) void(^selectAllClick)();
/** 确定按钮 */
@property(strong, nonatomic) UIButton *confirmBtn;

@end

@implementation CYTVehicleToolsViewController

+ (instancetype)vehicleToolsWithToolsType:(CYTVehicleToolsType)vehicleToolsType{
    CYTVehicleToolsViewController *vehicleToolsViewController = [[CYTVehicleToolsViewController alloc] init];
    vehicleToolsViewController.vehicleToolsType = vehicleToolsType;
    return vehicleToolsViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vehicleToolsBasicConfig];
    [self configVehicleToolsTableView];
    [self initVehicleToolsComponents];
    [self requestData];
}

/**
 *  基本配置
 */
- (void)vehicleToolsBasicConfig{
    NSString *title;
    if (self.vehicleToolsType == CYTVehicleToolsTypeProcedure) {
        title = @"随车手续";
    }else{
        title = @"随车附件";
    }
    [self createNavBarWithBackButtonAndTitle:title];
    
}
/**
 *  配置表格
 */
- (void)configVehicleToolsTableView{
    self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(bottomBtnHeight), 0);

}

#pragma mark - 懒加载

- (NSMutableArray *)selectedData{
    if (!_selectedData) {
        _selectedData = [NSMutableArray array];
    }
    return _selectedData;
}

- (NSArray *)sectionData{
    if (!_sectionData) {
        CYTVehicleToolsModel *section0 = [[CYTVehicleToolsModel alloc] init];
        section0.name = @"全选";
        section0.imageName = @"unselected";
        section0.hideDividerLine = NO;
        section0.addItem = NO;
        
        CYTVehicleToolsModel *section1 = [[CYTVehicleToolsModel alloc] init];
        section1.imageName = @"btn_add_nor";
        section1.name = @"添加随车附件";
        section1.hideDividerLine = YES;
        section1.selected = YES;
        section1.addItem = YES;
        _sectionData = @[section0,section1];
    }
    return _sectionData;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        CYTWeakSelf
        _confirmBtn = [UIButton buttonWithTitle:@"确定"];
        CGFloat margin = CYTMarginV;
        CGFloat confirmBtnW = kScreenWidth - 2*margin;
        CGFloat confirmBtnH = CYTAutoLayoutV(90.f);
        CGFloat confirmBtnX = margin;
        CGFloat confirmBtnY = kScreenHeight - confirmBtnH - margin;
        _confirmBtn.frame = CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH);
        _confirmBtn.hidden = YES;
        [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !weakSelf.vehicleToolsSelected?:weakSelf.vehicleToolsSelected(weakSelf.selectedData);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _confirmBtn;
}
/**
 * 获取数据
 */
- (void)requestData{
    CYTWeakSelf
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    CYTGetVehicleType getVehicleTypeTools = self.vehicleToolsType == CYTVehicleToolsTypeProcedure?CYTGetVehicleTypeProcedure:CYTGetVehicleTypeTools;
    NSString *requsetUrl = getVehicleTypeTools == CYTGetVehicleTypeTools ? kURL.car_common_GetVehicleTools : kURL.car_common_GetVehicleProcedureDocuments;
    [CYTNetworkManager GET:requsetUrl parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [weakSelf dismissNoNetworkView];
            NSDictionary *dataDict = responseObject.dataDictionary;
            NSArray *dataAray = [CYTVehicleToolsModel mj_objectArrayWithKeyValuesArray:[dataDict valueForKey:@"list"]];
            [weakSelf.dataSource addObjectsFromArray:dataAray];
            if (weakSelf.dataSource.count) {
                self.confirmBtn.hidden = NO;
                [self dismissNoDataView];
            }else{
                self.confirmBtn.hidden = YES;
                [self showNoDataView];
            }
            [weakSelf.mainTableView reloadData];
        }else {
            weakSelf.confirmBtn.hidden = YES;
            [weakSelf showNoNetworkView];
        }
    }];
    
}

/**
 *  初始化子控件
 */
- (void)initVehicleToolsComponents{
    //添加确认按钮
    [self.view addSubview:self.confirmBtn];
}

- (void)reloadData{
    [self requestData];
}

#pragma mark - 懒加载

- (CYTVehicleToolsListView *)selectAllListView{
    if (!_selectAllListView) {
        CYTWeakSelf
        _selectAllListView = [[CYTVehicleToolsListView alloc] initWithType:CYTVehicleToolsViewTypeHeaderView];
        _selectAllListView.sectionHeaderClick = weakSelf.selectAllClick;
    }
    return _selectAllListView;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }
    return 0;
    
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(110.f);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CYTAutoLayoutV(90.f);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CYTWeakSelf
    CYTVehicleToolsModel *vehicleToolsModel = self.sectionData[section];
    if (section == 0) {
        self.selectAllListView.vehicleToolsModel = vehicleToolsModel;
        return self.selectAllListView;
    }else{
        CYTVehicleToolsListView *vehicleToolsListView = [[CYTVehicleToolsListView alloc] initWithType:CYTVehicleToolsViewTypeHeaderView];
        vehicleToolsListView.sectionHeaderClick = ^{
            CYTPublishRemarkVC *configVC = [CYTPublishRemarkVC new];
            configVC.titleString = @"添加随车附件";
            configVC.placeholder = @"请输入随车附件";
            [configVC setConfigBlock:^(NSString *content) {
                CYTVehicleToolsModel *vehicleToolsModel = [[CYTVehicleToolsModel alloc] init];
                vehicleToolsModel.name = content;
                vehicleToolsModel.imageName = @"selected";
                vehicleToolsModel.selected = YES;
                vehicleToolsModel.hideDividerLine = NO;
                [weakSelf.dataSource addObject:vehicleToolsModel];
                [weakSelf.selectedData addObject:vehicleToolsModel];
                [weakSelf.mainTableView reloadData];
            }];
            [self.navigationController pushViewController:configVC animated:YES];
        };
        vehicleToolsListView.vehicleToolsModel = vehicleToolsModel;
        return vehicleToolsListView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTVehicleToolsModel *vehicleToolsModel = self.dataSource[indexPath.row];
    if ([self.selectedData containsObject:vehicleToolsModel]) {
        vehicleToolsModel.selected = NO;
        [self.selectedData removeObject:vehicleToolsModel];
    }else{
        vehicleToolsModel.selected = YES;
        [self.selectedData addObject:vehicleToolsModel];
    }
    BOOL HighLight = self.selectedData.count == self.dataSource.count;
    [self selectAllListViewHighLight:HighLight];
    [self.mainTableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CYTVehicleToolsListCell *cell = [CYTVehicleToolsListCell celllForTableView:tableView indexPath:indexPath];
        CYTVehicleToolsModel *vehicleToolsModel = self.dataSource[indexPath.row];
        vehicleToolsModel.hideDividerLine = indexPath.row == self.dataSource.count-1;
        cell.vehicleToolsModel = vehicleToolsModel;
        return cell;
    }
    return nil;
}

#pragma mark - 全选

- (void (^)())selectAllClick{
    CYTWeakSelf
    return ^{
        CYTVehicleToolsModel *vehicleToolsModel = [self.sectionData firstObject];
        __weak typeof(_selectAllListView) weakVehicleToolsListView = _selectAllListView;
        vehicleToolsModel.selected = !vehicleToolsModel.selected;
        if (vehicleToolsModel.selected) {
            vehicleToolsModel.imageName = @"selected";
            [weakSelf.selectedData addObjectsFromArray:weakSelf.dataSource];
            [weakSelf.dataSource enumerateObjectsUsingBlock:^(CYTVehicleToolsModel *vehicleToolsModel, NSUInteger idx, BOOL * _Nonnull stop) {
                vehicleToolsModel.selected = YES;
            }];
        }else{
            vehicleToolsModel.imageName = @"unselected";
            [weakSelf.selectedData removeAllObjects];
            [weakSelf.dataSource enumerateObjectsUsingBlock:^(CYTVehicleToolsModel *vehicleToolsModel, NSUInteger idx, BOOL * _Nonnull stop) {
                vehicleToolsModel.selected = NO;
            }];
        }
        [weakSelf.mainTableView reloadData];
        weakVehicleToolsListView.vehicleToolsModel = vehicleToolsModel;
    };
}
/**
 *  设置全选高亮与否
 */
- (void)selectAllListViewHighLight:(BOOL)highLight{
    CYTVehicleToolsModel *vehicleToolsModel = [self.sectionData firstObject];
    vehicleToolsModel.imageName = highLight ? @"selected" : @"unselected";
    vehicleToolsModel.selected = highLight;
    self.selectAllListView.vehicleToolsModel = vehicleToolsModel;
}


@end
