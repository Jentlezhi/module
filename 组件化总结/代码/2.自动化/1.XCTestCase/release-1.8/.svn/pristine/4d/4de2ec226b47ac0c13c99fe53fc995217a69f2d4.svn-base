//
//  CYTDiscoverTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDiscoverTableController.h"
#import "CYTDiscoverCell.h"
#import "CYTCarTradeCircleCtr.h"
#import "CYTSeekCarDealerTableController.h"
#import "CYTCarDealerChartController.h"

@interface CYTDiscoverTableController ()

@end

@implementation CYTDiscoverTableController
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
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffNavigationView.bgImageView.backgroundColor = kTranslucenceColor;
    self.showNavigationBottomLine = YES;
    self.ffNavigationView.bottomLineView.backgroundColor = kFFColor_line;
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
    ccModel.ffIndexPath = indexPath;
    ccModel.ffIdentifier = [CYTDiscoverCell identifier];
    FFExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    cell.ffCustomizeCellModel = ccModel;
    CYTDiscoverModel_cell *model = self.viewModel.listArray[indexPath.row];
    cell.ffModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    @weakify(self);
    [self authenticateAlertWithBlock:^{
        @strongify(self);
        if (indexPath.row==0) {
            //车商圈
            [MobClick event:@"DBDH_CSQ"];
            CYTCarTradeCircleCtr *carDealerMoments = [CYTCarTradeCircleCtr new];
            carDealerMoments.requestURL = kURL.kURL_carFriends_home;;
            carDealerMoments.type = CarTradeViewTypeHome;
            [self.navigationController pushViewController:carDealerMoments animated:YES];
        }else if (indexPath.row==1) {
            //找车商
            CYTSeekCarDealerTableController *seekCarDealer = [CYTSeekCarDealerTableController new];
            [self.navigationController pushViewController:seekCarDealer animated:YES];
        }else if (indexPath.row==2) {
            //车商榜
            FFExtendViewModel *vm = [FFExtendViewModel new];
            vm.ffIndex = 0;
            CYTCarDealerChartController *carDealerChart = [[CYTCarDealerChartController alloc] initWithViewModel:vm];
            [self.navigationController pushViewController:carDealerChart animated:YES];
        }else if (indexPath.row==3) {
            //易车币商城
            CYTH5WithInteractiveCtr *mall = [[CYTH5WithInteractiveCtr alloc] initWithViewModel:NSStringFromUIEdgeInsets(UIEdgeInsetsZero)];
            mall.requestURL = kURL.KURL_mall_goodsList;
            mall.showIndicator = YES;
            [self.navigationController pushViewController:mall animated:YES];
        }
    }];
}

#pragma mark- method
///所有跳转方法进行权限验证
- (void)authenticateAlertWithBlock:(void(^)(void))block {
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:YES result:^(AccountState state) {
        if (state == AccountStateAuthenticationed) {
            if (block) {
                block();
            }
        }
    }];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
//        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.dznCustomViewModel.shouldDisplay = NO;
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTDiscoverCell identifier]]];
    }
    return _mainView;
}

- (CYTDiscoverVM* )viewModel {
    if (!_viewModel) {
        _viewModel = [CYTDiscoverVM new];
    }
    return _viewModel;
}

@end
