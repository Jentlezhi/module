//
//  CYTCarSourceTypeViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceTypeViewController.h"
#import "CYTCarSourceTypeCell.h"

@interface CYTCarSourceTypeViewController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation CYTCarSourceTypeViewController

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.mainView.tableView reloadData];
        if (!responseModel.resultEffective) {
            [CYTToast errorToastWithMessage:responseModel.resultMessage];
        }
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"车源类型";
    self.ffNavigationView.bgImageView.backgroundColor = kTranslucenceColor;
}

- (void)showView {
    //判断是否有数据，没有则请求
    if (self.viewModel.listArray.count == 0) {
        [self.viewModel.requestCommand execute:nil];
    }
    [self.mainView.tableView reloadData];
}

#pragma mark- get
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0)?(0.01):10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.viewModel.listArray[section];
    if ([array isKindOfClass:[NSArray class]]) {
        return array.count;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTCarSourceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTCarSourceTypeCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = self.viewModel.listArray[indexPath.section];
    CYTCarSourceTypeModel *model = array[indexPath.row];
    cell.titleLab.text = model.carSourceTypeName;
    UIColor *color = kFFColor_title_L2;
    if ([self.indexPath isEqual:indexPath]) {
        color = kFFColor_green;
    }
    cell.titleLab.textColor = color;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.viewModel.listArray[indexPath.section];
    CYTCarSourceTypeModel *model = array[indexPath.row];
    model.indexPath = indexPath;
    
    if (self.selectBlock) {
        self.selectBlock(model);
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        _mainView.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTCarSourceTypeCell identifier]]];
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTCarSourceTypeVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarSourceTypeVM new];
        _viewModel.parallelImportCar = self.parallelImportCar;
    }
    return _viewModel;
}

@end
