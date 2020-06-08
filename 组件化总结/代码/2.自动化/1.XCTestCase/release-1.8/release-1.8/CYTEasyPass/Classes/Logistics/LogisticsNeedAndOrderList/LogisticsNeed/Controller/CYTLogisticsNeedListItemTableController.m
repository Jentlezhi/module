//
//  CYTLogisticsNeedListItemTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedListItemTableController.h"
#import "CYTLogisticsNeedCell.h"

@interface CYTLogisticsNeedListItemTableController ()
@property (nonatomic, strong) CYTLogisticsNeedCell *itemCell;

@end

@implementation CYTLogisticsNeedListItemTableController
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
    self.itemCell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedCell identifier]];
    
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

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = NO;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTLogisticsNeedCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedCell identifier] forIndexPath:indexPath];
    CYTLogisticsNeedListModel *model = self.viewModel.listArray[indexPath.row];
    cell.needModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectBlock) {
        self.selectBlock(self.viewModel.listArray[indexPath.row]);
    }
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    self.viewModel.lastId = 0;
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)refreshMethodWithNeed:(BOOL)need {
    if (need) {
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    }else {
        if (self.viewModel.listArray.count == 0) {
            [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
        }
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTLogisticsNeedCell identifier]]];
        [CYTTools configForMainView:_mainView ];
        
        UIView *footerView = [UIView new];
        footerView.size = CGSizeMake(kScreenWidth, CYTAutoLayoutV(130));
        _mainView.tableView.tableFooterView = footerView;
    }
    return _mainView;
}

- (CYTLogisticsNeedVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTLogisticsNeedVM new];
    }
    return _viewModel;
}

@end
