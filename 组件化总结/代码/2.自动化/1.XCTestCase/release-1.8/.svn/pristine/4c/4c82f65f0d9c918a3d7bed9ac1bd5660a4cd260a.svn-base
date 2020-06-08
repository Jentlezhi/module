//
//  CYTBasicTableViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewController.h"

@interface CYTBasicTableViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 当前已选中indexpath */
@property(strong, nonatomic) NSIndexPath *currentSelectedIndexPath;

@end



@implementation CYTBasicTableViewController

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)mainTableView{
    if (!_mainTableView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainTableView.estimatedSectionFooterHeight = 0;
            _mainTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicTableViewBasicConfig];
    [self configMainTableView];
}
/**
 *  基本配置
 */
- (void)basicTableViewBasicConfig{
    self.view.backgroundColor = CYTLightGrayColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

/**
 *  配置表格
 */
- (void)configMainTableView{
    self.mainTableView.backgroundColor = CYTLightGrayColor;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mainTableView];
}
/**
 *  是否展示测试数据
 */
- (void)setShowTestData:(BOOL)showTestData{
    _showTestData = showTestData;
    if (showTestData) {
        NSArray *testArray = @[@"表格一",@"表格二",@"表格三",@"表格四",@"表格五",@"表格六"];
        self.dataSource = [testArray copy];
    }
}
/**
 *  允许下拉刷新
 */
- (void)setHeaderRefreshEnable:(BOOL)headerRefreshEnable{
    CYTWeakSelf
    _headerRefreshEnable = headerRefreshEnable;
    if (headerRefreshEnable) {
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            !weakSelf.headerRefreshBlock?:weakSelf.headerRefreshBlock();
        }];
    }
}
/**
 *  允许上拉加载更多
 */
- (void)setFooterRefreshEnable:(BOOL)footerRefreshEnable{
    CYTWeakSelf
    _footerRefreshEnable = footerRefreshEnable;
    if (footerRefreshEnable) {
        self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            !weakSelf.footerRefreshBlock?:weakSelf.footerRefreshBlock();
        }];
    }
}

#pragma mark - 配置


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentSelectedIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - <ReloadSectionsDataSource>

- (void)reloadCellWithIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation{
    if (indexPath) {
        UITableViewRowAnimation rowAnimation = animation?UITableViewRowAnimationFade:UITableViewRowAnimationNone;
        [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:rowAnimation];
    }
}

- (void)reloadSectionWithSectionNum:(NSUInteger)sectionNum animation:(BOOL)animation{
    UITableViewRowAnimation rowAnimation = animation?UITableViewRowAnimationFade:UITableViewRowAnimationNone;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionNum];
    if (indexSet) {
        [self.mainTableView reloadSections:indexSet withRowAnimation:rowAnimation];
    }
}


- (void)reloadSectionWithSectionsNum:(NSUInteger)sectionsNum animation:(BOOL)animation{
    UITableViewRowAnimation rowAnimation = animation?UITableViewRowAnimationFade:UITableViewRowAnimationNone;
    for (NSUInteger index = 0; index<sectionsNum; index++) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        if (indexSet) {
            [self.mainTableView reloadSections:indexSet withRowAnimation:rowAnimation];
        }
    }
}





@end
