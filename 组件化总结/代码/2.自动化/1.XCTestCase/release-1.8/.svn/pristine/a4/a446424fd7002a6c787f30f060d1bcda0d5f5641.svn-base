//
//  CYTConnectedCarSourceCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTConnectedCarSourceCtr.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarListInfoCell.h"

@interface CYTConnectedCarSourceCtr ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation CYTConnectedCarSourceCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithBackButtonAndTitle:@"已联系车源"];
    [self bindViewModel];
    [self addUI];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
}

- (void)addUI {
    [self.view addSubview:self.mainView];

    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTViewOriginY);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)bindViewModel {
    self.viewModel.requestModel = [CYTCarSourceListRequestModel new];
    
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

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTCarSourceListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarSourceListViewModel new];
        _viewModel.type = ListTypeConnectHistory;
    }
    return _viewModel;
}

@end
