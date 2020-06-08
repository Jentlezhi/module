//
//  CYTConfirmSendCarViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTConfirmSendCarViewController.h"
#import "CYTOrderExtendSectionModel.h"
#import "CYTConfirmSendCarModel.h"
#import "CYTOrderManagerSectionHeader.h"
#import "CYTCarConfirmListCell.h"
#import "CYTVouchersCell.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTNoDataView.h"
#import "CYTSendCarConfirmedModel.h"
#import "CYTAddressListViewController.h"
#import "CYTCarContactsViewController.h"
#import "CYTAddressModel.h"
#import "CYTCarContactsModel.h"
#import "CYTVehicleToolsViewController.h"
#import "CYTVehicleToolsModel.h"
#import "CYTPublishRemarkVC.h"
#import "CYTOrderExtendViewController.h"
#import "CYTConfirmSendCarPar.h"
#import "CYTIndicatorView.h"
#import "CYTImageAssetManager.h"
#import "CYTSelectImageModel.h"

static const CGFloat bottomBtnHeight = 98.f;

@interface CYTConfirmSendCarViewController ()

/** 数据 */
@property(strong, nonatomic) NSArray *confirmSendCarData;
/** 数据模型 */
@property(strong, nonatomic) CYTSendCarConfirmedModel *sendCarConfirmedModel;
/** 已选地址模型 */
@property(strong, nonatomic) CYTAddressModel *selectAddressModel;
/** 已填写备注 */
@property(copy, nonatomic) NSString *remark;
/** 发车参数 */
@property(strong, nonatomic) CYTConfirmSendCarPar *confirmSendCarPar;
/** 已选中的图片 */
@property(strong, nonatomic) NSMutableArray<CYTSelectImageModel *> *selectedImageModels;

@end

@implementation CYTConfirmSendCarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self confirmSendCarBasicConfig];
    [self configConfirmSendCarTableView];
    [self initConfirmSendCarComponents];
    [self requestConfirmSendCarData];
}
/**
 *  解析数据
 */
- (NSArray *)confirmSendCarData{
    if (!_confirmSendCarData) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"sellerConfirmSendCar.plist" ofType:nil];
        NSArray *plistData = [NSArray arrayWithContentsOfFile:plistPath];
        _confirmSendCarData = [CYTOrderExtendSectionModel mj_objectArrayWithKeyValuesArray:plistData];
    }
    return _confirmSendCarData;
}
/**
 *  基本配置
 */
- (void)confirmSendCarBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"确认接单"];
}
/**
 *  配置表格
 */
- (void)configConfirmSendCarTableView{
    self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(bottomBtnHeight), 0);
}
/**
 *  初始化子控件
 */
- (void)initConfirmSendCarComponents{
    //底部按钮
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";
    NSString *cancelImage = @"ic_deselect_hl";
    CYTWeakSelf
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方",@"取消订单",@"确认接单"] imageNames:@[serverImage,contactImage,cancelImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [weakSelf contact];
    } thirdBtnClick:^{
        [weakSelf cancelOrderOperation];
    } fourthBtnClick:^{
        [weakSelf sendCar];
    }];
    
    [self.view addSubview:bottomToolBar];
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(bottomBtnHeight));
    }];
}
#pragma mark - 懒加载

- (CYTConfirmSendCarPar *)confirmSendCarPar{
    if (!_confirmSendCarPar) {
        _confirmSendCarPar = [[CYTConfirmSendCarPar alloc] init];
        _confirmSendCarPar.orderId = self.orderId;
    }
    return _confirmSendCarPar;
}
/**
 *  获取发车数据
 */
- (void)requestConfirmSendCarData{
    NSMutableDictionary *sendCarInfoPar = [NSMutableDictionary dictionary];
    [sendCarInfoPar setValue:self.orderId forKey:@"orderId"];
    [CYTNetworkManager GET:kURL.order_car_sendCarConfirmed parameters:sendCarInfoPar dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.resultEffective) {
            self.sendCarConfirmedModel = [CYTSendCarConfirmedModel mj_objectWithKeyValues:responseObject.dataDictionary];
            //数据绑定
            CYTOrderExtendSectionModel *orderExtendSectionModel = self.confirmSendCarData[0];
            CYTConfirmSendCarModel *sendCarModel = orderExtendSectionModel.sectionData[0];
            sendCarModel.content = self.sendCarConfirmedModel.sendCompanyName;
            CYTConfirmSendCarModel *sendAddressModel = orderExtendSectionModel.sectionData[1];
            sendAddressModel.content = self.sendCarConfirmedModel.sendAddress;
            CYTConfirmSendCarModel *senderModel = orderExtendSectionModel.sectionData[2];
            senderModel.content = self.sendCarConfirmedModel.senderInfo;
            if (self.sendCarConfirmedModel.orderType == 1) {//车源
                self.confirmSendCarPar.sendAddressId = nil;
                self.confirmSendCarPar.senderInfoId = nil;
            }else{
                self.confirmSendCarPar.sendAddressId = @"-1";
                self.confirmSendCarPar.senderInfoId = @"-1";
            }
            [self.mainTableView reloadData];
        }
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.confirmSendCarData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CYTOrderExtendSectionModel *sectionModel =  self.confirmSendCarData[section];
    return sectionModel.sectionData.count;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(100.f);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CYTOrderManagerSectionHeader *sectionHeader = [[CYTOrderManagerSectionHeader alloc] init];
    CYTOrderExtendSectionModel *sectionModel = self.confirmSendCarData[section];
    sectionHeader.confirmSendCarSectionModel = sectionModel;
    return sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        CYTCarConfirmListCell *cell = [CYTCarConfirmListCell celllForTableView:tableView indexPath:indexPath];
        CYTOrderExtendSectionModel *sectionModel =  self.confirmSendCarData[indexPath.section];
        CYTConfirmSendCarModel *confirmSendCarModel = sectionModel.sectionData[indexPath.row];
        confirmSendCarModel.showDividerLine = indexPath.row != sectionModel.sectionData.count - 1;
        cell.confirmSendCarModel = confirmSendCarModel;
        return cell;
    }
    CYTWeakSelf
    CYTVouchersCell *cell = [CYTVouchersCell vouchersCellForTableView:tableView indexPath:indexPath];
    cell.reSetcontentInset = ^(CGFloat bottomInset) {
        weakSelf.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(bottomBtnHeight) + bottomInset, 0);
        [weakSelf.mainTableView scrollToRow:0 section:2 animated:YES];
    };
    self.selectedImageModels = cell.selectedImageModels;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTOrderExtendSectionModel *orderExtendSectionModel = self.confirmSendCarData[indexPath.section];
    CYTConfirmSendCarModel *confirmSendCarModel = orderExtendSectionModel.sectionData[indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
                [self sendAddressSelectWithConfirmSendCarModel:confirmSendCarModel];
                break;
            case 2:
                [self senderSelectWithConfirmSendCarModel:confirmSendCarModel];
                break;
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 4:
                [self carProcedureWithConfirmSendCarModel:confirmSendCarModel];
                break;
            case 5:
                [self carToolsWithConfirmSendCarModel:confirmSendCarModel];
                break;
            case 6:
                [self remarkWithConfirmSendCarModel:confirmSendCarModel];
                break;
        }
    }
    
}
/**
 *  发车地址的选择
 */
- (void)sendAddressSelectWithConfirmSendCarModel:(CYTConfirmSendCarModel*)confirmSendCarModel{
      CYTWeakSelf
      [self addressSelectWithDefaultModel:self.selectAddressModel completion:^(CYTAddressModel *addressModel) {
          self.selectAddressModel = addressModel;
          weakSelf.confirmSendCarPar.sendAddressId = addressModel.receivingId;
          confirmSendCarModel.content = addressModel.customDetailAddress;
          [weakSelf.mainTableView reloadData];
      }];
}
/**
 *  发车人的选择
 */
- (void)senderSelectWithConfirmSendCarModel:(CYTConfirmSendCarModel*)confirmSendCarModel{
    CYTWeakSelf
    [self contactsSelectCompletion:^(CYTCarContactsModel *carContactsModel) {
        NSString *name = carContactsModel.name.length?carContactsModel.name:@"";
        NSString *phone = carContactsModel.phone.length?carContactsModel.phone:@"";
        confirmSendCarModel.content = [NSString stringWithFormat:@"%@ %@",name,phone];
        weakSelf.confirmSendCarPar.senderInfoId = carContactsModel.contactId;
        [weakSelf.mainTableView reloadData];
    }];
}

#pragma mark - 地址选择

- (void)addressSelectWithDefaultModel:(CYTAddressModel *)defaultAddressModel completion:(void(^)(CYTAddressModel *addressModel))completion{
    CYTAddressListViewController *carContactsViewController = [CYTAddressListViewController addressListWithType:CYTAddressListTypeSelect];
    carContactsViewController.addressModel = defaultAddressModel;
    carContactsViewController.addressSelectBlock = ^(CYTAddressModel *addressModel){
        !completion?:completion(addressModel);
    };
    [self.navigationController pushViewController:carContactsViewController animated:YES];
}

#pragma mark - 联系人选择

- (void)contactsSelectCompletion:(void(^)(CYTCarContactsModel *carContactsModel))completion{
    CYTCarContactsViewController *carContactsViewController = [CYTCarContactsViewController carContactsWithType:CYTCarContactsTypeSenderSelect];
    carContactsViewController.carContactBlock = ^(CYTCarContactsModel *carContactsModel) {
        !completion?:completion(carContactsModel);
    };
    [self.navigationController pushViewController:carContactsViewController animated:YES];
}

/**
 *  随车手续的选择
 */
- (void)carProcedureWithConfirmSendCarModel:(CYTConfirmSendCarModel*)confirmSendCarModel{
    CYTVehicleToolsViewController *vehicleToolsViewController = [CYTVehicleToolsViewController vehicleToolsWithToolsType:CYTVehicleToolsTypeProcedure];
    CYTWeakSelf
    vehicleToolsViewController.vehicleToolsSelected = ^(NSArray<CYTVehicleToolsModel *> *vehicleToolsModels) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [vehicleToolsModels enumerateObjectsUsingBlock:^(CYTVehicleToolsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempArray addObject:obj.name];
        }];
        NSString *contentString = [tempArray componentsJoinedByString:@","];
        confirmSendCarModel.content = contentString;
        weakSelf.confirmSendCarPar.carDocuments = contentString;
        [weakSelf.mainTableView reloadData];
    };
    [self.navigationController pushViewController:vehicleToolsViewController animated:YES];
}

/**
 *  随车附件的选择
 */
- (void)carToolsWithConfirmSendCarModel:(CYTConfirmSendCarModel*)confirmSendCarModel{
    CYTVehicleToolsViewController *vehicleToolsViewController = [CYTVehicleToolsViewController vehicleToolsWithToolsType:CYTVehicleToolsTypeTools];
    CYTWeakSelf
    vehicleToolsViewController.vehicleToolsSelected = ^(NSArray<CYTVehicleToolsModel *> *vehicleToolsModels) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [vehicleToolsModels enumerateObjectsUsingBlock:^(CYTVehicleToolsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempArray addObject:obj.name];
        }];
        NSString *contentString = [tempArray componentsJoinedByString:@","];
        confirmSendCarModel.content = contentString;
        weakSelf.confirmSendCarPar.carGoods = contentString;
        [weakSelf.mainTableView reloadData];
    };
    [self.navigationController pushViewController:vehicleToolsViewController animated:YES];
}

/**
 *  备注的填写
 */
- (void)remarkWithConfirmSendCarModel:(CYTConfirmSendCarModel*)confirmSendCarModel{
    CYTWeakSelf
    CYTPublishRemarkVC *configVC = [CYTPublishRemarkVC new];
    configVC.titleString = @"备注";
    configVC.content = weakSelf.remark;
    configVC.placeholder = @"请输入备注（1~200个字）";
    [configVC setConfigBlock:^(NSString *content) {
        weakSelf.remark = content;
        weakSelf.confirmSendCarPar.remark = content;
        confirmSendCarModel.content = content;
        [weakSelf.mainTableView reloadData];
    }];
    [weakSelf.navigationController pushViewController:configVC animated:YES];
}

/**
 *  联系对方
 */
- (void)contact{
    [CYTPhoneCallHandler makePhoneWithNumber:self.sendCarConfirmedModel.buyerPhone alert:@"联系对方?" resultBlock:nil];
}
/**
 *  取消订单操作
 */
- (void)cancelOrderOperation{
    NSInteger logisticsStatus = self.sendCarConfirmedModel.logisticsStatus;
    NSString *logisticsCancelTip = self.sendCarConfirmedModel.logisticsCancelTip;
    if (logisticsStatus == 1) {
        [CYTAlertView alertViewWithTitle:@"提示" message:logisticsCancelTip confirmAction:^{
            [self cancelOrder];
        } cancelAction:nil];
        return;
    }
    if (logisticsStatus == 2) {
        [CYTToast errorToastWithMessage:logisticsCancelTip];
        return;
    }
    [self cancelOrder];
}
/**
 *  取消订单
 */
- (void)cancelOrder{
    CYTOrderExtendViewController *orderDetailViewController = [CYTOrderExtendViewController orderExtendWithExtendType:CYTOrderExtendTypeSellerCancel orderStatus:CarOrderStateUnSendCar orderId:self.orderId];
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}

/**
 *  去发车
 */
- (void)sendCar{
    CYTOrderExtendSectionModel *orderExtendSectionModel = self.confirmSendCarData[1];
    CYTConfirmSendCarModel *expressDriverModel = orderExtendSectionModel.sectionData[0];
    self.confirmSendCarPar.expressDriver = expressDriverModel.inputContent;
    CYTConfirmSendCarModel *expressDriverPhoneModel = orderExtendSectionModel.sectionData[1];
    self.confirmSendCarPar.expressDriverPhone = expressDriverPhoneModel.inputContent;
    CYTConfirmSendCarModel *expressCompanyNameModel = orderExtendSectionModel.sectionData[2];
    self.confirmSendCarPar.expressCompanyName = expressCompanyNameModel.inputContent;
    CYTConfirmSendCarModel *vinModel = orderExtendSectionModel.sectionData[3];
    self.confirmSendCarPar.vin = vinModel.inputContent;
    if (self.sendCarConfirmedModel.orderType == 1) {//车源
        if (!self.confirmSendCarPar.sendAddressId) {
            [CYTToast warningToastWithMessage:@"请选择发车地址"];
            return;
        }
        if (!self.confirmSendCarPar.senderInfoId) {
            [CYTToast warningToastWithMessage:@"请选择发车人"];
            return;
        }
        [self commitConfirmSendCar];
    }else{
        [self commitConfirmSendCar];
    }
}
/**
 *  提交发车信息
 */
- (void)commitConfirmSendCar{
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.order_car_sendCar parameters:self.confirmSendCarPar.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderDetailKey object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderListKey object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
