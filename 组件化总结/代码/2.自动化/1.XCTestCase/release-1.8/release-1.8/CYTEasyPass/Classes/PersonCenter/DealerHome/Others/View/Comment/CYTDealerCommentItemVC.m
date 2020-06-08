//
//  CYTDealerCommentItemVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentItemVC.h"
#import "CYTDealerHomeCommentCell.h"

@interface CYTDealerCommentItemVC ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation CYTDealerCommentItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenNavigationBarLine = YES;
    [self bindViewModel];
    [self loadUI];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        //更新count
        [[NSNotificationCenter defaultCenter] postNotificationName:kDealerCommentCountChangedKey object:self.viewModel.countModel];
        
        //更新list
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
           
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.listArray.count == 0);
            model.dataHasMore = self.viewModel.isMore;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
    }];
}

- (void)loadUI {
    [self.view addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData {
    if (self.viewModel.listArray.count == 0) {
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    }
}

- (void)refreshData {
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTDealerHomeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTDealerHomeCommentCell identifier] forIndexPath:indexPath];
    CYTDealerCommentListModel *model = self.viewModel.listArray[indexPath.row];
    cell.needSep = YES;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    self.viewModel.lastId = 0;
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
        [_mainView registerCellWithIdentifier:@[[CYTDealerHomeCommentCell identifier]]];
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTDealerCommentVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTDealerCommentVM new];
    }
    return _viewModel;
}

@end
