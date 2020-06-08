//
//  CYTPublishProcedureVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPublishProcedureVC.h"
#import "CYTPublishProcedureCell.h"
#import "CYTPublishProcedureCustomVC.h"

@interface CYTPublishProcedureVC ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, assign) NSInteger indexValue;

@end

@implementation CYTPublishProcedureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    [self loadUI];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

- (void)bindViewModel {
    self.indexValue = -1;
    
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] ==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];

    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = NO;
            model.dataHasMore = NO;
            model.netEffective = NO;
            return model;
        }];
        
    }];
}

- (void)loadUI {
    [self createNavBarWithBackButtonAndTitle:@"选择手续"];
    [self.view addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY);
    }];
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.sectionNumber == 1) {
        return 1;
    }
    return (section == 0)?self.viewModel.listArray.count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(20);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTPublishProcedureCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTPublishProcedureCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = [self.viewModel titleWithIndex:indexPath];
    UIColor *textColor = kFFColor_title_L1;
    if (self.viewModel.sectionNumber == 2 && indexPath.section == 0 && [self.viewModel.content isEqualToString:cell.titleLab.text]) {
        textColor = kFFColor_green;
        self.indexValue = indexPath.row;
    }
    cell.arrowImageView.hidden = (indexPath.section == 0);
    cell.titleLab.textColor = textColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.viewModel.sectionNumber == 1) {
            //只有一个分区
            [self goCustomProcedure];
        }else {
            //两个分区
            NSDictionary *dic = self.viewModel.listArray[indexPath.row];
            [self returnProcedure:dic[@"name"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        //自定义
        [self goCustomProcedure];
    }
}

- (void)goCustomProcedure {
    CYTPublishProcedureCustomVC *custom = [CYTPublishProcedureCustomVC new];
    custom.content = (self.indexValue == -1)?self.viewModel.content:@"";
    
    @weakify(self);
    [custom setProcedureBlock:^(NSString *string) {
        @strongify(self);
        self.viewModel.content = string;
        [self returnProcedure:string];
    }];
    [self.navigationController pushViewController:custom animated:YES];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)returnProcedure:(NSString *)procedure {
    if (self.procedureBlock) {
        self.procedureBlock(procedure);
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        _mainView.dznCustomViewModel.shouldDisplay = NO;
        [_mainView registerCellWithIdentifier:@[[CYTPublishProcedureCell identifier]]];
    }
    return _mainView;
}

- (CYTPublishProcedureVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTPublishProcedureVM new];
    }
    return _viewModel;
}

@end
