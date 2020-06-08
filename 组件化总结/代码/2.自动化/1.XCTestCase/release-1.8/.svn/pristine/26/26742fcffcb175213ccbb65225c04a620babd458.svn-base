//
//  CYTCarFilterTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarFilterTableController.h"
#import "CarFilterConditionView.h"
#import "CYTCarListInfoCell.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"
#import "CYTSeekCarDetailViewController.h"

@interface CYTCarFilterTableController ()
@property (nonatomic, strong) CarFilterConditionView *conditionView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation CYTCarFilterTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.bgView];
    [self.ffContentView addSubview:self.conditionView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(CYTAutoLayoutV(80));
    }];
    [self.conditionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    //满足筛选条件的数据
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.listArray.count==0);
            model.dataHasMore = self.viewModel.isMore;
            model.netEffective = responseModel.resultEffective;
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
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    self.ffTitle = self.viewModel.titleString;
    
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kCarFilterRefreshKey object:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
    }];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTCarListInfoCell *cell = [CYTCarListInfoCell cellWithType:CYTCarListInfoTypeCarSource forTableView:self.mainView.tableView indexPath:indexPath hideTopBar:NO];
    if (self.viewModel.source == CarViewSourceCarSource) {
        cell.carSourceListModel = self.viewModel.listArray[indexPath.row];
    }else {
        cell.seekCarListModel = self.viewModel.listArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.viewModel.source == CarViewSourceCarSource) {
        CYTCarSourceListModel *model = self.viewModel.listArray[indexPath.row];
        CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
        detail.viewModel.carSourceId = model.carSourceInfo.carSourceId;
        [self.navigationController pushViewController:detail animated:YES];
    }else {
        CYTSeekCarListModel *model = self.viewModel.listArray[indexPath.row];
        CYTSeekCarDetailViewController *detail = [[CYTSeekCarDetailViewController alloc] init];
        detail.seekCarId = model.seekCarInfo.seekCarId;
        detail.userId = model.dealer.userId;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    self.viewModel.listRequestModel.lastId = 0;
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

#pragma mark- get
- (CarFilterConditionView *)conditionView {
    if (!_conditionView) {
        CarFilterConditionVM *vm = [CarFilterConditionVM new];
        vm.requestModel = self.viewModel.requestModel;
        vm.listRequestModel = self.viewModel.listRequestModel;
        _conditionView = [[CarFilterConditionView alloc] initWithViewModel:vm];
        _conditionView.segmentHeight = CYTAutoLayoutV(80);
        @weakify(self);
        [_conditionView setConditionViewExtendBlock:^(BOOL isExtend) {
            @strongify(self);
            self.bgView.alpha = (isExtend)?1:0;
        }];
    }
    return _conditionView;
}

- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.dznCustomView.emptyView.dznLabel.text = @"- 暂无更多内容 -";
    }
    return _mainView;
}

- (CarFilterVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CarFilterVM new];
    }
    return _viewModel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _bgView.alpha = 0;
    }
    return _bgView;
}

@end
