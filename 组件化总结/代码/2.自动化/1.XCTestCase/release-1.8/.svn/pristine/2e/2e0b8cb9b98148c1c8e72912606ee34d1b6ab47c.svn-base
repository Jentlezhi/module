//
//  CYTBrandSelect_carsTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelect_carsTableController.h"
#import "CYTBrandSelect_carCell.h"
#import "CYTBrandSelect_customCars.h"
#import "CYTBrandSelectCarGroupModel.h"

@interface CYTBrandSelect_carsTableController ()
///lastSelectCell
@property (nonatomic, strong) CYTBrandSelect_carCell *lastSelectCell;

@end

@implementation CYTBrandSelect_carsTableController
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
            model.dataEmpty = self.viewModel.listArray.count == 0;
            model.dataHasMore = NO;
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
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    self.ffTitle = [NSString stringWithFormat:@"%@ %@",self.viewModel.brandName,self.viewModel.seriesName];
    self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L2;
    [self.ffNavigationView showRightItemWithTitle:@"自定义车型"];
    FFNavigationItemView *item = self.ffNavigationView.contentView.titleView;
    [self.ffNavigationView.contentView updateView:item width:CYTAutoLayoutH(300)];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:NO];
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.listArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = kFFColor_bg_nor;
    UILabel *titleLabel = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L3];
    CYTBrandSelectCarGroupModel *group = self.viewModel.listArray[section];
    titleLabel.text = group.groupName;
    [header addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(header);
        make.left.equalTo(CYTMarginH);
    }];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(40);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CYTBrandSelectCarGroupModel *group = self.viewModel.listArray[section];
    return group.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTBrandSelect_carCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTBrandSelect_carCell identifier] forIndexPath:indexPath];
    CYTBrandSelectCarGroupModel *group = self.viewModel.listArray[indexPath.section];
    CYTBrandSelectCarModel *model = group.cars[indexPath.row];
    cell.contentLabel.text = model.carName;
    NSString *price = model.carReferPrice;
    if ([price isEqualToString:@"0"] || [price isEqualToString:@""]) {
        price = @"";
    }else {
        price = [NSString stringWithFormat:@"%@万元",price];
    }
    cell.assistantLabel.text = price;
    cell.highlightedCell = (model.carId == self.viewModel.lastCarId);
    if (model.carId == self.viewModel.lastCarId) {
        self.lastSelectCell = cell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CYTBrandSelectCarGroupModel *group = self.viewModel.listArray[indexPath.section];
    CYTBrandSelectCarModel *model = group.cars[indexPath.row];
    //高亮
    if (self.lastSelectCell) {
        self.lastSelectCell.highlightedCell = NO;
    }
    CYTBrandSelect_carCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.highlightedCell = YES;
    self.lastSelectCell = cell;
    
    //拼接年款
    model.carName = [NSString stringWithFormat:@"%@%@",group.groupName,model.carName];
    if (self.carBlock) {
        self.carBlock(model);
    }
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    CYTBrandSelect_customCars *customCar = [CYTBrandSelect_customCars new];
    customCar.titleName = [NSString stringWithFormat:@"%@ %@",self.viewModel.brandName,self.viewModel.seriesName];
    
    [customCar setStringBlock:^(NSString *string) {
        //自定义车款名称
        CYTBrandSelectCarModel *model = [CYTBrandSelectCarModel new];
        model.carName = string;
        model.carId = -1;
        model.carReferPrice = @"0";
        model.isParallelImportCar = self.viewModel.isParallelImportCar;
        model.type = self.viewModel.type;
        model.typeName = self.viewModel.typeName;
        if (self.carBlock) {
            self.carBlock(model);
        }
    }];
    [self.navigationController pushViewController:customCar animated:YES];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTBrandSelect_carCell identifier]]];
    }
    return _mainView;
}

- (CYTBrandSelect_carVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTBrandSelect_carVM new];
    }
    return _viewModel;
}

@end
