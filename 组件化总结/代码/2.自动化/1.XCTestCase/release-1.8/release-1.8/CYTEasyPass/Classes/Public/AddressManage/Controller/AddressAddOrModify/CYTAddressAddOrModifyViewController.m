//
//  CYTAddressAddOrModifyViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressAddOrModifyViewController.h"
#import "CYTAddressAddOrModifyChooseCell.h"
#import "CYTAddressAddOrModifyDetailCell.h"
#import "CYTAddressDataWNCManager.h"
#import "CYTAddressChooseCommonVC.h"

@interface CYTAddressAddOrModifyViewController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, strong) CYTAddressDataWNCManager *addressModel;

@end

@implementation CYTAddressAddOrModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = (self.viewModel.addressAdd)?@"新增地址":@"修改地址";
    [self createNavBarWithTitle:title andShowBackButton:YES showRightButtonWithTitle:@"保存"];
    [self bindViewModel];
    [self loadUI];
}

- (void)loadUI {
    [self.view addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY);
    }];
}

- (void)bindViewModel {
    @weakify(self);

    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] ==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else{
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [CYTToast messageToastWithMessage:responseModel.resultMessage];
        if (responseModel.resultEffective) {
            if (self.refreshBlock) {
                self.refreshBlock(self.viewModel);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)rightButtonClick:(UIButton *)rightButton {
    //验证数据是否填写
    if (self.viewModel.chooseContent.length == 0) {
        [CYTToast messageToastWithMessage:@"请选择省市区"];
        return;
    }
    if (self.viewModel.detailContent.length == 0) {
        [CYTToast messageToastWithMessage:@"请填写详细地址"];
        return;
    }
    
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CYTAddressAddOrModifyChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTAddressAddOrModifyChooseCell identifier] forIndexPath:indexPath];
        cell.contentLabel.text = self.viewModel.chooseContent;
        return cell;
    }else {
        CYTAddressAddOrModifyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTAddressAddOrModifyDetailCell identifier] forIndexPath:indexPath];
        cell.textView.text = self.viewModel.detailContent;
        
        @weakify(self);
        [cell setTextBlock:^(NSString *string) {
            @strongify(self);
            self.viewModel.addressModel.addressDetail = string;
            
        }];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        CYTAddressDataWNCManager *vm;
        if (self.addressModel) {
            vm = self.addressModel;
        }else {
            vm =[CYTAddressDataWNCManager shareManager];
            [vm cleanAllModelCache];
            vm.showArea = NO;
            vm.titleString = @"城市选择";
            vm.type = AddressChooseTypeCounty;
            if (self.viewModel.addressModel) {
                //如果是修改
                vm.addressModel.oriCountyId = -1;
                vm.addressModel.oriProvinceId = [self.viewModel.addressModel.provinceId integerValue];
                vm.addressModel.oriCityId = [self.viewModel.addressModel.cityId integerValue];
                vm.addressModel.oriCountyId = self.viewModel.addressModel.countyId;
            }
        }
        
        CYTAddressChooseCommonVC *choose = [CYTAddressChooseCommonVC new];
        choose.viewModel = vm;
        [choose setChooseFinishedBlock:^(CYTAddressDataWNCManager *model) {
            //回显使用
            self.addressModel = model;
            //处理回调数据
            CYTAddressModel *addressModel = self.viewModel.addressModel;
            addressModel.provinceId = [NSString stringWithFormat:@"%ld",(long)model.addressModel.selectProvinceModel.idCode];
            addressModel.provinceName = model.addressModel.selectProvinceModel.name;
            addressModel.cityId = [NSString stringWithFormat:@"%ld",model.addressModel.selectCityModel.idCode];
            addressModel.cityName = model.addressModel.selectCityModel.name;
            if (model.addressModel.selectCountyModel) {
                addressModel.countyId = model.addressModel.selectCountyModel.idCode;
                addressModel.countyName = model.addressModel.selectCountyModel.name;
            }else {
                addressModel.countyId = -1;
                addressModel.countyName = @"";
            }
            
            self.viewModel.addressModel = addressModel;
            [self.mainView.tableView reloadData];
            
        }];
        [self.navigationController pushViewController:choose animated:YES];
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTAddressAddOrModifyChooseCell identifier],
                                                [CYTAddressAddOrModifyDetailCell identifier]]];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}


- (CYTAddressAddOrModifyVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTAddressAddOrModifyVM new];
        _viewModel.addressModel = [CYTAddressModel new];
    }
    return _viewModel;
}

@end
