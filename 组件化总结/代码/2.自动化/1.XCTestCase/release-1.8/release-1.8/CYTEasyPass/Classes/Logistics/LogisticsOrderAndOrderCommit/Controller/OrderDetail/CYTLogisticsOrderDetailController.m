//
//  CYTCertificationPreviewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderDetailController.h"
#import "CYTLogisticsOrderStatusCell.h"
#import "CYTLogisticOrderProgressCell.h"
#import "CYTLogisticInfoCell.h"
#import "CYTTotalExpensesCell.h"
#import "CYTSendCarDetailInfoCell.h"
#import "CYTRecCarDetailInfoCell.h"
#import "CYTTransportCodeCell.h"
#import "CYTLogisticLogCell.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTLogisticOrderData.h"
#import "CYTLogisticOrderModel.h"
#import "CYTLogisticDemandModel.h"
#import "CYTLogisticDemandPriceModel.h"
#import "CYTLogisticTranOrderModel.h"
#import "CYTLogisticLogModel.h"
#import "CYTPaymentManager.h"
#import "CYTLogisticsNeedDetailTableController.h"
#import "CYTLogisticOrderDetaiParameters.h"
#import "CYTDealerCommentPublishView.h"
#import "CYTLogisticsOrderList.h"
#import "CYTCardView.h"

@interface CYTLogisticsOrderDetailController ()<UITableViewDataSource,UITableViewDelegate>

/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;
/** 订单日志 */
@property(strong, nonatomic) NSArray *logsData;
/** 订单页面请求参数 */
@property(strong, nonatomic) CYTLogisticOrderDetaiParameters *logisticOrderDetaiParameters;
/** 订单数据 */
@property(strong, nonatomic) CYTLogisticOrderModel *logisticOrderModel;
/** 车辆详情 */
@property(strong, nonatomic)  CYTLogisticDemandModel *logisticDemandModel;
/** 物流需求报价 */
@property(strong, nonatomic) CYTLogisticDemandPriceModel *logisticDemandPriceModel;
/** 运单 */
@property(strong, nonatomic) CYTLogisticTranOrderModel *logisticTranOrderModel;
/** 支付成功的标记 */
@property(assign, nonatomic,getter=isPaySuccess) BOOL paySuccess;
/** 是否有运单号 */
@property(assign, nonatomic,getter=isShowExpressCode) BOOL showExpressCode;
/** 底部按钮 */
@property(strong, nonatomic) CYTOrderBottomToolBar *bottomToolBar;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;
/** 手动刷新 */
@property(assign, nonatomic) BOOL manualRefresh;
/** 确认收车弹出美女 */
@property(assign, nonatomic) BOOL confirmRecCarShowGuide;
@end

@implementation CYTLogisticsOrderDetailController

- (NSArray *)logsData{
    if (!_logsData) {
        _logsData = [NSArray array];
        
    }
    return _logsData;
}


- (UITableView *)mainView{
    if (!_mainView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY);
        _mainView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainView.estimatedSectionFooterHeight = 0;
            _mainView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self logisticsOrderDetailBasicConfig];
    [self configorderMainView];
    [self initLogisticsOrderDetailComponents];
    [self refreshData];

}

//有评价功能 1）禁止自动滚动 2）不使用toolbar------>>>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
//<<<<---------------------------------------------

/**
 *  基本配置
 */
- (void)logisticsOrderDetailBasicConfig{
    [self createNavBarWithTitle:@"物流订单详情" andShowBackButton:YES showRightButtonWithTitle:@"帮助"];
    self.interactivePopGestureEnable = YES;
    self.confirmRecCarShowGuide = YES;
    self.view.backgroundColor = CYTLightGrayColor;
    //订单详情参数
    self.logisticOrderDetaiParameters = [[CYTLogisticOrderDetaiParameters alloc] init];
    self.logisticOrderDetaiParameters.orderId = self.orderId;
    
    //手势返回处理
    self.interactivePopGestureEnable = !self.logisticsOrderPushed;
    
    //支付成功的通知处理
    CYTWeakSelf
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLogisticsOrderPaySuccessNotkey object:nil] subscribeNext:^(id x) {
        weakSelf.paySuccess = YES;
        self.interactivePopGestureEnable = !weakSelf.paySuccess;
        //刷新表格
        [self.mainView.mj_header beginRefreshing];
    }];
}
/**
 *  右item点击事件
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    CYTH5WithInteractiveCtr *ctr = [[CYTH5WithInteractiveCtr alloc] init];
    ctr.requestURL = kURL.kURLLogistics_publishNeed_help;
    [self.navigationController pushViewController:ctr animated:YES];
}
/**
 *  配置表格
 */
- (void)configorderMainView{
    self.mainView.backgroundColor = CYTLightGrayColor;
    self.mainView.delegate = self;
    self.mainView.dataSource = self;
    self.mainView.tableFooterView = [[UIView alloc] init];
    self.mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainView.estimatedRowHeight = CYTAutoLayoutV(100);
    self.mainView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mainView];
    
    //下拉刷新
    self.mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestLogisticsOrderDetailDataWithShowLoadingView:NO];
    }];
}
/**
 *  初始化子控件
 */
- (void)initLogisticsOrderDetailComponents{
    if ([self.orderId integerValue] == 0) {
        self.noDataView.content = @"抱歉，该订单未使用平台物流\n- 暂无实时状态 -";
        self.noDataView.imageName = @"bg_manage_dl";
        [self showNoDataView];
    }
}
/**
 *  加载数据
 */
- (void)refreshData{
    [self requestLogisticsOrderDetailDataWithShowLoadingView:YES];
}

/**
 *  显示去评价引导
 */
- (void)showCommentGuideView{
    if (!CYTValueForKey(CYTCardViewLogisticCommentNeverShowKey)) {
        CYTCardView *carView = [CYTCardView showCardViewWithType:CYTCardViewTypeLogisticComment];
        carView.operationBtnClick = ^(BOOL neverShowAgain){
            [self.commentPublishView showNow];
        };
    }
}

/**
 *  设置底部按钮
 */
- (void)setBottomToolBarWithLogisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTLogisticsOrderStatus logisticsOrderStatus = logisticOrderModel.orderStatus;
    !self.bottomToolBar?:[self.bottomToolBar removeFromSuperview];
    if (logisticOrderModel.orderStatus<0) {//取消
        _mainView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(20.f), 0);
    }else{
        _mainView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(20.f) + CYTAutoLayoutV(98.f), 0);
        switch (logisticsOrderStatus) {
            case CYTLogisticsOrderStatusWaitPay:
               self.bottomToolBar = [self commonBottomBarWithModel:logisticOrderModel title:@"去支付"];
                break;
            case CYTLogisticsOrderStatusWaitMatchingBoard:
            case CYTLogisticsOrderStatusWaitDriver:
            case CYTLogisticsOrderStatusInTransit:
                self.bottomToolBar = [self commonBottomBarWithModel:logisticOrderModel title:@"确认收车"];
                break;
            case CYTLogisticsOrderStatusFinishUnComment:
               self.bottomToolBar =  [self commonBottomBarWithModel:logisticOrderModel title:@"去评价"];
                break;
            case CYTLogisticsOrderStatusFinishCommented:
               self.bottomToolBar =  [self completionBottomBarWithModel:logisticOrderModel];
                break;
            default:
                break;
        }
        if ([self.orderId integerValue] != 0) {
            [self.view addSubview:self.bottomToolBar];
            [self.bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.view);
                make.height.equalTo(CYTAutoLayoutV(98.f));
            }];
        }
    }
}

#pragma mark - 按钮设置
/**
 *  非“完成按钮”
 */
- (CYTOrderBottomToolBar *)commonBottomBarWithModel:(CYTLogisticOrderModel *)logisticOrderModel title:(NSString *)title{
    NSString *serverImage = @"ic_kefu_hl_new";
    NSString *contactImage = @"ic_phone_hl_new";
    CYTLogisticsOrderStatus logisticsOrderStatus = logisticOrderModel.orderStatus;
    return [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系物流公司",title] imageNames:@[serverImage,contactImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        NSString *logisticsPhoneNum = logisticOrderModel.logisticsPhoneNum;
        if (!logisticsPhoneNum || !logisticsPhoneNum.length) {
            logisticsPhoneNum = kServicePhoneNumer;
        }
        [CYTPhoneCallHandler makePhoneWithNumber:logisticsPhoneNum alert:@"确定要联系物流公司？" resultBlock:nil];
    } thirdBtnClick:^{
        switch (logisticsOrderStatus) {
            case CYTLogisticsOrderStatusWaitPay:
                [self payWithModel:logisticOrderModel];
                break;
            case CYTLogisticsOrderStatusWaitMatchingBoard:
                [self confirmRecCarOperetionWithModel:logisticOrderModel];
                break;
            case CYTLogisticsOrderStatusWaitDriver:
            case CYTLogisticsOrderStatusInTransit:
                [self confirmRecCarOperetionWithModel:logisticOrderModel];
                break;
            case CYTLogisticsOrderStatusFinishUnComment:
                [self goCommentWithModel:logisticOrderModel];
                break;
            default:
                break;
        }
    } fourthBtnClick:nil];
}
/**
 *  去支付
 */
- (void)payWithModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTPaymentModel *model = [CYTPaymentModel new];
    model.orderId = [NSString stringWithFormat:@"%ld",(long)self.logisticOrderModel.orderId];
    model.paymentType = PaymentType_logistics;
    model.payType = PayType_zhifubao;
    model.sourceType = PaySourceTypeLogistics;
    [CYTPaymentManager getPayInfoWithModel:model andSuperController:self];
}
/**
 *  确认收车提示
 */
- (void)confirmRecCarOperetionWithModel:(CYTLogisticOrderModel *)logisticOrderModel{
    [CYTAlertView alertViewWithTitle:@"提示" message:@"请您确认已收到托运车辆后再点击确认收车" confirmAction:^{
        [self confirmRecCarWithModel:logisticOrderModel];
    } cancelAction:nil];
}
/**
 *  确认收车
 */
- (void)confirmRecCarWithModel:(CYTLogisticOrderModel *)logisticOrderModel{
    NSMutableDictionary *par = NSMutableDictionary.new;
    [par setValue:@(logisticOrderModel.orderId)forKey:@"orderId"];
    [CYTNetworkManager POST:kURL.order_express_sureorderover parameters:par dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.resultEffective) {
            self.confirmRecCarShowGuide = YES;
            [self requestLogisticsOrderDetailDataWithShowLoadingView:YES];
            [CYTToast successToastWithMessage:responseObject.resultMessage];
        }else{
           self.confirmRecCarShowGuide = NO;
        }
    }];
}
/**
 *  去评价
 */
- (void)goCommentWithModel:(CYTLogisticOrderModel *)logisticOrderModel{
    [self.commentPublishView showNow];
}
/**
 *  完成“联系物流公司”
 */
- (CYTOrderBottomToolBar *)completionBottomBarWithModel:(CYTLogisticOrderModel *)logisticOrderModel{
    NSString *serverImage = @"ic_kefu_hl_new";
    return [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"联系物流公司"] imageNames:@[serverImage] firstBtnClick:^{
        [CYTPhoneCallHandler makeServicePhone];
    } secondBtnClick:^{
        NSString *logisticsPhoneNum = logisticOrderModel.logisticsPhoneNum;
        if (!logisticsPhoneNum || !logisticsPhoneNum.length) {
            logisticsPhoneNum = kServicePhoneNumer;
        }
        [CYTPhoneCallHandler makePhoneWithNumber:logisticsPhoneNum alert:@"确定要联系物流公司？" resultBlock:nil];
    } thirdBtnClick:nil fourthBtnClick:nil];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.isShowExpressCode?7:6;
    }else{
        return self.logsData.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0://订单状态
                return [self orderStatusCellWithTableView:tableView indexPath:indexPath logisticOrderModel:self.logisticOrderModel];
                break;
            case 1://订单进度
                return [self orderProgressCellWithTableView:tableView indexPath:indexPath logisticOrderModel:self.logisticOrderModel];
                break;
            case 2://物流信息
                return [self logisticInfoCellWithTableView:tableView indexPath:indexPath logisticDemandModel:self.logisticDemandModel logisticDemandPriceModel:self.logisticDemandPriceModel logisticOrderModel:self.logisticOrderModel];
                break;
            case 3://费用合计
                return [self totalExpensesCellWithTableView:tableView indexPath:indexPath logisticDemandPriceModel:self.logisticDemandPriceModel];
                break;
            case 4://发车人详情
                return [self sendCarDetailInfoCellWithTableView:tableView indexPath:indexPath logisticDemandModel:self.logisticDemandModel];
                break;
            case 5://收车人详情
                return [self recCarDetailInfoCellWithTableView:tableView indexPath:indexPath logisticDemandModel:self.logisticDemandModel];
                break;
            case 6://运单号
                return [self transportCodeCellCellWithTableView:tableView indexPath:indexPath logisticTranOrderModel:self.logisticTranOrderModel];
                break;
            default:
                return nil;
                break;
        }

    }else{//订单日志
        CYTLogisticLogCell *cell = [self logisticLogCellCellWithTableView:tableView indexPath:indexPath logisticLogs:self.logsData];
        return cell;
    }
    
    
}
/**
 * 订单状态
 */
- (CYTLogisticsOrderStatusCell *)orderStatusCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTLogisticsOrderStatusCell *cell = [CYTLogisticsOrderStatusCell cellForTableView:tableView indexPath:indexPath];
    cell.logisticOrderModel = logisticOrderModel;
    return cell;
}

/**
 *  订单进度
 */
- (CYTLogisticOrderProgressCell *)orderProgressCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTLogisticOrderProgressCell *cell = [CYTLogisticOrderProgressCell cellForTableView:tableView indexPath:indexPath];
     cell.logisticOrderModel = logisticOrderModel;
    return cell;
}

/**
 *  物流信息
 */
- (CYTLogisticInfoCell *)logisticInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel logisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel logisticOrderModel:(CYTLogisticOrderModel *)logisticOrderModel{
    CYTLogisticInfoCell *cell = [CYTLogisticInfoCell cellForTableView:tableView indexPath:indexPath logisticOrderModel:logisticOrderModel];
    cell.logisticDemandModel = logisticDemandModel;
    cell.logisticDemandPriceModel = logisticDemandPriceModel;
    return cell;
}
/**
 *  费用合计
 */
- (CYTTotalExpensesCell *)totalExpensesCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticDemandPriceModel:(CYTLogisticDemandPriceModel *)logisticDemandPriceModel{
    CYTTotalExpensesCell *cell = [CYTTotalExpensesCell cellForTableView:tableView indexPath:indexPath];
    cell.logisticDemandPriceModel = logisticDemandPriceModel;
    cell.expensesDetailBlock = ^{
        !self.expensesDetailBlock?:self.expensesDetailBlock(self.logisticDemandPriceModel);
    };
    return cell;
}
/**
 *  发车人详情
 */
- (CYTSendCarDetailInfoCell *)sendCarDetailInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel{
    CYTSendCarDetailInfoCell *cell = [CYTSendCarDetailInfoCell cellForTableView:tableView indexPath:indexPath];
    cell.logisticDemandModel = logisticDemandModel;
    return cell;
}
/**
 *  收车人详情
 */
- (CYTRecCarDetailInfoCell *)recCarDetailInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticDemandModel:(CYTLogisticDemandModel *)logisticDemandModel{
    CYTRecCarDetailInfoCell *cell = [CYTRecCarDetailInfoCell cellForTableView:tableView indexPath:indexPath];
    cell.logisticDemandModel = logisticDemandModel;
    return cell;
}
/**
 *  运单号
 */
- (CYTTransportCodeCell *)transportCodeCellCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticTranOrderModel:(CYTLogisticTranOrderModel *)logisticTranOrderModel{
    CYTTransportCodeCell *cell = [CYTTransportCodeCell cellForTableView:tableView indexPath:indexPath];
    cell.logisticTranOrderModel = logisticTranOrderModel;
    return cell;
}

/**
 *  订单日志
 */
- (CYTLogisticLogCell *)logisticLogCellCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticLogs:(NSArray *)logsData{
    CYTLogisticLogCell *cell = [CYTLogisticLogCell cellForTableView:tableView indexPath:indexPath];
    cell.logisticLogModel = logsData[indexPath.row];
    return cell;
}
/**
 * 获取订单信息
 */
- (void)requestLogisticsOrderDetailDataWithShowLoadingView:(BOOL)showLoadingView{
    if ([self.orderId integerValue] == 0){
        [self.mainView.mj_header endRefreshing];
        return;
    }
    if (!self.logisticsOrderPushed) {
        !showLoadingView?:[CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar inView:self.view];
    }
    [CYTNetworkManager GET:kURL.order_express_getOrderDetail parameters:self.logisticOrderDetaiParameters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.errorCode>=400) {
            [self.mainView.mj_header endRefreshing];
            [self showNoNetworkView];
            [CYTLoadingView hideLoadingView];
        }else {
            [CYTLoadingView hideLoadingView];
            [self dismissNoNetworkView];
            [self.mainView.mj_header endRefreshing];
            if (responseObject.resultEffective) {
                CYTLogisticOrderData *logisticOrderData = [CYTLogisticOrderData mj_objectWithKeyValues:responseObject.dataDictionary];
                //订单
                self.logisticOrderModel = [CYTLogisticOrderModel mj_objectWithKeyValues:logisticOrderData.order];
                //车辆详情
                self.logisticDemandModel = [CYTLogisticDemandModel mj_objectWithKeyValues:logisticOrderData.demand];
                //物流需求报价
                self.logisticDemandPriceModel = [CYTLogisticDemandPriceModel mj_objectWithKeyValues:logisticOrderData.demandPrice];
                //运单
                self.logisticTranOrderModel = [CYTLogisticTranOrderModel mj_objectWithKeyValues:logisticOrderData.tranOrder];
                //日志
                self.logsData = [CYTLogisticLogModel mj_objectArrayWithKeyValuesArray:self.logisticTranOrderModel.logs];
                if (!showLoadingView && self.logisticOrderModel.orderStatus == CYTLogisticsOrderStatusFinishUnComment) {
                    self.manualRefresh = YES;
                }else{
                    self.manualRefresh = NO;
                }
                //运单号的显示与隐藏
                self.showExpressCode = self.logisticTranOrderModel.expressCode.length;
                [self setBottomToolBarWithLogisticOrderModel:self.logisticOrderModel];
                [self.mainView reloadData];
                //发布评价
                [self showCommentViewNow];
            }
        }
    }];

}
/**
 * 重新加载
 */
- (void)reloadData{
    [self.mainView.mj_header beginRefreshing];
}
/**
 * 返回操作的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    if (self.isLogisticsOrderPushed) {
        //返回物流需求详情
        NSUInteger index = 0;
        for (UIViewController *subViewController in self.navigationController.viewControllers) {
            if ([subViewController isKindOfClass:[CYTLogisticsNeedDetailTableController class]]) {
                index = [self.navigationController.viewControllers indexOfObject:subViewController];
            }
        }
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
    }else if (self.isPaySuccess){
        //返回订单列表
        NSUInteger index = 0;
        for (UIViewController *subViewController in self.navigationController.viewControllers) {
            if ([subViewController isKindOfClass:[CYTLogisticsOrderList class]]) {
                index = [self.navigationController.viewControllers indexOfObject:subViewController];
            }
        }
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
        
    }else{
        [super backButtonClick:backButton];
    }
}

#pragma mark- method
- (void)showCommentViewNow {
    if (!self.showCommentView && !self.manualRefresh && self.confirmRecCarShowGuide && self.logisticOrderModel.orderStatus == CYTLogisticsOrderStatusFinishUnComment) {
        [self showCommentGuideView];
    }
    //判断当前订单状态，如果是完成并且未评价状态则可以评价,并且只显示一次（此页面有下拉刷新）
    if (self.logisticOrderModel.orderStatus == CYTLogisticsOrderStatusFinishUnComment && self.showCommentView) {
        self.showCommentView = NO;
        [self.commentPublishView showNow];
    }
}

#pragma mark- get
- (CYTDealerCommentPublishView *)commentPublishView {
    if (!_commentPublishView) {
        CYTDealerCommentPublishModel *model = [CYTDealerCommentPublishModel new];
        //评价订单id
        model.orderId = self.orderId;
        
        CYTDealerCommentPublishVM *vm = [[CYTDealerCommentPublishVM alloc] initWithModel:model];
        vm.type = CommentViewTypeLogistics;
        
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

                //发送通知刷新物流订单列表
                [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticsOrderListRefreshKey object:nil];
                [self refreshData];
            }else{
                [CYTToast errorToastWithMessage:responseModel.resultMessage];
            }
        }];
        _commentPublishView = [[CYTDealerCommentPublishView alloc] initWithViewModel:vm];
        _commentPublishView.title = @"发布评价";
    }
    return _commentPublishView;
}

@end
