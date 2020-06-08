//
//  CYTSeekCarDealerTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDealerTableController.h"
#import "CYTCarSearchView.h"
#import "CYTSourceAndFindCarSearchHistoryCell.h"
#import "CYTSeekCarDealerCell.h"
#import "CYTDealerHisHomeTableController.h"
#import "CYTDealerMeHomeTableController.h"
#import "CYTSourceAndFindCarSearchHeadView.h"

@interface CYTSeekCarDealerTableController ()
@property (nonatomic, strong) CYTCarSearchView *searchBar;
@property (nonatomic, strong) CYTSourceAndFindCarSearchHeadView *headView;

@end

@implementation CYTSeekCarDealerTableController
@synthesize mainView = _mainView;
@synthesize showNavigationView = _showNavigationView;

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    self.ffContentView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.mainView];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTStatusBarHeight);
        make.height.equalTo(40);
    }];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue]==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        self.mainView.dznCustomViewModel.shouldDisplay = YES;
        self.viewModel.type = SeekCarDealerTypeResult;
        self.mainView.tableView.tableHeaderView = nil;
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = self.viewModel.listArray.count;
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
    [self.searchBar.searchTextFiled becomeFirstResponder];
}

//不处理iqkeyboard的完成事件---------->>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}
//<<<<----------------------------------

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.viewModel.type==SeekCarDealerTypeHistory)?self.viewModel.historyList.count:self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
    ccModel.ffIndexPath = indexPath;
    ccModel.ffIdentifier = (self.viewModel.type==SeekCarDealerTypeResult)?[CYTSeekCarDealerCell identifier]:[CYTSourceAndFindCarSearchHistoryCell identifier];
    
    FFExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    cell.ffCustomizeCellModel = ccModel;
    if (self.viewModel.type==SeekCarDealerTypeResult) {
        cell.ffModel = self.viewModel.listArray[indexPath.row];
    }else {
        cell.ffModel = self.viewModel.historyList[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.viewModel.type==SeekCarDealerTypeHistory) {
        //点击历史,使用该字符进行搜索
        NSString *string = self.viewModel.historyList[indexPath.row];
        self.searchBar.searchTextFiled.text = string;
        self.viewModel.searchString = string;
        self.viewModel.lastId = -1;
        [self.viewModel.requestCommand execute:nil];
        [self.view endEditing:YES];
    }else {
        //点击车商,进入车商主页
        CYTDealer *model = self.viewModel.listArray[indexPath.row];
        NSString *userId = [NSString stringWithFormat:@"%ld",model.userId];
        if ([userId isEqualToString:CYTUserId]) {
            //我的车商
            CYTDealerMeHomeTableController *meHome = [CYTDealerMeHomeTableController new];
            meHome.viewModel.userId = userId;
            [self.navigationController pushViewController:meHome animated:YES];
        }else {
            //他的车商
            CYTDealerHisHomeTableController *hisHome = [CYTDealerHisHomeTableController new];
            hisHome.viewModel.userId = userId;
            [self.navigationController pushViewController:hisHome animated:YES];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    self.viewModel.lastId = -1;
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
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
        _mainView.dznCustomView.emptyView.dznLabel.text = @"- 抱歉，暂无符合条件的结果 -";
        _mainView.mjrefreshSupport = MJRefreshSupportLoadMore;
        [_mainView registerCellWithIdentifier:@[[CYTSourceAndFindCarSearchHistoryCell identifier],
                                                [CYTSeekCarDealerCell identifier]]];
    }
    return _mainView;
}

- (CYTCarSearchView *)searchBar {
    if (!_searchBar) {
        _searchBar = [CYTCarSearchView new];
        _searchBar.userInteractionEnabled = YES;
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.searchPlaceholder = @"搜索营业执照中的公司名称/用户认证姓名";
        
        @weakify(self);
        [_searchBar setBackBlock:^{
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        //搜索词（点击cell或者点击“搜索”）
        [_searchBar setSearchItemBlock:^(NSString *string) {
            @strongify(self);
            CYTLog(@"进行搜索");
            if (string.length==0) {
                return ;
            }
            self.viewModel.searchString = string;
            self.viewModel.lastId = -1;
            [self.viewModel.requestCommand execute:nil];
            [self.view endEditing:YES];
        }];
        
        //搜索字符为空，显示搜索历史
        [_searchBar setBeginBlock:^{
            @strongify(self);
            CYTLog(@"显示搜索历史");
            self.viewModel.type = SeekCarDealerTypeHistory;
            self.mainView.dznCustomViewModel.shouldDisplay = NO;
            self.mainView.tableView.tableHeaderView = (self.viewModel.historyList.count == 0)?nil:self.headView;
            [self.mainView.tableView reloadData];
        }];
    }
    return _searchBar;
}

- (CYTSourceAndFindCarSearchHeadView *)headView {
    if (!_headView) {
        _headView = [CYTSourceAndFindCarSearchHeadView new];
        @weakify(self);
        [_headView setClearBlock:^{
            @strongify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
                    if ([x integerValue]==1) {
                        //删除数据，然后更新UI
                        [self.viewModel clearHistoryData];
                        [self.mainView.tableView reloadData];
                        self.mainView.tableView.tableHeaderView = nil;
                    }
                }];
                [alert show];
            });
        }];
        _headView.size = CGSizeMake(kScreenWidth, CYTAutoLayoutV(60));
    }
    return _headView;
}

- (CYTSeekCarDealerVM* )viewModel {
    if (!_viewModel) {
        _viewModel = [CYTSeekCarDealerVM new];
    }
    return _viewModel;
}

@end
