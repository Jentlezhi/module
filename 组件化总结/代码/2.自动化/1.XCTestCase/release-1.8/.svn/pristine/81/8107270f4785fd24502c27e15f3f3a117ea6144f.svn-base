//
//  CYTLogisticsOrderListItemTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderListItemTableController.h"
#import "CYTLogisticsNeedCell.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTLogisticsOrderList.h"

#define kAffirmReceiveCarAlert  @"请您确认已收到托运车辆后再点击确认收车"

@interface CYTLogisticsOrderListItemTableController ()

@end

@implementation CYTLogisticsOrderListItemTableController
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
    
    //确认收车
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    [self.viewModel.affirmReceiveCarCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        [CYTToast messageToastWithMessage:responseModel.resultMessage];
        if (responseModel.resultEffective) {
            //如果成功则刷新列表
            [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticsOrderListRefreshKey object:nil];
        }
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
    CYTLogisticsOrderListModel *model = self.viewModel.listArray[indexPath.row];
    CYTLogisticsNeedCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTLogisticsNeedCell identifier] forIndexPath:indexPath];
    
    @weakify(self);
    [cell setClickedBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 100) {
            //确认收车
            [self affirmReceiveCarWithModel:model];
        }else if(index == 200){
            //去评价
            [self commentWithModel:model];
        }
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderModel = model;
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

- (void)affirmReceiveCarWithModel:(CYTLogisticsOrderListModel *)model {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:kAffirmReceiveCarAlert delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
        if ([x integerValue]==1) {
            self.viewModel.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
            [self.viewModel.affirmReceiveCarCommand execute:nil];
        }
    }];
    [alert show];
}

- (void)commentWithModel:(CYTLogisticsOrderListModel *)model {
    CYTLogisticsOrderDetail3DController *logisticsOrderDetailController = [[CYTLogisticsOrderDetail3DController alloc] init];
    logisticsOrderDetailController.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    logisticsOrderDetailController.showCommentView = YES;
    [self.orderList pushViewController:logisticsOrderDetailController withAnimate:YES];
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

- (CYTLogisticsOrderVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTLogisticsOrderVM new];
    }
    return _viewModel;
}

@end
