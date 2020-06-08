//
//  CYTArrivalDateVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTArrivalDateVC.h"
#import "CYTArrivalDateCell.h"

@interface CYTArrivalDateVC ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation CYTArrivalDateVC

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
        if (!responseModel.resultEffective) {
            [CYTToast errorToastWithMessage:responseModel.resultMessage];
        }
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = self.viewModel.listArray.count==0;
            model.dataHasMore = NO;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
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
    self.ffTitle = @"到港日期";
    self.ffNavigationView.bgImageView.backgroundColor = kTranslucenceColor;
}

#pragma mark- delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CYTArrivalDateModel *model = self.viewModel.listArray[section];
    
    UIView *header = [UIView new];
    header.backgroundColor = kFFColor_bg_nor;
    UILabel *label = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = model.month;
    [header addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header);
        make.top.bottom.equalTo(header);
    }];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(40);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CYTArrivalDateModel *model = self.viewModel.listArray[section];
    return model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTArrivalDateCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTArrivalDateCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CYTArrivalDateModel *model = self.viewModel.listArray[indexPath.section];
    CYTArrivalDateItemModel *itemModel = model.items[indexPath.row];
    cell.titleLab.text = itemModel.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTArrivalDateModel *model = self.viewModel.listArray[indexPath.section];
    CYTArrivalDateItemModel *itemModel = model.items[indexPath.row];
    itemModel.month = model.month;
    if (self.selectModelBlock) {
        self.selectModelBlock(itemModel);
    }
}

- (void)showView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTArrivalDateCell identifier]]];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTArrivalDateVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTArrivalDateVM new];
    }
    return _viewModel;
}

@end
