//
//  CYTMessageListTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMessageListTableController.h"
#import "CYTMessageListCell.h"

@interface CYTMessageListTableController ()
@property (nonatomic, strong) CYTMessageListCell *listCell;

@end

@implementation CYTMessageListTableController
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
    
    if (!self.listCell) {
        self.listCell = [self.mainView.tableView dequeueReusableCellWithIdentifier:[CYTMessageListCell identifier]];
    }
    
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.listArray.count ==0);
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
    self.ffTitle = self.viewModel.categoryModel.typeName;
    [self refreshData];
    self.interactivePopGestureEnable = NO;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
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
    ccModel.ffIdentifier = [CYTMessageListCell identifier];
    
    CYTMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    CYTMessageListModel *model = self.viewModel.listArray[indexPath.row];
    model.type = self.viewModel.categoryModel.type;
    cell.ffCustomizeCellModel = ccModel;
    cell.ffModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //将这条数据设置为灰色
    CYTMessageListModel *model = self.viewModel.listArray[indexPath.row];
    if (!model.isRead) {
        //没有阅读
        model.isRead = YES;
        [self.mainView.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        //网络请求
        self.viewModel.messageModel = model;
        self.viewModel.isAll = NO;
        [self.viewModel.sendStateCommand execute:nil];
    }
    
    //如果有链接则跳转
    [[CYTMessageCenterVM manager] handleMessageURL:model.url];
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
    if (self.backBlock) {
        self.backBlock(self.viewModel.categoryModel.type);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    //设置所有为已阅读
    self.viewModel.isAll = YES;
    self.viewModel.messageModel = (self.viewModel.listArray.count>0)?self.viewModel.listArray[0]:nil;
    [self.viewModel.sendStateCommand execute:nil];
}

- (void)refreshData {
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTMessageListCell identifier]]];
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTMessageListVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTMessageListVM new];
    }
    return _viewModel;
}

@end
