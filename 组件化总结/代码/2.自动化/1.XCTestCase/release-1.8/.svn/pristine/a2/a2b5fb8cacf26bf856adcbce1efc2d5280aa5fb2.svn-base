//
//  CYTAddressChooseCommonVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressChooseCommonVC.h"
#import "CYTAddressChooseCell.h"
#import "CYTAddressCityChooseCommonVC.h"
#import "CYTAddressConst.h"
#import "CYTAddressChooseHeaderView.h"
#import "CYTAddressAreaReaviewView2.h"

@interface CYTAddressChooseCommonVC ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, strong) CYTAddressChooseHeaderView *headerView;
@property (nonatomic, strong) CYTAddressAreaReaviewView2 *areaView;

@end

@implementation CYTAddressChooseCommonVC

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [RACObserve(self,self.viewModel.showArea) subscribeNext:^(id x) {
        @strongify(self);
        BOOL show = [x boolValue];
        if (!show) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headerView.needArea = NO;
                self.headerView.size = CGSizeMake(kScreenWidth, CYTAutoLayoutV(100));
                self.mainView.tableView.tableHeaderView = self.headerView;
            });
        }
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    self.ffTitle = self.viewModel.titleString;
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    //正确
    [self.view addSubview:self.areaView];
    [self.areaView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseFinished) name:kCommonChooseAddressFinished object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)chooseFinished {
    //赋值方式不要随意修改！
    NSDictionary *addressDic = self.viewModel.addressModel.mj_keyValues;
    CYTAddressDataWNCModel *address = [CYTAddressDataWNCModel mj_objectWithKeyValues:addressDic];
    
    CYTAddressDataWNCManager *model = [CYTAddressDataWNCManager new];
    model.type = self.viewModel.type;
    model.titleString = self.viewModel.titleString;
    model.showArea = self.viewModel.showArea;
    
    model.areaModel = self.viewModel.areaModel;
    model.areaListArray = self.viewModel.areaListArray;
    model.provinceModel = self.viewModel.provinceModel;
    model.provinceListArray = self.viewModel.provinceListArray;
    model.plCityModel = self.viewModel.plCityModel;
    model.plCityListArray = self.viewModel.plCityListArray;
    
    model.addressModel = address;
    

    if (self.chooseFinishedBlock) {
        self.chooseFinishedBlock(model);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark- delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L2];
    label.backgroundColor = kFFColor_bg_nor;
    label.textAlignment = NSTextAlignmentCenter;
    [header addSubview:label];
    UIView *line = [UIView new];
    line.backgroundColor = kFFColor_line;
    [header addSubview:line];
    
    [label radius:(CYTAutoLayoutV(38/2.0)) borderWidth:1 borderColor:kFFColor_line];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(CYTAutoLayoutH(100));
        make.height.equalTo(CYTAutoLayoutV(38));
        make.centerY.equalTo(header);
        make.left.equalTo(CYTAutoLayoutH(30));
    }];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo((-CYTMarginH));
        make.bottom.equalTo(0);
        make.height.equalTo(CYTLineH);
    }];
    
    label.text = [self.viewModel sectionTitleWithIndex:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0)?self.viewModel.plCityListArray.count:self.viewModel.provinceListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CYTAddressDataProvinceModel *provinceModel = (indexPath.section == 0)?self.viewModel.plCityModel:self.viewModel.provinceModel;
    CYTAddressDataItemModel *itemModel = provinceModel.provinces[indexPath.row];
    CYTAddressChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTAddressChooseCell identifier] forIndexPath:indexPath];
    cell.titleLab.text = itemModel.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((self.viewModel.addressModel.oriProvinceId == itemModel.idCode) && self.viewModel.addressModel.oriProvinceId != 0) {
        cell.titleLab.textColor = kFFColor_green;
    }else {
        cell.titleLab.textColor = kFFColor_title_L2;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectIndexPath:indexPath];
}

- (void)selectIndexPath:(NSIndexPath *)indexPath {
    //清空选择记录
//    [self.viewModel cleanChooseModel];不要动
    
    //0-直辖市，1-其他省份
    CYTAddressDataItemModel *provinceModel = (indexPath.section==0)?self.viewModel.plCityListArray[indexPath.row]:self.viewModel.provinceListArray[indexPath.row];
    self.viewModel.addressModel.selectProvinceModel = provinceModel;
    self.viewModel.addressModel.oriProvinceId = self.viewModel.addressModel.selectProvinceModel.idCode;
    
    //判断选择模式
    if (self.viewModel.type == AddressChooseTypeProvince) {
        //选择省
        [self chooseFinished];
    }else if (self.viewModel.type == AddressChooseTypeCity) {
        //选择城市
        if (indexPath.section == 0) {
            //直辖市
            self.viewModel.addressModel.selectCityModel = [self.viewModel cityModelWithProvinceModel:self.viewModel.addressModel.selectProvinceModel andIndex:0];
            self.viewModel.addressModel.oriCityId = self.viewModel.addressModel.selectCityModel.idCode;
            [self chooseFinished];
        }else {
            //其他省份
            [self.mainView.tableView reloadData];
            [self showCityChooseView];
        }
    }else if (self.viewModel.type == AddressChooseTypeCounty) {
        //选择区县
        [self.mainView.tableView reloadData];
        [self showCityChooseView];
    }
}

- (void)showCityChooseView {
    self.sideView.topOffset = 0;
    CYTAddressCityChooseCommonVC *cityChoose = [CYTAddressCityChooseCommonVC new];
    @weakify(self);
    [cityChoose setWilDismissBlock:^{
        @strongify(self);
        [self.sideView hideHalfView];
        [CYTAddressDataWNCManager shareManager].addressModel.selectCityModel = nil;
    }];
    
    cityChoose.viewModel = self.viewModel;
    self.sideView.contentController = cityChoose;
    
    [self addChildViewController:cityChoose];
    [self.sideView showHalfView];
}

#pragma mark- cell 点击方法
- (void)selectIndex:(NSInteger)index areaId:(NSInteger)areaId{
    [self.viewModel cleanChooseModel];
    self.viewModel.addressModel.selectProvinceModel = self.viewModel.areaListArray[index];
    self.viewModel.addressModel.oriAreaId = areaId;
    [self chooseFinished];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTAddressChooseCell identifier]]];
        [CYTTools configForMainView:_mainView ];
        
        self.headerView.size = CGSizeMake(kScreenWidth, CYTAutoLayoutV(300));
        _mainView.tableView.tableHeaderView = self.headerView;
    }
    return _mainView;
}

- (CYTAddressDataWNCManager *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTAddressDataWNCManager shareManager];
    }
    return _viewModel;
}

- (CYTAddressAreaReaviewView2 *)areaView {
    if (!_areaView) {
        _areaView = [CYTAddressAreaReaviewView2 new];
    }
    return _areaView;
}

- (CYTAddressChooseHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [CYTAddressChooseHeaderView new];
        _headerView.index = self.viewModel.addressModel.oriAreaId;
        @weakify(self);
        [_headerView setAreaBlock:^(NSInteger index ,NSInteger areaId) {
            @strongify(self);
            [self selectIndex:index areaId:areaId];
        }];
        [_headerView setReaviewBlock:^{
            @strongify(self);
            [self.areaView show];
        }];
    }
    return _headerView;
}

@end
