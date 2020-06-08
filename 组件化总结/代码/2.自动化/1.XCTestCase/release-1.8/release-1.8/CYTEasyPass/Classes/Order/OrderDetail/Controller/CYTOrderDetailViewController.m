//
//  CYTOrderDetailViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderDetailViewController.h"
#import "CYTOrderStatusCell.h"
#import "CYTLogisticTipCell.h"
#import "CYTRecCarInfoCell.h"
#import "CYTCarInfoCell.h"
#import "CYTAcceptanceSituationCell.h"
#import "CYTOrderModel.h"
#import "CYTExpressModel.h"
#import "CYTCarModel.h"
#import "CYTLogListModel.h"
#import "CYTImageVoucherModel.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTConfirmSendCarViewController.h"
#import "CYTSendCarInfoCell.h"
#import "CYTOrderNumberInfoCell.h"
#import "CYTLogListCell.h"
#import "CYTLogListModel.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTOrderExtendViewController.h"
#import "CYTPaymentModel.h"
#import "CYTPaymentManager.h"
#import "CYTLogisticsNeedWriteTableController.h"
#import "CYTDealerCommentPublishView.h"
#import "CYTPhontoPreviewViewController.h"
#import "CYTImageFileModel.h"
#import "CYTSeekCarDetailViewController.h"
#import "CYTCarSourceDetailTableController.h"
#import "FFBasicSupernatantViewModel.h"
#import "CYTSendCarSupernatant.h"
#import "CYTCarSourceImageShowViewController.h"

@interface CYTOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 我卖的车 */
@property(strong, nonatomic) NSMutableArray *mySellcells;
/** 我买的车 */
@property(strong, nonatomic) NSMutableArray *myBuycells;
/** 订单详情 */
@property(strong, nonatomic) CYTOrderModel *orderModel;
/** 物流 */
@property(strong, nonatomic) CYTExpressModel *expressModel;
/** 车辆详情 */
@property(strong, nonatomic) CYTCarModel *carModel;
/** 底部按钮 */
@property(weak, nonatomic) CYTOrderBottomToolBar *bottomToolBar;
/** 订单日志 */
@property(strong, nonatomic) NSArray *logLists;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;
/** 同意提交参数 */
@property(strong, nonatomic) NSMutableDictionary *sellerRefundProcPar;
/** 未支付状态cell */
@property(strong, nonatomic) NSMutableArray *unPayStateCells;
/** 成功状态cell */
@property(strong, nonatomic) NSMutableArray *succeedStateCells;
/** 未chou'che状态cell */
@property(strong, nonatomic) NSMutableArray *unReceiveCarStateCells;


@end

@implementation CYTOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver];
    [self orderDetailBasicConfig];
    [self orderTableViewConfig];
    [self requestOrderDetailData];
}

///1、关闭手势返回功能/2、有评价功能，关闭iqkeyboard功能---------------------->>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.interactivePopGestureEnable = NO;
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.interactivePopGestureEnable = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

///<<<------------------------------------

/**
 *  基本配置
 */
- (void)orderDetailBasicConfig{
    NSString *title;
    if (self.orderStatus == CarOrderStateRefund ||self.orderStatus == CarOrderStateRefundSellerDo || self.orderStatus == CarOrderStateRefundSellerDo) {
        title = @"退款详情";
    }else{
         title = @"订单详情";
    }
    [self createNavBarWithBackButtonAndTitle:title];

}

- (void)addObserver{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRefreshOrderDetailKey object:nil] subscribeNext:^(id x) {
        [self requestOrderDetailData];
    }];
    
}
/**
 *  配置表格
 */
- (void)orderTableViewConfig{
    CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
    self.mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.mainTableView.estimatedSectionFooterHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
    }
    self.mainTableView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(98.f)+CYTItemMarginV, 0);
    self.mainTableView.backgroundColor = CYTLightGrayColor;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mainTableView];
}

- (void)showCommentViewNow {
    //获取被评论人id，如果成功则show，否则提示错误
    if (self.commentPublishView.viewModel.model.beEvalUserId.length>0) {
        [self.commentPublishView showNow];
    }else {
        [CYTToast errorToastWithMessage:@"评论信息获取失败！"];
    }
}

#pragma mark - 懒加载

- (NSArray *)logLists{
    if (!_logLists) {
        _logLists = [NSArray array];
    }
    return _logLists;
}

- (NSMutableArray *)myBuycells{
    if (!_myBuycells) {
        _myBuycells = [NSMutableArray array];
    }
    return _myBuycells;
}

- (NSMutableArray *)mySellcells{
    if (!_mySellcells) {
        _mySellcells = [NSMutableArray array];
    }
    return _mySellcells;
}

- (NSMutableDictionary *)sellerRefundProcPar{
    if (!_sellerRefundProcPar) {
        _sellerRefundProcPar = [NSMutableDictionary dictionary];
        [_sellerRefundProcPar setValue:self.orderId forKey:@"orderId"];
    }
    return _sellerRefundProcPar;
}

- (CYTDealerCommentPublishView *)commentPublishView {
    if (!_commentPublishView) {
        CYTDealerCommentPublishModel *model = [CYTDealerCommentPublishModel new];
        //被评论认用户Id
        model.beEvalUserId = self.orderModel.traderUserId;
        //评价类型1=电话、2=订单
        model.sourceType = @"2";
        //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈
        model.sourceId = (self.orderType == CarOrderTypeBought)?@"4":@"5";
        //评价订单id
        model.orderId = self.orderId;
        
        CYTDealerCommentPublishVM *vm = [[CYTDealerCommentPublishVM alloc] initWithModel:model];
        [vm.hudSubject subscribeNext:^(id x) {
            if ([x integerValue] == 0) {
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
            }else {
                [CYTLoadingView hideLoadingView];
            }
        }];
        
        @weakify(self);
        [vm.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
            @strongify(self);
            //如果成功则设置nil
            if (responseModel.resultEffective) {
                self.commentPublishView = nil;
                [CYTToast successToastWithMessage:responseModel.resultMessage];
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderListKey object:nil];
                [self requestOrderDetailData];
                
            }else{
                [CYTToast errorToastWithMessage:responseModel.resultMessage];
            }
        }];
        _commentPublishView = [[CYTDealerCommentPublishView alloc] initWithViewModel:vm];
        _commentPublishView.title = @"发布评价";
    }
    return _commentPublishView;
}

#pragma mark - 请求数据

- (void)requestOrderDetailData{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    [par setValue:self.orderId forKey:@"orderId"];
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager GET:kURL.order_car_getOrderDetail parameters:par dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self dismissNoNetworkView];
            [self.view bringSubviewToFront:self.bottomToolBar];
            NSDictionary *orderDict = [responseObject.dataDictionary valueForKey:@"order"];
            self.orderModel = [CYTOrderModel mj_objectWithKeyValues:orderDict];
            NSDictionary *expressDict = [responseObject.dataDictionary valueForKey:@"express"];
            self.expressModel = [CYTExpressModel mj_objectWithKeyValues:expressDict];
            NSDictionary *carDict = [responseObject.dataDictionary valueForKey:@"car"];
            self.carModel = [CYTCarModel mj_objectWithKeyValues:carDict];
            self.carModel.orderModel = self.orderModel;
            
            NSArray *logLists = [responseObject.dataDictionary valueForKey:@"logList"];
            self.logLists = [CYTLogListModel mj_objectArrayWithKeyValuesArray:logLists];
            NSArray *imageVouchersDict = [responseObject.dataDictionary valueForKey:@"imageVouchers"];
            self.orderModel.customImageVouchers = [CYTImageVoucherModel mj_objectArrayWithKeyValuesArray:imageVouchersDict];
            [self initOrderDetailComponentsWithStatus:self.orderModel.orderStatus];
            [self.mainTableView reloadData];
        }else{
            [self showNoNetworkView];
            [self.view bringSubviewToFront:self.mainTableView];
        }
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [self numberOfRowsWithStatus:self.orderModel.orderStatus];;
    }else{
        return self.logLists.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CarOrderState  carOrderState = self.orderModel.orderStatus;
        switch (carOrderState) {
            case CarOrderStateUnPay:
            case CarOrderStateUnSendCar:
               return [self unPayStateCellWithTableView:tableView indexPath:indexPath];
                break;
            case CarOrderStateUnComment:
            case CarOrderStateSucceed:
            case CarOrderStateCancel:
            case CarOrderStateRefund:
            case CarOrderStateRefundSellerDo:
            case CarOrderStateRefundSysDo:
               return  [self succeedStateWithTableView:tableView indexPath:indexPath];
               break;
            case CarOrderStateUnReceiveCar:
               return  [self unReceiveCarStateWithTableView:tableView indexPath:indexPath];
               break;
            default:
               return [self unPayStateCellWithTableView:tableView indexPath:indexPath];;
               break;
        }
    }else{//订单日志
        return [self logListCellWithTableView:tableView indexPath:indexPath];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

/**
 * 订单状态
 */
- (CYTOrderStatusCell *)orderStatusCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath orderModel:(CYTOrderModel *)orderModel{
    CYTOrderStatusCell *orderStatusCell = [CYTOrderStatusCell cellForTableView:tableView indexPath:indexPath];
    orderStatusCell.orderModel = orderModel;
    return orderStatusCell;
}
/**
 * 验收情况
 */
- (CYTAcceptanceSituationCell *)acceptanceSituationCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath orderModel:(CYTOrderModel *)orderModel{
    CYTAcceptanceSituationCell *acceptanceSituationCell = [CYTAcceptanceSituationCell celllForTableView:tableView indexPath:indexPath];
    NSArray<CYTImageVoucherModel*>*customImageVouchers = orderModel.customImageVouchers;
    NSMutableArray<CYTImageFileModel*>*imageFileModels = [NSMutableArray array];
    [customImageVouchers enumerateObjectsUsingBlock:^(CYTImageVoucherModel * _Nonnull imageVoucherModel, NSUInteger idx, BOOL * _Nonnull stop) {
        CYTImageFileModel *fileModel = [[CYTImageFileModel alloc] init];
        fileModel.thumbnailUrl = imageVoucherModel.thumbnailUrl;
        fileModel.url = imageVoucherModel.url;
        [imageFileModels addObject:fileModel];
    }];
    CYTWeakSelf
    acceptanceSituationCell.voucherPictureViewClick = ^(NSInteger index) {
        //图片浏览
        CYTCarSourceImageShowViewController *showVC = [CYTCarSourceImageShowViewController new];
        showVC.imageArray = imageFileModels;
        [weakSelf.navigationController pushViewController:showVC animated:YES];
    };
    acceptanceSituationCell.orderModel = orderModel;
    return acceptanceSituationCell;
}
/**
 * 物流人口
 */
- (CYTLogisticTipCell *)logisticInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    CYTLogisticTipCell *logisticInfoCell = [CYTLogisticTipCell cellForTableView:tableView indexPath:indexPath];
    logisticInfoCell.logisticClick = ^{
        CYTLogisticsOrderDetail3DController *logisticsOrderDetailController = [[CYTLogisticsOrderDetail3DController alloc] init];
        logisticsOrderDetailController.orderId = [NSString stringWithFormat:@"%ld",self.orderModel.logisticsOrderId];
        [self.navigationController pushViewController:logisticsOrderDetailController animated:YES];
    };
    return logisticInfoCell;
}
/**
 * 收车人信息
 */
- (CYTRecCarInfoCell *)recCarInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath expressModel:(CYTExpressModel *)expressModel{
    CYTRecCarInfoCell *recCarInfoCell = [CYTRecCarInfoCell cellForTableView:tableView indexPath:indexPath];
    recCarInfoCell.expressModel = expressModel;
    return recCarInfoCell;
}
/**
 * 发车人信息
 */
- (CYTSendCarInfoCell *)sendCarInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath orderModel:(CYTExpressModel *)expressModel{
    CYTSendCarInfoCell *recCarInfoCell = [CYTSendCarInfoCell cellForTableView:tableView indexPath:indexPath];
    recCarInfoCell.expressModel = expressModel;
    return recCarInfoCell;
}
/**
 *  车款信息
 */
- (CYTCarInfoCell *)carInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath carModel:(CYTCarModel *)carModel{
    CYTCarInfoCell *carInfoCell = [CYTCarInfoCell cellWithType:CYTCarInfoCellTypeOrderDetail forTableView:tableView indexPath:indexPath];
    carInfoCell.carModel = carModel;
    @weakify(self);
    [carInfoCell setClickedBlock:^(CYTCarModel *model) {
        @strongify(self);
        //进入车源或者寻车详情页面
        if (self.orderModel.orderSourceType == 1) {
            //车源
            CYTCarSourceDetailTableController *detail = [CYTCarSourceDetailTableController new];
            detail.viewModel.fromOrderView = YES;
            detail.viewModel.carSourceId = [NSString stringWithFormat:@"%ld",self.orderModel.carTypeId];
            [self.navigationController pushViewController:detail animated:YES];
        }else {
            //寻车
            CYTSeekCarDetailViewController *detail = [[CYTSeekCarDetailViewController alloc] init];
            detail.seekCarId = [NSString stringWithFormat:@"%ld",self.orderModel.carTypeId];
            detail.seekCarDetailType = CYTSeekCarDetailTypeOrderDetail;
            [self.navigationController pushViewController:detail animated:YES];
        }
        
    }];
    
    return carInfoCell;
}
/**
 * 订单号
 */
- (CYTOrderNumberInfoCell *)orderNumberInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath orderModel:(CYTOrderModel *)orderModel {
    CYTOrderNumberInfoCell *orderNumberInfoCell = [CYTOrderNumberInfoCell cellForTableView:tableView indexPath:indexPath];
    orderNumberInfoCell.orderModel = orderModel;
    return orderNumberInfoCell;
}
/**
 * 订单日志
 */
- (CYTLogListCell *)logListCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    CYTLogListCell *cell = [CYTLogListCell logListCelllForTableView:tableView indexPath:indexPath];
    CYTLogListModel *logListModel = self.logLists[indexPath.row];
    cell.logListModel = logListModel;
    return cell;
}

#pragma mark - 属性设置

- (UITableViewCell *)unPayStateCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return [self orderStatusCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
            break;
        case 1:
            return [self recCarInfoCellWithTableView:tableView indexPath:indexPath expressModel:self.expressModel];
            break;
        case 2:
            return [self sendCarInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.expressModel];
            break;
        case 3:
            return [self carInfoCellWithTableView:tableView indexPath:indexPath carModel:self.carModel];
            break;
        case 4:
            return [self orderNumberInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
        default:
            return [UITableViewCell new];
            break;
    }
    return nil;

}

- (UITableViewCell *)succeedStateWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    BOOL isSeller = self.orderType == CarOrderTypeSold;
    if (isSeller) {
        switch (indexPath.row) {
            case 0:
                return [self orderStatusCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            case 1:
                return [self acceptanceSituationCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            case 2:
                return [self recCarInfoCellWithTableView:tableView indexPath:indexPath expressModel:self.expressModel];
                break;
            case 3:
                return [self sendCarInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.expressModel];
                break;
            case 4:
                return [self carInfoCellWithTableView:tableView indexPath:indexPath carModel:self.carModel];
                break;
            case 5:
                return [self orderNumberInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            default:
                return [UITableViewCell new];
                break;
        }
        return nil;
    }else{
        switch (indexPath.row) {
            case 0:
                return [self orderStatusCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            case 1:
                return [self acceptanceSituationCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            case 2:
                return [self logisticInfoCellWithTableView:tableView indexPath:indexPath];
                break;
            case 3:
                return [self recCarInfoCellWithTableView:tableView indexPath:indexPath expressModel:self.expressModel];
                break;
            case 4:
                return [self sendCarInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.expressModel];
                break;
            case 5:
                return [self carInfoCellWithTableView:tableView indexPath:indexPath carModel:self.carModel];
                break;
            case 6:
                return [self orderNumberInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            default:
                return [UITableViewCell new];
                break;
        }
        return nil;
    }
}

- (UITableViewCell *)unReceiveCarStateWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    BOOL isSeller = self.orderType == CarOrderTypeSold;
    if (isSeller) {
        switch (indexPath.row) {
            case 0:
                return [self orderStatusCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            case 1:
                return [self recCarInfoCellWithTableView:tableView indexPath:indexPath expressModel:self.expressModel];
                break;
            case 2:
                return [self sendCarInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.expressModel];
                break;
            case 3:
                return [self carInfoCellWithTableView:tableView indexPath:indexPath carModel:self.carModel];
                break;
            case 4:
                return [self orderNumberInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            default:
                return [UITableViewCell new];
                break;
        }
        return nil;
    }else{
        switch (indexPath.row) {
            case 0:
                return [self orderStatusCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            case 1:
                return [self logisticInfoCellWithTableView:tableView indexPath:indexPath];
                break;
            case 2:
                return [self recCarInfoCellWithTableView:tableView indexPath:indexPath expressModel:self.expressModel];
                break;
            case 3:
                return [self sendCarInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.expressModel];
                break;
            case 4:
                return [self carInfoCellWithTableView:tableView indexPath:indexPath carModel:self.carModel];
                break;
            case 5:
                return [self orderNumberInfoCellWithTableView:tableView indexPath:indexPath orderModel:self.orderModel];
                break;
            default:
                return [UITableViewCell new];
                break;
        }
        return nil;
    }
}

- (NSInteger)numberOfRowsWithStatus:(CarOrderState)orderState{
    BOOL isSeller = self.orderType == CarOrderTypeSold;
    switch (orderState) {
        case CarOrderStateUnPay:
        case CarOrderStateUnSendCar:
            return 5;
            break;
        case CarOrderStateUnReceiveCar:
            return isSeller?5:6;
            break;
        case CarOrderStateUnComment:
        case CarOrderStateSucceed:
        case CarOrderStateCancel:
        case CarOrderStateRefund:
        case CarOrderStateRefundSellerDo:
        case CarOrderStateRefundSysDo:
            return isSeller?6:7;
            break;
        default:
            return 0;
            break;
    }
}
#pragma mark - 创建底部按钮
- (void)initOrderDetailComponentsWithStatus:(CarOrderState)orderState{
    if (self.orderType == CarOrderTypeBought) {
        switch (orderState) {
            case CarOrderStateUnPay:
                [self myBuyCarWaitPay];
                break;
            case CarOrderStateUnSendCar:
                [self myBuyCarWaitSend];
                break;
            case CarOrderStateUnReceiveCar:
                [self myBuyCarWaitRec];
                break;
            case CarOrderStateUnComment:
                [self commonWaitComment];
                break;
            case CarOrderStateSucceed:
            case CarOrderStateCancel:
            case CarOrderStateRefund:
            case CarOrderStateRefundSellerDo:
            case CarOrderStateRefundSysDo:
                [self finish];
                break;
            default:
                break;
        }
    }else{
        switch (orderState) {
            case CarOrderStateUnPay:
                [self mySellCarWaitPay];
                break;
            case CarOrderStateUnSendCar:
                [self mySellCarWaitSend];
                [self showSendCarIntro];
                break;
            case CarOrderStateUnReceiveCar:
                [self finish];
                break;
            case CarOrderStateUnComment:
                [self commonWaitComment];
                break;
            case CarOrderStateRefund:
                [self mySellCarRefundManage];
                break;
            case CarOrderStateSucceed:
            case CarOrderStateCancel:
            case CarOrderStateRefundSysDo:
                [self finish];
                break;
            case CarOrderStateRefundSellerDo:
                [self mySellCarRefundManage];
                break;
            default:
                break;
        }
    }
}


/**
 *  我买的车-待付款
 */
- (void)myBuyCarWaitPay{
    CYTWeakSelf
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";
    NSString *cancelImage = @"ic_deselect_hl";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方",@"取消订单",@"去支付"] imageNames:@[serverImage,contactImage,cancelImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [weakSelf contact];
    } thirdBtnClick:^{
        [self cancelOrderOperation];
    } fourthBtnClick:^{
        [self gotoPay];
    }];
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}

/**
 *  我买的车-待发车
 */
- (void)myBuyCarWaitSend{
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";
    NSString *cancelImage = @"ic_deselect_hl";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方",@"取消订单",@"叫个物流"] imageNames:@[serverImage,contactImage,cancelImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self contact];
    } thirdBtnClick:^{
        [self cancelOrderOperation];
    } fourthBtnClick:^{
        [self callLogistic];
    }];
    
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}
/**
 *  我买的车-待成交
 */
- (void)myBuyCarWaitRec{
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";

    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar spe_orderDetailToolBarWithTitles:@[@"客服",@"联系对方",@"叫个物流",@"确认成交"] imageNames:@[serverImage,contactImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self contact];
    } thirdBtnClick:^{
        [self callLogistic];
    } fourthBtnClick:^{
        [self confirmRecCar];
    }];

    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}
/**
 *  待评价-买卖方
 */
- (void)commonWaitComment{
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方",@"去评价"] imageNames:@[serverImage,contactImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self contact];
    } thirdBtnClick:^{
        [self evaluate];
    } fourthBtnClick:nil];
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
    //自动弹出评价界面
    !self.showCommentView?:[self evaluate];
}
/**
 *  我卖的车-待付款
 */
- (void)mySellCarWaitPay{
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *cancelImage = @"ic_deselect_hl";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"取消订单",@"联系对方"] imageNames:@[serverImage,cancelImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self cancelOrderOperation];
    } thirdBtnClick:^{
        [self contact];
    } fourthBtnClick:nil];
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}
/**
 *  卖家发车引导
 */
- (void)showSendCarIntro{
    FFBasicSupernatantViewModel *vm = [FFBasicSupernatantViewModel new];
    CYTSendCarSupernatant *supernatant = [[CYTSendCarSupernatant alloc] initWithViewModel:vm];
    [vm setBgClickedBlock:^{
        [supernatant ff_hideSupernatantView];
    }];
    [supernatant ff_showSupernatantView];
}
/**
 *  我卖的车-待接单
 */
- (void)mySellCarWaitSend{
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";
    NSString *cancelImage = @"ic_deselect_hl";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方",@"取消订单",@"确认接单"] imageNames:@[serverImage,contactImage,cancelImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self contact];
    } thirdBtnClick:^{
        [self cancelOrderOperation];
    } fourthBtnClick:^{
        [self confirmSendCarOperation];
    }];
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}
/**
 *  我卖的车-退款管理
 */
- (void)mySellCarRefundManage{
    NSString *serverImage = @"ic_kefu_hl_new";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"不同意",@"同意"] imageNames:@[serverImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self sellerResuseOperationWithAgree:NO];
    } thirdBtnClick:^{
        [self sellerResuseOperationWithAgree:YES];
    } fourthBtnClick:nil];
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}
/**
 *  联系对方
 */
- (void)contact{
    NSString *contactPhoneNum = [NSString string];
    if (self.orderType == CarOrderTypeBought) {
        contactPhoneNum = self.expressModel.senderPhone;
    }else{
        contactPhoneNum = self.expressModel.receiverPhone;
    }
    [CYTPhoneCallHandler makePhoneWithNumber:contactPhoneNum alert:@"联系对方?" resultBlock:nil];
}

/**
 *  通用-联系对方
 */
- (void)finish{
    NSString *serverImage = @"ic_kefu_hl_new";
    CYTOrderBottomToolBar *bottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系对方"] imageNames:@[serverImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        [self contact];
    } thirdBtnClick:nil fourthBtnClick:nil];
    
    [self.view addSubview:bottomToolBar];
    _bottomToolBar = bottomToolBar;
    _bottomToolBar = bottomToolBar;
    [bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}

/**
 *  取消订单操作
 */
- (void)cancelOrderOperation{
    CYTWeakSelf
    NSInteger logisticsStatus = self.orderModel.logisticsStatus;
    NSString *logisticsCancelTip = self.orderModel.logisticsCancelTip;
    if (logisticsStatus == 1) {
        [CYTAlertView alertViewWithTitle:@"提示" message:logisticsCancelTip confirmAction:^{
            [weakSelf cancelOrder];
        } cancelAction:nil];
        return;
    }
    if (logisticsStatus == 2) {
        [CYTToast errorToastWithMessage:logisticsCancelTip];
        return;
    }
    [weakSelf cancelOrder];
}
/**
 *  取消订单（卖家/买家）
 */
- (void)cancelOrder{
    CYTOrderExtendType orderExtendType = self.orderType == CarOrderTypeBought?CYTOrderExtendTypeBuyerCancel:CYTOrderExtendTypeSellerCancel;
    CarOrderState carOrderState = self.orderModel.orderStatus;
    CYTOrderExtendViewController *orderDetailViewController = [CYTOrderExtendViewController orderExtendWithExtendType:orderExtendType orderStatus:carOrderState orderId:self.orderId];
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}
/**
 *  去支付
 */
- (void)gotoPay{
    CYTPaymentModel *model = [CYTPaymentModel new];
    model.orderId = self.orderId;
    model.paymentType = PaymentType_dingjin;;
    model.payType = PayType_zhifubao;
    model.sourceType = PaySourceTypeOrderDetail;
    [CYTPaymentManager getPayInfoWithModel:model andSuperController:self];
}
/**
 *  确认发车操作
 */
- (void)confirmSendCarOperation{
    CYTWeakSelf
    if (self.orderModel.logisticsStatus != 0) {//使用了物流
        [CYTAlertView alertViewWithTitle:@"提示" message:@"买家已叫物流，请和买家核对物流信息后再确认接单" confirmAction:^{
            [weakSelf confirmSendCar];
        } cancelAction:nil];
    }else{
        [weakSelf confirmSendCar];
    }
}
/**
 *  确认发车
 */
- (void)confirmSendCar{
    CYTConfirmSendCarViewController *confirmSendCarViewController = [[CYTConfirmSendCarViewController alloc] init];
    confirmSendCarViewController.orderId = self.orderId;
    [self.navigationController pushViewController:confirmSendCarViewController animated:YES];
}
/**
 *  叫个物流
 */
- (void)callLogistic{
    CYTLogisticsNeedWriteVM *vm = [CYTLogisticsNeedWriteVM new];
    vm.needGetLogisticInfo = YES;
    vm.orderId = [self.orderId integerValue];
    CYTLogisticsNeedWriteTableController *need = [[CYTLogisticsNeedWriteTableController alloc] initWithViewModel:vm];
    [self.navigationController pushViewController:need animated:YES];
}
/**
 *  去评价
 */
- (void)evaluate{
    [self.commentPublishView showNow];
}

/**
 *  确认收车
 */
- (void)confirmRecCar{
    CarOrderState carOrderState = self.orderModel.orderStatus;
    CYTOrderExtendViewController *orderDetailViewController = [CYTOrderExtendViewController orderExtendWithExtendType:CYTOrderExtendTypeConfirmRecCar orderStatus:carOrderState orderId:self.orderId];
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}

/**
 *  卖家退款处理
 */
- (void)sellerResuseOperationWithAgree:(BOOL)aggre{
    CYTWeakSelf
    NSString *refundMoney = self.orderModel.refundMoney.length?self.orderModel.refundMoney:@"";
    NSString *tipMsg = aggre?[NSString stringWithFormat:@"同意买家申请退款%@元",refundMoney]:@"不同意退订金给买家，申请系统处理。";
    [CYTAlertView alertViewWithTitle:@"提示" message:tipMsg confirmAction:^{
        [self.sellerRefundProcPar setValue:[NSNumber numberWithBool:aggre] forKey:@"isAgree"];
        [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        [CYTNetworkManager POST:kURL.order_Refund_SellerRefundProc parameters:self.sellerRefundProcPar dataTask:^(NSURLSessionDataTask *dataTask) {
            self.sessionDataTask = dataTask;
        } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            if (responseObject.resultEffective) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderListKey object:nil];
                [weakSelf requestOrderDetailData];
            }
        }];
    } cancelAction:nil];

}

- (void)reloadData{
    [self requestOrderDetailData];
}

/**
 * 返回操作的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    if (self.isSeekCarCommitPushed) {
        NSUInteger index = 0;
        for (UIViewController *subViewController in self.navigationController.viewControllers) {
            if ([subViewController isKindOfClass:[CYTSeekCarDetailViewController class]]) {
                index = [self.navigationController.viewControllers indexOfObject:subViewController];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_CarSourceList object:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
        
    }else if (self.isCarSourceCommitPushed){
        NSUInteger index = 0;
        for (UIViewController *subViewController in self.navigationController.viewControllers) {
            if ([subViewController isKindOfClass:[CYTCarSourceDetailTableController class]]) {
                index = [self.navigationController.viewControllers indexOfObject:subViewController];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefresh_CarSourceList object:nil];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
    }else{
        [super backButtonClick:backButton];
    }
}


@end
