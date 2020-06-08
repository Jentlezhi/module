//
//  CYTOrderCommitViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderCommitViewController.h"
#import "CYTCarInfoCell.h"
#import "CYTCommitPriceInfoCell.h"
#import "CYTCommitReceiverInfoCell.h"
#import "CYTCommitSenderInfoCell.h"
#import "CYTProtocolView.h"
#import "CYTPublishRemarkVC.h"
#import "CYTSeekCarInfo.h"
#import "CYTCarSourceInfo.h"
#import "CYTReceiveContacts.h"
#import "CYTSendContacts.h"
#import "CYTCreateOrderCarSourcePar.h"
#import "CYTCreateOrderSeekCarPar.h"
#import "CYTCarSourceListModel.h"
#import "CYTAddressListViewController.h"
#import "CYTCarContactsViewController.h"
#import "CYTAddressModel.h"
#import "CYTCarContactsModel.h"
#import "CYTOrderDetailViewController.h"
#import "CYTPaymentModel.h"
#import "CYTPaymentManager.h"
#import "CYTCardView.h"
#import "CYTCommitGuideView.h"
#import "CYTCreateOrderTipsModel.h"

@interface CYTOrderCommitViewController ()

/** 提交类型 */
@property(assign, nonatomic) CYTOrderCommitType orderCommitType;
/** 车款ID */
@property(copy, nonatomic) NSString *carID;
/** 底部按钮 */
@property(strong, nonatomic) UIButton *botttomBtn;
/** 车款信息 */
@property(strong, nonatomic) id carInfo;
/** 发车人信息 */
@property(strong, nonatomic) CYTSendContacts *sendContacts;
/** 收车人信息 */
@property(strong, nonatomic) CYTReceiveContacts *receiveContacts;
/** 创建订单-车源 */
@property(strong, nonatomic) CYTCreateOrderCarSourcePar *createOrderCarSourcePar;
/** 创建订单-寻车 */
@property(strong, nonatomic) CYTCreateOrderSeekCarPar *createOrderSeekCarPar;
/** 地址模型 */
@property(strong, nonatomic) CYTAddressModel *senderAddressModel;
/** 价格 */
@property(strong, nonatomic) CYTCommitPriceInfoCell *commitPriceInfoCell;
///提示语
@property(strong, nonatomic) CYTCreateOrderTipsModel *tipsModel;

@end

@implementation CYTOrderCommitViewController
{
    CYTCreateOrderCarSourcePar *_createOrderCarSourcePar;
    CYTCreateOrderSeekCarPar *_createOrderSeekCarPar;
}

+ (instancetype)orderCommitViewControllerWithType:(CYTOrderCommitType)orderCommitType carID:(NSString *)carID{
    CYTOrderCommitViewController *orderCommitViewController = [[CYTOrderCommitViewController alloc] initWithType:orderCommitType carID:carID];
    return orderCommitViewController;
}

- (instancetype)initWithType:(CYTOrderCommitType)orderCommitType carID:(NSString *)carID{
    if (self = [super init]) {
        self.orderCommitType = orderCommitType;
        self.carID = carID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self orderCommitBasicConfig];
    [self initCommitComponents];
    [self requestData];
}

/**
 *  基本配置
 */
- (void)orderCommitBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"提交订单"];
    self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(80) + CYTMarginV, 0);;
}
/**
 *  初始化子控件
 */
- (void)initCommitComponents{
    //设置footer
    CYTWeakSelf
    CYTProtocolView *protocolView = [[CYTProtocolView alloc] initWithContent:@"我已阅读并同意《车销通在线交易协议》" link:@"《车销通在线交易协议》"];
    protocolView.backgroundColor = CYTLightGrayColor;
    protocolView.aggreeProtocol = ^(BOOL agree) {
        weakSelf.createOrderCarSourcePar.customRefuseProtocal = !agree;
        weakSelf.createOrderSeekCarPar.customRefuseProtocal = !agree;
    };
    protocolView.protocolClick = ^{
        CYTH5WithInteractiveCtr *protocolVC = [[CYTH5WithInteractiveCtr alloc] init];
        protocolVC.requestURL = kURL.kURL_me_set_deal;
        [weakSelf.navigationController pushViewController:protocolVC animated:YES];
    };
    protocolView.frame = CGRectMake(0, 0, kScreenWidth, protocolView.height);
    self.mainTableView.tableFooterView = protocolView;
    
    //底部按钮
    [self.view addSubview:self.botttomBtn];
    [self.botttomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-CYTMarginV);
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
    
}

#pragma mark - 懒加载

- (CYTCreateOrderCarSourcePar *)createOrderCarSourcePar{
    if (!_createOrderCarSourcePar) {
        _createOrderCarSourcePar = [[CYTCreateOrderCarSourcePar alloc] init];
    }
    return _createOrderCarSourcePar;
}

- (CYTCreateOrderSeekCarPar *)createOrderSeekCarPar{
    if (!_createOrderSeekCarPar) {
        _createOrderSeekCarPar = [[CYTCreateOrderSeekCarPar alloc] init];
    }
    return _createOrderSeekCarPar;
}

- (UIButton *)botttomBtn{
    if (!_botttomBtn) {
        NSString *btnTitle = self.orderCommitType == CYTOrderCommitTypeBuyer ? @"去支付":@"确认发起交易";
        _botttomBtn = [UIButton buttonWithTitle:btnTitle enabled:YES];
        [[_botttomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            //寻车
            self.createOrderSeekCarPar.dealPrice = self.commitPriceInfoCell.dealPrice;
            self.createOrderSeekCarPar.dealCarNum = self.commitPriceInfoCell.dealNumber;
            self.createOrderSeekCarPar.dealUnitPrice = self.commitPriceInfoCell.dealUnitPrice;
            self.createOrderSeekCarPar.depositAmount = self.commitPriceInfoCell.depositAmount;
            self.createOrderSeekCarPar.remark = self.commitPriceInfoCell.remark;
            //车源
            self.createOrderCarSourcePar.dealPrice = self.commitPriceInfoCell.dealPrice;
            self.createOrderCarSourcePar.dealCarNum = self.commitPriceInfoCell.dealNumber;
            self.createOrderCarSourcePar.dealUnitPrice = self.commitPriceInfoCell.dealUnitPrice;
            self.createOrderCarSourcePar.depositAmount = self.commitPriceInfoCell.depositAmount;
            
            if (self.orderCommitType == CYTOrderCommitTypeBuyer) {
                [self createCarSourceOrder];
            }else{
                [self createSeekCarOrder];
            }
        }];
    }
    return _botttomBtn;
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.orderCommitType == CYTOrderCommitTypeBuyer) {
        return 3;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://车款信息
            return [self carInfoCellWithTableView:tableView indexPath:indexPath carInfo:self.carInfo];
            break;
        case 1://车款价格
            return [self priceInfoWithTableView:tableView indexPath:indexPath model:self.tipsModel];
            break;
        case 2://收车信息
            return [self commitReceiverInfoCellWithTableView:tableView indexPath:indexPath model:self.receiveContacts];
        case 3://发车信息
            return [self commitSenderInfoCellWithTableView:tableView indexPath:indexPath model:self.sendContacts];
            break;
    }
    return nil;
}

/**
 *  车款信息
 */
- (CYTCarInfoCell *)carInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath carInfo:(id)carInfo{
    CYTCarInfoCellType carInfoCellType = self.orderCommitType == CYTOrderCommitTypeBuyer ? CYTCarInfoCellTypeCarSource:CYTCarInfoCellTypeSeekCar;
    CYTCarInfoCell *carInfoCell = [CYTCarInfoCell cellWithType:carInfoCellType  forTableView:tableView indexPath:indexPath];
    if (!carInfo) return carInfoCell;
    if ([carInfo isKindOfClass:[CYTCarSourceInfo class]]) {
        //参数
        self.createOrderCarSourcePar.carSourceId = [(CYTCarSourceInfo *)carInfo carSourceId];
        carInfoCell.carSourceInfo = self.carInfo;
    }else{
        //参数
        self.createOrderSeekCarPar.seekCarId = [(CYTSeekCarInfo *)carInfo seekCarId];
        carInfoCell.seekCarInfo = self.carInfo;
    }
    return carInfoCell;
}
/**
 *  车款价格
 */
- (CYTCommitPriceInfoCell *)priceInfoWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath model:(CYTCreateOrderTipsModel *)model{
    CYTCommitPriceInfoCell *commitPriceInfoCell = [CYTCommitPriceInfoCell cellForTableView:tableView indexPath:indexPath];
    commitPriceInfoCell.commitType = self.orderCommitType;
    commitPriceInfoCell.tipsModel = model;
    CYTWeakSelf
    __weak typeof(commitPriceInfoCell) weakCommitPriceInfoCell = commitPriceInfoCell;
    commitPriceInfoCell.remakeClick = ^(NSString *remake) {
        CYTPublishRemarkVC *configVC = [CYTPublishRemarkVC new];
        configVC.titleString = @"备注";
        configVC.content = remake;
        configVC.placeholder = @"请输入备注（1~200个字）";
        [configVC setConfigBlock:^(NSString *content) {
            if (weakSelf.orderCommitType == CYTOrderCommitTypeSeller) {
                weakSelf.createOrderSeekCarPar.remark = content;
            }else{
                weakSelf.createOrderCarSourcePar.remark = content;
            }
            weakCommitPriceInfoCell.remark = content;
            [weakSelf.mainTableView reloadData];
        }];
        [weakSelf.navigationController pushViewController:configVC animated:YES];
    };
    [commitPriceInfoCell setClickDepositAlertBlock:^{
        [self.view endEditing:YES];
        //弹出流程图,点击确认进入交易
        FFBasicSupernatantViewModel *vm = [FFBasicSupernatantViewModel new];
        //0-买家，1-卖家
        vm.ffIndex = self.orderCommitType;
        CYTCommitGuideView *commitView = [[CYTCommitGuideView alloc] initWithViewModel:vm];
        [commitView ff_showSupernatantView];
    }];
    self.commitPriceInfoCell = commitPriceInfoCell;
    return commitPriceInfoCell;
}
/**
 *  收车信息
 */
- (CYTCommitReceiverInfoCell *)commitReceiverInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath model:(CYTReceiveContacts *)model{
    CYTReceiveContactsType receiveContactsType = self.orderCommitType == CYTReceiveContactsTypeBuyer?CYTReceiveContactsTypeBuyer:CYTReceiveContactsTypeSeller;
    CYTCommitReceiverInfoCell *commitReceiverInfoCell = [CYTCommitReceiverInfoCell cellForTableView:tableView type:receiveContactsType indexPath:indexPath];
    commitReceiverInfoCell.receiveContacts = model;
    CYTWeakSelf
    if (self.orderCommitType == CYTOrderCommitTypeBuyer) {
        commitReceiverInfoCell.recAddressClick = ^{
            [weakSelf addressSelectWithDefaultModel:weakSelf.senderAddressModel completion:^(CYTAddressModel *addressModel) {
                //参数
                weakSelf.createOrderCarSourcePar.receiveAddressId = addressModel.receivingId;
                //数据绑定
                model.address = addressModel.customDetailAddress;
                [weakSelf reloadTableDataWithIndexPath:indexPath];
            }];
        };
        
        commitReceiverInfoCell.recerClick = ^{
            [weakSelf contactsSelectWithType:CYTOrderCommitTypeSeller completion:^(CYTCarContactsModel *carContactsModel) {
                //参数
                weakSelf.createOrderCarSourcePar.receiverInfoId = carContactsModel.contactId;
                //数据绑定
                model.name = carContactsModel.name;
                model.phone = carContactsModel.phone;
                [weakSelf reloadTableDataWithIndexPath:indexPath];
            }];
        };

    }
    return commitReceiverInfoCell;
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

/**
 *  发车信息
 */
- (CYTCommitSenderInfoCell *)commitSenderInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath model:(CYTSendContacts *)sendContacts{
    CYTWeakSelf
    __block CYTSendContacts *sendContactsModel = sendContacts;
    CYTCommitSenderInfoCell *commitSenderInfoCell = [CYTCommitSenderInfoCell cellForTableView:tableView indexPath:indexPath];
    commitSenderInfoCell.sendAddressClick = ^{
        [weakSelf addressSelectWithDefaultModel:weakSelf.senderAddressModel completion:^(CYTAddressModel *addressModel) {
            //参数
            weakSelf.createOrderSeekCarPar.sendAddressId = addressModel.receivingId;
            //数据绑定
            sendContactsModel.address = addressModel.customDetailAddress;
            [weakSelf reloadTableDataWithIndexPath:indexPath];
        }];
    };
    commitSenderInfoCell.senderClick = ^{
        [weakSelf contactsSelectWithType:CYTOrderCommitTypeBuyer completion:^(CYTCarContactsModel *carContactsModel) {
            //参数
            weakSelf.createOrderSeekCarPar.senderInfoId = carContactsModel.contactId;
            //数据绑定
            sendContactsModel.name = carContactsModel.name;
            sendContactsModel.phone = carContactsModel.phone;
            [weakSelf reloadTableDataWithIndexPath:indexPath];
        }];
    };
    commitSenderInfoCell.sendContacts = sendContactsModel;
    return commitSenderInfoCell;
}
/**
 *  请求数据
 */
- (void)requestData{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    NSString *requestUrl = [NSString string];
    if (self.orderCommitType == CYTOrderCommitTypeSeller) {
        [par setValue:self.carID forKey:@"seekCarId"];
        requestUrl = kURL.car_seek_getSeekCarInfoSubmitOrder;
    }else{
        [par setValue:self.carID forKey:@"carSourceId"];
        requestUrl = kURL.car_source_getSourceInfoSubmitOrder;
    }
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager GET:requestUrl parameters:par dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self dismissNoNetworkView];
            [self.view bringSubviewToFront:self.botttomBtn];
            if (self.orderCommitType == CYTOrderCommitTypeBuyer) {
                self.carInfo = [CYTCarSourceInfo mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"carInfo"]];
                self.sendContacts = [CYTSendContacts mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"sendContacts"]];
                self.receiveContacts = [CYTReceiveContacts mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"receiveContacts"]];
            }else{
                self.carInfo = [CYTSeekCarInfo mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"carInfo"]];
                self.sendContacts = [CYTSendContacts mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"sendContacts"]];
                self.receiveContacts = [CYTReceiveContacts mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"receiveContacts"]];
            }
            self.tipsModel = [CYTCreateOrderTipsModel mj_objectWithKeyValues:[responseObject.dataDictionary valueForKey:@"infoTip"]];
            [self.mainTableView reloadData];

        }else{
            [self showNoNetworkView];
            [self.view bringSubviewToFront:self.mainTableView];
        }
    }];
    
}
#pragma mark - 联系人选择

- (void)contactsSelectWithType:(CYTOrderCommitType)orderCommitType  completion:(void(^)(CYTCarContactsModel *carContactsModel))completion{
    CYTCarContactsType carContactsType = orderCommitType == CYTOrderCommitTypeSeller ? CYTCarContactsTypeReceiverSelect:CYTCarContactsTypeSenderSelect;
    CYTCarContactsViewController *carContactsViewController = [CYTCarContactsViewController carContactsWithType:carContactsType];
    carContactsViewController.carContactBlock = ^(CYTCarContactsModel *carContactsModel) {
        !completion?:completion(carContactsModel);
    };
    [self.navigationController pushViewController:carContactsViewController animated:YES];
}
#pragma mark - 刷新当前数据

- (void)reloadTableDataWithIndexPath:(NSIndexPath *)indexPath{
    CYTWeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.mainTableView reloadDataAtIndexPath:indexPath animation:YES];
        [weakSelf.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
}

#pragma mark - 创建订单

- (void)createCarSourceOrder{
    //买车提示
    if (!self.createOrderCarSourcePar.dealUnitPrice.length) {
        [CYTToast warningToastWithMessage:@"请输入成交单价"];
        return;
    }
    if (!self.createOrderCarSourcePar.dealCarNum.length) {
        [CYTToast warningToastWithMessage:@"请输入成交数量"];
        return;
    }
    if (!self.createOrderCarSourcePar.depositAmount.length) {
        [CYTToast warningToastWithMessage:@"请输入订金总额"];
        return;
    }
    if (!self.createOrderCarSourcePar.receiveAddressId.length) {
        [CYTToast warningToastWithMessage:@"请选择收车地址"];
        return;
    }
    if (!self.createOrderCarSourcePar.receiverInfoId.length) {
        [CYTToast warningToastWithMessage:@"请选择收车人"];
        return;
    }
    if (self.createOrderCarSourcePar.isCustomRefuseProtocal) {
        [CYTToast warningToastWithMessage:@"请同意《车销通在线交易协议》"];
        return;
    }
    CYTWeakSelf
    //创建订单
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.order_sourceCar_createOrder parameters:self.createOrderCarSourcePar.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [weakSelf carSourceOrdetailWithType:CarOrderTypeBought orderId:[responseObject.dataDictionary valueForKey:@"orderId"]];
        }
    }];
    
}
- (void)createSeekCarOrder{
    if (!self.createOrderSeekCarPar.dealUnitPrice.length) {
        [CYTToast warningToastWithMessage:@"请输入成交单价"];
        return;
    }
    if (!self.createOrderSeekCarPar.dealCarNum.length) {
        [CYTToast warningToastWithMessage:@"请输入成交数量"];
        return;
    }
    if (!self.createOrderSeekCarPar.depositAmount.length) {
        [CYTToast warningToastWithMessage:@"请输入订金总额"];
        return;
    }
    if (!self.createOrderSeekCarPar.sendAddressId.length) {
        [CYTToast warningToastWithMessage:@"请选择发车地址"];
        return;
    }
    if (!self.createOrderSeekCarPar.senderInfoId.length) {
        [CYTToast warningToastWithMessage:@"请选择发车人"];
        return;
    }
    if (self.createOrderSeekCarPar.isCustomRefuseProtocal) {
        [CYTToast warningToastWithMessage:@"请同意《车销通在线交易协议》"];
        return;
    }
    //创建订单
    CYTWeakSelf
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.order_seekCar_createOrder parameters:self.createOrderSeekCarPar.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [weakSelf seekCarOrdetailWithType:CarOrderTypeSold orderId:[responseObject.dataDictionary valueForKey:@"orderId"]];
            
        }
    }];
}
/**
 *  车源交易
 */
- (void)carSourceOrdetailWithType:(CarOrderType)orderType orderId:(NSString *)orderId{
    CYTOrderDetailViewController *detail = [CYTOrderDetailViewController new];
    detail.carSourceCommitPushed = YES;
    detail.orderType = orderType;
    detail.orderId = orderId;
    NSMutableArray *mArray = [self.navigationController.viewControllers mutableCopy];
    [mArray addObject:detail];
    [self.navigationController setViewControllers:mArray animated:NO];
    
    CYTPaymentModel *model = [CYTPaymentModel new];
    model.orderId = orderId;
    model.paymentType = PaymentType_dingjin;
    model.payType = PayType_zhifubao;
    model.sourceType = PaySourceTypeOrderDetail;
    [CYTPaymentManager getPayInfoWithModel:model andSuperController:self];
}

/**
 *  寻车交易
 */
- (void)seekCarOrdetailWithType:(CarOrderType)orderType orderId:(NSString *)orderId{
    CYTOrderDetailViewController *detail = [CYTOrderDetailViewController new];
    detail.seekCarCommitPushed = YES;
    detail.orderType = orderType;
    detail.orderId = orderId;
    NSMutableArray *mArray = [self.navigationController.viewControllers mutableCopy];
    [mArray addObject:detail];
    [self.navigationController setViewControllers:mArray animated:NO];
}

#pragma mark - 重新加载
- (void)reloadData{
    [self requestData];
}


@end
