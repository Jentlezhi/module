//
//  CYTMessageCategoryTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageCategoryTableController.h"
#import "CYTMessageCategoryCell.h"
#import "CYTMessageListTableController.h"

@interface CYTMessageCategoryTableController ()

@end

@implementation CYTMessageCategoryTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = NO;
            model.dataHasMore = NO;
            return model;
        }];
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"消息中心";
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    [self refreshData];
    self.interactivePopGestureEnable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:kMessageReadStateSendSuccceed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:kReceivePushKey object:nil];
    //message
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
    ccModel.ffIndexPath = indexPath;
    ccModel.ffIdentifier = [CYTMessageCategoryCell identifier];
    
    CYTMessageCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    CYTMessageCategoryModel *model = self.viewModel.listArray[indexPath.row];
    cell.ffCustomizeCellModel = ccModel;
    cell.ffModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTMessageListTableController *list = [CYTMessageListTableController new];
    @weakify(self);
    [list setBackBlock:^(NSInteger type) {
        @strongify(self);
        //将改分类下的消息数清空
        [self.viewModel clearAllMessageWithType:type];
        [self.mainView.tableView reloadData];
    }];
    CYTMessageCategoryModel *model = self.viewModel.listArray[indexPath.row];
    list.viewModel.categoryModel = model;
    [self.navigationController pushViewController:list animated:YES];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
    
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    !self.refreshBlock?:self.refreshBlock();
    [super ff_leftClicked:backView];
}

- (void)refreshData {
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTMessageCategoryCell identifier]]];
        _mainView.mjrefreshSupport = MJRefreshSupportRefresh;
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTMessageCategoryVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTMessageCategoryVM new];
    }
    return _viewModel;
}

@end
