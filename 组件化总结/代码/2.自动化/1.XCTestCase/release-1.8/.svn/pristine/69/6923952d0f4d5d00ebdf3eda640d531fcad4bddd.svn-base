//
//  CYTOrderSenderCarInfo.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderSenderCarInfo.h"
#import "CYTOrderSendCarInfoCell.h"

@interface CYTOrderSenderCarInfo ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, strong) FFSectionHeadView_style0 *headView;

@end

@implementation CYTOrderSenderCarInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithBackButtonAndTitle:@"发车信息"];
    [self bindViewModel];
    [self loadUI];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.dataCount==0);
            model.dataHasMore = NO;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
        
        if (responseModel.resultEffective) {
            self.mainView.tableView.tableHeaderView = self.headView;
        }
    }];
}

- (void)loadUI {
    [self.view addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY);
    }];
}

#pragma mark- delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTOrderSendCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTOrderSendCarInfoCell identifier] forIndexPath:indexPath];
    NSString *content = [self.viewModel itemInfoWithIndex:indexPath.row];
    cell.flagLabel.text = self.viewModel.flagArray[indexPath.row];
    cell.contentLabel.text = content;
    return cell;
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
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTOrderSendCarInfoCell identifier]]];
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(100));
        
    }
    return _mainView;
}

- (CYTOrderSendCarInfoVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTOrderSendCarInfoVM new];
    }
    return _viewModel;
}

- (FFSectionHeadView_style0 *)headView {
    if (!_headView) {
        _headView = [FFSectionHeadView_style0 new];
        _headView.topOffset = CYTItemMarginV;
        _headView.ffMoreImageView.hidden = YES;
        _headView.ffMoreLabel.hidden = YES;
        _headView.ffServeNameLabel.text = @"发车信息：";
    }
    return _headView;
}

@end
