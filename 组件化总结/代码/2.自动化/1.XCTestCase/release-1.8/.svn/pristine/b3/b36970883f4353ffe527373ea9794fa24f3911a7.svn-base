//
//  CYTCertificationPreviewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderCommitController.h"
#import "CYTConfirmOrderInfoParameters.h"
#import "CYTLogisticInfoCell.h"
#import "CYTPriceInfoCell.h"
#import "CYTLogisticSendCarInfoCell.h"
#import "CYTLogisticRecCarInfoCell.h"
#import "CYTConfirmOrderInfoModel.h"
#import "CYTPaymentModel.h"
#import "CYTPaymentManager.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTMyCouponViewController.h"
#import "CYTCouponListItemModel.h"
#import "CYTCreateOrderParameters.h"

@interface CYTLogisticsOrderCommitController ()<UITableViewDataSource,UITableViewDelegate>

/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;
/** 物流订单模型 */
@property(strong, nonatomic) CYTConfirmOrderInfoModel *confirmOrderInfoModel;
/** 创建订单参数 */
@property(strong, nonatomic) CYTCreateOrderParameters *createOrderParameters;
/** 发车信息cell */
@property(strong, nonatomic) CYTLogisticSendCarInfoCell *sendCarInfoCell;
/** 收车信息cell */
@property(strong, nonatomic) CYTLogisticRecCarInfoCell *recCarInfoCell;
/** 卡券模型 */
@property(strong, nonatomic) CYTCouponListItemModel *couponListItemModel;
/** 费用总计 */
@property(assign, nonatomic) CGFloat originTotalPrice;

@end

@implementation CYTLogisticsOrderCommitController
{
    CYTConfirmOrderInfoParameters *_confirmOrderInfoParameters;
}

- (CYTConfirmOrderInfoParameters *)confirmOrderInfoParameters{
    if (!_confirmOrderInfoParameters) {
        _confirmOrderInfoParameters = [[CYTConfirmOrderInfoParameters alloc] init];
    }
    return _confirmOrderInfoParameters;
}


- (UITableView *)mainView{
    if (!_mainView) {
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY-CYTMarginV-CYTAutoLayoutV(80));
        _mainView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainView.estimatedSectionFooterHeight = 0;
            _mainView.estimatedSectionHeaderHeight = 0;
        }
        _mainView.contentInset = UIEdgeInsetsMake(0, 0, CYTAutoLayoutV(20.f), 0);
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self logisticsOrderCommitBasicConfig];
    [self configorderMainView];
    [self initLogisticsOrderCommitComponents];
    [self requestLogisticsOrderData];
}

/**
 *  基本配置
 */
- (void)logisticsOrderCommitBasicConfig{
    [self createNavBarWithTitle:@"提交物流订单" andShowBackButton:YES showRightButtonWithTitle:@"帮助"];
    //关闭手势返回
    self.interactivePopGestureEnable = NO;
    self.view.backgroundColor = CYTLightGrayColor;
    //创建订单参数
    self.createOrderParameters = [[CYTCreateOrderParameters alloc] init];
    self.createOrderParameters.couponCode = @"";
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
    self.mainView.estimatedRowHeight = CYTAutoLayoutV(90);
    self.mainView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.mainView];
}
/**
 *  初始化子控件
 */
- (void)initLogisticsOrderCommitComponents{
    //提交订单
    UIButton *commitOrderBtn = [UIButton buttonWithTitle:@"提交订单" enabled:YES];
    [self.view addSubview:commitOrderBtn];
    //布局
    [commitOrderBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTMarginH);
        make.right.equalTo(self.view).offset(-CYTMarginH);
        make.bottom.equalTo(self.view).offset(-CYTMarginV);
        make.height.equalTo(CYTAutoLayoutV(80.f));
    }];
    CYTWeakSelf
    //点击的实现
    [[commitOrderBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //参数取值
        weakSelf.createOrderParameters.demandPriceId = weakSelf.confirmOrderInfoParameters.demandPriceId;
        weakSelf.createOrderParameters.sDetailedAddress = weakSelf.sendCarInfoCell.sDetailAddress;
        weakSelf.createOrderParameters.senderName = weakSelf.sendCarInfoCell.senderName;
        weakSelf.createOrderParameters.senderTel = weakSelf.sendCarInfoCell.senderTel;
        weakSelf.createOrderParameters.rDetailedAddress = weakSelf.recCarInfoCell.rDetailAddress;
        weakSelf.createOrderParameters.receiverName = weakSelf.recCarInfoCell.receiverName;
        weakSelf.createOrderParameters.receiverTel = weakSelf.recCarInfoCell.receiverTel;
        weakSelf.createOrderParameters.receiverIdentityNo = weakSelf.recCarInfoCell.receiverIdentityNo;
        //校验
        if (!weakSelf.createOrderParameters.sDetailedAddress.length) {
            [CYTToast warningToastWithMessage:@"请输入发车地详细地址"];
        }else if (!weakSelf.createOrderParameters.senderName.length) {
            [CYTToast warningToastWithMessage:@"请输入发车人姓名"];
        }else if (![CYTCommonTool isChinese:weakSelf.createOrderParameters.senderName]){
            [CYTToast warningToastWithMessage:CYTNameOnlyChinese];
        }else if (!weakSelf.createOrderParameters.senderTel.length){
            [CYTToast warningToastWithMessage:@"请输入发车人手机号"];
        }else if (![CYTCommonTool isPhoneNumber:weakSelf.createOrderParameters.senderTel]){
            [CYTToast warningToastWithMessage:CYTAccountError];
        }else if (!weakSelf.createOrderParameters.rDetailedAddress.length){
            [CYTToast warningToastWithMessage:@"请输入收车地详细地址"];
        }else if (!weakSelf.createOrderParameters.receiverName.length){
            [CYTToast warningToastWithMessage:@"请输入收车人姓名"];
        }else if (![CYTCommonTool isChinese:weakSelf.createOrderParameters.receiverName]){
            [CYTToast warningToastWithMessage:CYTNameOnlyChinese];
        }else if (!weakSelf.createOrderParameters.receiverTel.length){
            [CYTToast warningToastWithMessage:@"请输入收车人手机号"];
        }else if (![CYTCommonTool isPhoneNumber:weakSelf.createOrderParameters.receiverTel]){
            [CYTToast warningToastWithMessage:CYTAccountError];
        }else if (!weakSelf.createOrderParameters.receiverIdentityNo.length){
            [CYTToast warningToastWithMessage:@"请输入收车人身份证号"];
        }else if (![CYTCommonTool validateIDCardNumber:weakSelf.createOrderParameters.receiverIdentityNo]){
            [CYTToast warningToastWithMessage:CYTIdCardError];
        }else{
            CYTWeakSelf
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
            [CYTNetworkManager POST:kURL.order_express_CreateExpressOrder parameters:weakSelf.createOrderParameters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
                self.sessionDataTask = dataTask;
            } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
                [CYTLoadingView hideLoadingView];
                if (responseObject.resultEffective) {
                    //详情
                    CYTLogisticsOrderDetail3DController *logisticsOrderDetailController = [[CYTLogisticsOrderDetail3DController alloc] init];
                    logisticsOrderDetailController.logisticsOrderPushed = YES;
                    logisticsOrderDetailController.orderId = [responseObject.dataDictionary valueForKey:@"orderId"];
                    NSMutableArray *mArray = [weakSelf.navigationController.viewControllers mutableCopy];
                    [mArray addObject:logisticsOrderDetailController];
                    [weakSelf.navigationController setViewControllers:mArray animated:NO];
                    
                    //提交已成功 刷新 物流需求订单详情页面
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticsOrderCommitSuccessNotkey object:nil];
                    
                    //支付
                    CYTPaymentModel *model = [CYTPaymentModel new];
                    model.orderId = [responseObject.dataDictionary valueForKey:@"orderId"];
                    model.paymentType = PaymentType_logistics;
                    model.payType = PayType_zhifubao;
                    model.sourceType = PaySourceTypeLogistics;
                    [CYTPaymentManager getPayInfoWithModel:model andSuperController:weakSelf];
                }
            }];

        }
    }];
}

#pragma mark - <UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://物流信息
            return [self logisticInfoCellWithTableView:tableView indexPath:indexPath logisticInfoModel:self.confirmOrderInfoModel];
            break;
        case 1://价格相关
            return [self priceInfoCellWithTableView:tableView indexPath:indexPath logisticInfoModel:self.confirmOrderInfoModel];
            break;
        case 2://发车信息
            return [self sendCarInfoCellWithTableView:tableView indexPath:indexPath logisticInfoModel:self.confirmOrderInfoModel];
            break;
        case 3://收车信息
            return [self recCarInfoCellWithTableView:tableView indexPath:indexPath logisticInfoModel:self.confirmOrderInfoModel];
            break;
        default:
            return nil;
            break;
      }
    
}
/**
 * 物流信息
 */
- (CYTLogisticInfoCell *)logisticInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    CYTLogisticInfoCell *cell = [CYTLogisticInfoCell cellForTableView:tableView indexPath:indexPath logisticOrderModel:nil];
    cell.confirmOrderInfoModel = confirmOrderInfoModel;
    return cell;
}

/**
 *  价格相关
 */
- (CYTPriceInfoCell *)priceInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    CYTPriceInfoCell *cell = [CYTPriceInfoCell cellForTableView:tableView indexPath:indexPath];
    CYTWeakSelf
    cell.availableCouponClick = ^{
        CYTMyCouponViewController *myCouponViewController = [CYTMyCouponViewController myCouponWithCouponCardType:CYTMyCouponCardTypeSelect];
        myCouponViewController.demandPriceId = weakSelf.confirmOrderInfoParameters.demandPriceId;
        myCouponViewController.couponListItemModel = weakSelf.couponListItemModel;
        myCouponViewController.couponSelectBlock = ^(CYTCouponListItemModel *couponListItemModel) {
            weakSelf.couponListItemModel = couponListItemModel;
            weakSelf.createOrderParameters.couponCode = couponListItemModel.couponCode;
            if (couponListItemModel.couponType == CYTCouponTypeVoucher) {//抵用
                self.confirmOrderInfoModel.reduceMoney = couponListItemModel.reduceMoney;
                CGFloat afterPrice = self.originTotalPrice - [couponListItemModel.reduceMoney floatValue];
                afterPrice = afterPrice>0?afterPrice:0;
                self.confirmOrderInfoModel.totalPrice = [NSString stringWithFormat:@"%.2f",afterPrice];
            }else if (couponListItemModel.couponType == CYTCouponTypeFreeShipping){//包邮
                self.confirmOrderInfoModel.reduceMoney = [NSString stringWithFormat:@"%.2f",self.originTotalPrice];
                self.confirmOrderInfoModel.totalPrice = @"0";
            }
            [self.mainView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
        [weakSelf.navigationController pushViewController:myCouponViewController animated:YES];
    };
    cell.confirmOrderInfoModel = confirmOrderInfoModel;
    return cell;
}

/**
 *  发车信息
 */
- (CYTLogisticSendCarInfoCell *)sendCarInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    CYTLogisticSendCarInfoCell *cell = [CYTLogisticSendCarInfoCell cellForTableView:tableView indexPath:indexPath];
    self.sendCarInfoCell = cell;
    cell.confirmOrderInfoModel = confirmOrderInfoModel;
    return cell;
}
/**
 *  收车信息
 */
- (CYTLogisticRecCarInfoCell *)recCarInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath logisticInfoModel:(CYTConfirmOrderInfoModel *)confirmOrderInfoModel{
    CYTLogisticRecCarInfoCell *cell = [CYTLogisticRecCarInfoCell cellForTableView:tableView indexPath:indexPath];
    self.recCarInfoCell = cell;
    cell.confirmOrderInfoModel = confirmOrderInfoModel;
    return cell;
}
/**
 * 获取订单信息
 */
- (void)requestLogisticsOrderData{
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar inView:self.view];
    [CYTNetworkManager GET:kURL.order_express_ConfirmOrderInfo parameters:self.confirmOrderInfoParameters.mj_keyValues dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.errorCode>400) {
            [self showNoNetworkViewInView:self.view];
        }else {
            if (responseObject.resultEffective) {
                self.confirmOrderInfoModel = [CYTConfirmOrderInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
                self.originTotalPrice = [self.confirmOrderInfoModel.totalPrice floatValue];
                [self.mainView reloadData];
            }
        }
    }];
}
/**
 * 重新加载
 */
- (void)reloadData{
    [self requestLogisticsOrderData];
}
/**
 * 设置报价Id
 */
- (void)setConfirmOrderInfoParameters:(CYTConfirmOrderInfoParameters *)confirmOrderInfoParameters{
    _confirmOrderInfoParameters = confirmOrderInfoParameters;
    self.createOrderParameters.demandPriceId = confirmOrderInfoParameters.demandPriceId;
}


@end
