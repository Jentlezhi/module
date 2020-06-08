//
//  CYTCarDealerChartItemTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarDealerChartItemTableController.h"
#import "CYTCarDealerChartCell.h"
#import "CYTCarDealerChartMeView.h"

@interface CYTCarDealerChartItemTableController ()
@property (nonatomic, strong) CYTCarDealerChartMeView *meSortView;

@end

@implementation CYTCarDealerChartItemTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.meSortView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.meSortView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self)
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue]==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = self.viewModel.listArray.count==0;
            model.dataHasMore = self.viewModel.isMore;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //设置我的排名
            self.meSortView.model = self.viewModel.meSortModel;
            float offset = (self.viewModel.meSortModel)?CYTAutoLayoutV(160):CYTItemMarginV;
            self.mainView.tableView.contentInset = UIEdgeInsetsMake(0, 0, offset, 0);
        });

    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.viewModel = viewModel;
    _showNavigationView = NO;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)refreshData {
    if (self.viewModel.listArray.count==0) {
        [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
    }
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
    ccModel.ffIndexPath = indexPath;
    ccModel.ffIdentifier = [CYTCarDealerChartCell identifier];
    FFExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    cell.ffCustomizeCellModel = ccModel;
    ((CYTCarDealerChartCell *)cell).type = self.viewModel.type;
    cell.ffModel = self.viewModel.listArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CYTCarDealerChartItemModel *model = self.viewModel.listArray[indexPath.row];
    //如果有链接则跳转
    [[CYTMessageCenterVM manager] handleMessageURL:model.linkUrl];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
//        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTCarDealerChartCell identifier]]];
    }
    return _mainView;
}

- (CYTCarDealerChartMeView *)meSortView {
    if (!_meSortView) {
        _meSortView = [CYTCarDealerChartMeView new];
        _meSortView.type = self.viewModel.type;
        _meSortView.hidden = YES;
    }
    return _meSortView;
}

- (CYTCarDealerChartItemVM* )viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarDealerChartItemVM new];
    }
    return _viewModel;
}

@end
