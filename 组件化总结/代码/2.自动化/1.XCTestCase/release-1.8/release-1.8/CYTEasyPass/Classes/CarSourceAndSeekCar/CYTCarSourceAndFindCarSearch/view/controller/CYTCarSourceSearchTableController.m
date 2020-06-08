//
//  CYTCarSourceSearchTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceSearchTableController.h"
#import "CYTCarSearchVM.h"
#import "CYTSeekCarDetailViewController.h"
#import "CYTCarSearchView.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"
#import "CYTCarSourceDetailTableController.h"
#import "CYTCarSourceSearchEmptyView.h"
#import "CYTCommonNetErrorView.h"
#import "CYTSeekCarNeedPublishViewController.h"
#import "CYTSourceAndFindCarSearchHistoryCell.h"
#import "CYTSourceAndFindCarSearchHeadView.h"
#import "CYTCarListInfoCell.h"
#import "CYTCarFilterTableController.h"

@interface CYTCarSourceSearchTableController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) CYTCarSearchView *searchBar;
@property (nonatomic, strong) CYTCarSearchVM *viewModel;
@property (nonatomic, strong) CYTSourceAndFindCarSearchHeadView *headView;

@end

@implementation CYTCarSourceSearchTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.searchBar];
    [self.ffContentView addSubview:self.mainView];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(CYTStatusBarHeight);
        make.height.equalTo(40);
    }];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.bottom.right.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.searchFinishedSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel setSearchResultBlock:^(FFBasicNetworkResponseModel *resultModel) {
        @strongify(self);
        //处理最后字符串被清空后的情况，如果此时数据返回来，则
        if (self.viewModel.type == SearchViewShowTypeHistory) {
            [CYTLoadingView hideLoadingView];
            [self.mainView.tableView reloadData];
        }else {
            self.mainView.tableView.tableHeaderView = nil;
            self.mainView.dznCustomViewModel.shouldDisplay = YES;
            
            [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
                FFMainViewModel *model = [FFMainViewModel new];
                model.dataEmpty = self.viewModel.listArray.count == 0;
                model.dataHasMore = NO;
                model.netEffective = resultModel.resultEffective;
                return model;
            }];
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod)];
    gesture.delegate = self;
    gesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gesture];
    
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
    return [self showingArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTSourceAndFindCarSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTSourceAndFindCarSearchHistoryCell identifier] forIndexPath:indexPath];
    CYTCarSearchAssociateModel *model = [self showingArray][indexPath.row];
    cell.contentLab.text = model.name;
    cell.arrowImageView.hidden = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CYTCarSearchAssociateModel *model = [self showingArray][indexPath.row];
    if (model) {
        //保存词语到本地，进入搜索结果页面
        [self searchWithModel:model];
    }
    
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[CYTSourceAndFindCarSearchHistoryCell class]] || [touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

///保存搜索数据，进入搜索结果页面
- (void)searchWithModel:(CYTCarSearchAssociateModel *)model {
    //车源搜索
    
    [self.viewModel addSearchHistoryWithModel:model];
    [self.view endEditing:YES];
    CYTCarFilterTableController *filterController = [CYTCarFilterTableController new];
    filterController.viewModel.source = CarViewSourceCarSource;
    filterController.viewModel.titleString = model.name;
    
    filterController.viewModel.requestModel.query = model.query;
    filterController.viewModel.requestModel.sourceTypeId = 1;
    
    filterController.viewModel.listRequestModel.query = model.query;
    filterController.viewModel.listRequestModel.keyword = model.name;
    filterController.viewModel.listRequestModel.source = 1;
    [self.navigationController pushViewController:filterController animated:YES];
}

- (NSArray *)showingArray {
    return (self.viewModel.type == SearchViewShowTypeAssociate)?self.viewModel.listArray:self.viewModel.historyList;
}

- (void)searchEmptyStringMethod {
    //显示搜索历史
    self.viewModel.type = SearchViewShowTypeHistory;
    self.mainView.dznCustomViewModel.shouldDisplay = NO;
    self.mainView.tableView.mj_footer.hidden = YES;
    self.mainView.tableView.tableHeaderView = (self.viewModel.historyList.count == 0)?nil:self.headView;
    [self.mainView.tableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mainView.tableView reloadData];
        [self.mainView.tableView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth, 1) animated:NO];
    });
}

- (void)tapMethod {
    [self.view endEditing:YES];
}

- (void)goSeekCarPublish {
    @weakify(self);
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
    [[CYTAuthManager manager] autoHandleAccountStateWithLocalState:NO result:^(AccountState state) {
        @strongify(self);
        [CYTLoadingView hideLoadingView];
        if (state == AccountStateAuthenticationed) {
            CYTSeekCarNeedPublishViewController *publish = [CYTSeekCarNeedPublishViewController new];
            publish.seekCarNeedPublishType = CYTSeekCarNeedPublishTypeDefault;
            publish.ffobj = @(1);
            [self.navigationController pushViewController:publish animated:YES];
        }
    }];
}

#pragma mark- get
- (CYTCarSearchVM *)viewModel {
    if (!_viewModel) {
        FFExtendModel *model = [FFExtendModel new];
        model.ffIndex = CarViewSourceCarSource;
        _viewModel = [[CYTCarSearchVM alloc] initWithModel:model];
    }
    return _viewModel;
}

- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTSourceAndFindCarSearchHistoryCell identifier]]];
        
        [CYTTools configForMainView:_mainView ];
        CYTCarSourceSearchEmptyView *emptyView = [CYTCarSourceSearchEmptyView new];
        @weakify(self);
        [emptyView setDznReloadBlock:^{
            @strongify(self);
            [self goSeekCarPublish];
        }];
        _mainView.dznCustomView.emptyView = emptyView;
        
    }
    return _mainView;
}

- (CYTCarSearchView *)searchBar {
    if (!_searchBar) {
        _searchBar = [CYTCarSearchView new];
        _searchBar.userInteractionEnabled = YES;
        
        @weakify(self);
        [_searchBar setBackBlock:^{
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        //搜索词（点击cell或者点击“搜索”）
        //只有搜索结果可以有这个操作，因为显示搜索历史时候，textfiled.text是空，搜索按钮无效。
        [_searchBar setSearchItemBlock:^(NSString *string) {
            @strongify(self);
            //如果有联想结果则进行搜索，否则无任何操作，显示-发寻车-ui，点击后进入寻车发布
            if (self.viewModel.listArray.count>0) {
                [self searchWithModel:self.viewModel.listArray[0]];
            }
        }];
        
        //搜索联想
        [_searchBar setAssociationBlock:^(NSString *string,UITextField *textField) {
            @strongify(self);
            //限制搜索联想频率
            //1、高亮中文不搜索
            NSString * inputText = [textField textInRange:[textField markedTextRange]];
            if(inputText.length>0){
                return;
            }
            
            //获取到字符后操作
            self.viewModel.type = SearchViewShowTypeAssociate;
            self.viewModel.nowString = string;
            //            self.viewModel.searchString = string;
            //延时0.3s字符不变，则搜索
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //如果字符串没有发生变化则进行联想搜索
                if ([string isEqualToString:self.viewModel.nowString]) {
                    CYTLog(@"-- 搜索联想 --%@",string);
                    self.viewModel.searchString = string;
                }
            });
        }];
        
        //搜索字符为空，显示搜索历史
        [_searchBar setBeginBlock:^{
            @strongify(self);
            [self searchEmptyStringMethod];
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
            //删除数据，然后更新UI
            [self.viewModel clearHistoryData];
            [self.mainView.tableView reloadData];
            self.mainView.tableView.tableHeaderView = nil;
        }];
        _headView.size = CGSizeMake(kScreenWidth, CYTAutoLayoutV(60));
    }
    return _headView;
}

@end
