//
//  CYTBrandSelectViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelectViewController.h"
#import "CYTBrandSelectCell.h"
#import "MJNIndexView.h"
#import "CYTBrandSelect_Series.h"
#import "CYTBrandSelect_carsTableController.h"
#import "CYTBrandSelectSubbrandModel.h"
#import "CYTBrandSelectSeriesModel.h"
#import "CYTBrandGroupModel.h"

@interface CYTBrandSelectViewController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate,MJNIndexViewDataSource>
@property (nonatomic, strong) FFMainView *mainView;
///索引
@property (nonatomic, strong) MJNIndexView *indexView;
///车系
@property (nonatomic, strong) CYTBrandSelect_Series *seriesController;
///lastSelectCell
@property (nonatomic, strong) CYTBrandSelectCell *lastSelectCell;

@end

@implementation CYTBrandSelectViewController

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.getSelectedBrandModelFinishedSubject subscribeNext:^(NSIndexPath *indexPath) {
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (indexPath) {
                [self.mainView.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                [self tableView:self.mainView.tableView didSelectRowAtIndexPath:indexPath];
            }
        });
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.ffContentView addSubview:self.indexView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.ffTitle = @"品牌";
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:NO];
    
    //刷新indexView
    [self.indexView refreshIndexItems];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewModel handleSelectedBrand];
    });
}

- (void)handleBrandData {
    if (self.viewModel.needBack) {
        if (self.ffobj) {
            [self.navigationController popToViewController:self.ffobj animated:YES];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

    if (self.brandSelectBlock) {
        self.brandSelectBlock(self.viewModel.brandResultModel);
    }
}

- (void)chooseBrandModel:(CYTBrandSelectModel *)model {
    self.viewModel.mainBrandModel = model;
    self.viewModel.brandResultModel.inBrandId = model.masterBrandId;
    
    self.sideView.contentController = self.seriesController;
    self.seriesController.seriesArray = [model.makes copy];
    self.seriesController.brandResultModel = self.viewModel.brandResultModel;
    [self showSideView];
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.brandCacheArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CYTBrandGroupModel *sectionModel = self.viewModel.brandCacheArray[section];
    return sectionModel.masterBrands.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = kFFColor_bg_nor;
    UILabel *title = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L3];
    CYTBrandGroupModel *sectionModel = self.viewModel.brandCacheArray[section];
    NSString *key = sectionModel.groupName;
    title.text = key;
    [header addSubview:title];
    [title makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.centerY.equalTo(header);
    }];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTBrandSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTBrandSelectCell identifier] forIndexPath:indexPath];
    CYTBrandGroupModel *sectionModel = self.viewModel.brandCacheArray[indexPath.section];
    NSArray *sectionArray = sectionModel.masterBrands;
    CYTBrandSelectModel *model = sectionArray[indexPath.row];
    cell.model = model;
    
    cell.highlightedCell = (model.masterBrandId == self.viewModel.brandResultModel.inBrandId);
    if (model.masterBrandId == self.viewModel.brandResultModel.inBrandId) {
        self.lastSelectCell = cell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CYTBrandGroupModel *sectionModel = self.viewModel.brandCacheArray[indexPath.section];
    NSArray *sectionArray = sectionModel.masterBrands;
    CYTBrandSelectModel *model = sectionArray[indexPath.row];
    [self chooseBrandModel:model];
    //改变高亮
    if (self.lastSelectCell) {
        self.lastSelectCell.highlightedCell = NO;
    }
    CYTBrandSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.highlightedCell = YES;
    self.lastSelectCell = cell;
}

#pragma mark- mjindex
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView{
    return self.viewModel.groupNameArray;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index;{
    if ([self.mainView.tableView numberOfSections] > index && index > -1){
        [self.mainView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                                        atScrollPosition:UITableViewScrollPositionTop
                                                animated:YES];
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTBrandSelectCell identifier]]];
        _mainView.tableView.scrollsToTop = NO;
    }
    return _mainView;
}

- (MJNIndexView *)indexView {
    if (!_indexView) {
        _indexView = [[MJNIndexView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _indexView.dataSource = self;
        _indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
        _indexView.font = CYTFontWithPixel(24);
        _indexView.selectedItemFont = CYTBoldFontWithPixel(60);
        _indexView.backgroundColor = [UIColor clearColor];
        _indexView.curtainColor = nil;
        _indexView.curtainFade = 0.0;
        _indexView.curtainStays = NO;
        _indexView.curtainMoves = YES;
        _indexView.curtainMargins = NO;
        _indexView.ergonomicHeight = YES;
        _indexView.upperMargin = 15.0;
        _indexView.lowerMargin = 15.0;
        _indexView.rightMargin = CYTAutoLayoutH(10);
        _indexView.itemsAligment = NSTextAlignmentCenter;
        _indexView.maxItemDeflection = 75;
        _indexView.minimumGapBetweenItems = 10;
        _indexView.rangeOfDeflection = 3;
        _indexView.fontColor = CYTHexColor(@"#999999");
        _indexView.selectedItemFontColor = CYTHexColor(@"#2cb73f");
        _indexView.darkening = NO;
        _indexView.fading = YES;
    }
    return _indexView;
}

- (CYTBrandSelect_Series *)seriesController {
    if (!_seriesController) {
        _seriesController = [CYTBrandSelect_Series new];
        @weakify(self);
        [_seriesController setClickedBlock:^(NSIndexPath *indexPath) {
            @strongify(self);
            
            //发消息
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateFrequentlyBrandKey object:self.viewModel.mainBrandModel];
            //整理品牌数据
            NSArray *subBrandArray = self.viewModel.mainBrandModel.makes;
            CYTBrandSelectSubbrandModel *subbrandModel = subBrandArray[indexPath.section];
            CYTBrandSelectSeriesModel *seriesModel = subbrandModel.models[indexPath.row];
            
            CYTBrandSelectResultModel *resultModel = (self.viewModel.brandResultModel)?(self.viewModel.brandResultModel):[CYTBrandSelectResultModel new];
            resultModel.subBrandId = subbrandModel.makeId;
            resultModel.subBrandName = subbrandModel.makeName;
            resultModel.seriesModel = seriesModel;
            self.viewModel.brandResultModel = resultModel;
            
            if (self.viewModel.type == CYTBrandSelectTypeSeries) {
                //返回车系数据
                //获取数据完毕
                [self handleBrandData];
            }else {
                //进入车型页面
                CYTBrandSelect_carsTableController *cars = [CYTBrandSelect_carsTableController new];
                cars.viewModel.brandName = resultModel.subBrandName;
                cars.viewModel.seriesName = resultModel.seriesModel.serialName;
                cars.viewModel.isParallelImportCar = resultModel.seriesModel.isParallelImportCar;
                cars.viewModel.type = resultModel.seriesModel.type;
                cars.viewModel.typeName = resultModel.seriesModel.typeName;
                cars.viewModel.seriesId = resultModel.seriesModel.serialId;
                cars.viewModel.lastCarId = resultModel.carModel.carId;
                
                @weakify(self);
                [cars setCarBlock:^(CYTBrandSelectCarModel *carModel) {
                    @strongify(self);
                    self.viewModel.brandResultModel.carModel = carModel;
                    //获取数据完毕
                    [self handleBrandData];
                }];
                
                [self.navigationController pushViewController:cars animated:YES];
            }
        }];
    }
    return _seriesController;
}

- (CYTBrandSelectVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTBrandSelectVM new];
    }
    return _viewModel;
}

@end
