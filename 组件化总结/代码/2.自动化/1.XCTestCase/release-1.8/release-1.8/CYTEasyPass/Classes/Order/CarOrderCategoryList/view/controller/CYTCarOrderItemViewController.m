//
//  CYTCarOrderItemViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderItemViewController.h"
#import "CYTCarOrderItemCell.h"
#import "CYTCarOrderListViewController.h"
#import "CYTPaymentManager.h"
#import "CYTLogisticsNeedWriteTableController.h"
#import "CYTOrderDetailViewController.h"
#import "CYTOrderSenderCarInfo.h"
#import "CYTOrderExtendViewController.h"
#import "CYTConfirmSendCarViewController.h"

#define kDisagreeRefund     @"不同意退订金给买家，申请系统处理。"

@interface CYTCarOrderItemViewController ()<UITableViewDataSource,UITableViewDelegate,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation CYTCarOrderItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenNavigationBarLine = YES;
    [self bindViewModel];
    [self loadUI];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRefreshOrderListKey object:nil] subscribeNext:^(id x) {
       //订单列表刷新
        [self reloadOrderData];
    }];
}

- (void)reloadOrderData {
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.refundCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        if (responseModel.resultEffective) {
            //刷新当前列表
            [self reloadOrderData];
        }
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        //刷新气泡数量
        [self.orderList changeSegmentBubbleNumberWithModel:self.viewModel.stateNumberModel];
        //刷新列表
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = self.viewModel.listArray.count == 0;
            model.dataHasMore = self.viewModel.isMore;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
    }];
}

- (void)loadUI {
    [self.view addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark- 处理cell action 点击事件
- (void)handleActionWithModel:(CYTCarOrderItemModel_item *)model withIndex:(NSInteger)index {
    CarOrderState orderState = model.orderStatus;
    switch (orderState) {
        case CarOrderStateUnPay:
        {
            if (self.viewModel.orderType == CarOrderTypeBought) {
                //买
                if (index==0) {
                    [self cancelOrderWithModel:model andType:CarOrderTypeBought];
                }else {
                    [self payOrderWithModel:model];
                }
            }else {
                //卖
                [self cancelOrderWithModel:model andType:CarOrderTypeSold];
            }
        }
            break;
        case CarOrderStateUnSendCar:
        {
            if (self.viewModel.orderType == CarOrderTypeBought) {
                //买
                if (index==0) {
                    [self cancelOrderWithModel:model andType:CarOrderTypeBought];
                }else {
                    [self needLogisticsWithModel:model];
                }
            }else {
                //卖
                if (index == 0) {
                    [self cancelOrderWithModel:model andType:CarOrderTypeSold];
                }else{
                    [self affirmSendWithModel:model];
                }
            }
        }
            break;
        case CarOrderStateUnReceiveCar:
        {
            if (self.viewModel.orderType == CarOrderTypeBought) {
                //买
                if (index==0) {
                    [self sendCarInfoWithModel:model andType:CarOrderTypeBought];
                }else if (index == 1 ){
                    [self affirmReceiveWithModel:model];
                }else if (index == 5) {
                    //叫个物流
                    [self needLogisticsWithModel:model];
                }
            }else {
                //卖
                [self sendCarInfoWithModel:model andType:CarOrderTypeSold];
            }
        }
            break;
        case CarOrderStateUnComment:
        {
            if (self.viewModel.orderType == CarOrderTypeBought) {
                //买
                [self commentWithModel:model andType:CarOrderTypeBought];
            }else {
                //卖
                [self commentWithModel:model andType:CarOrderTypeSold];
            }
        }
            break;
        case CarOrderStateRefund:
        case CarOrderStateRefundSellerDo:
        case CarOrderStateRefundSysDo:
        {
            if (self.viewModel.orderType == CarOrderTypeBought) {
                //买//none
            }else {
                //卖
                [self refundWithModel:model andIndex:index];
            }
        }
        default:
            //all 不处理
            break;
    }
    
}

#pragma mark- action
///取消订单
- (void)cancelOrderWithModel:(CYTCarOrderItemModel_item *)model andType:(CarOrderType)type {
    NSInteger logisticsStatus = model.logisticsStatus;
    NSString *logisticsCancelTip = model.logisticsCancelTip;
    CarOrderState  orderState = model.orderStatus;
    NSString *orderId = [NSString stringWithFormat:@"%ld",model.orderId];//需参数
    CYTWeakSelf
    if (logisticsStatus == 1) {
        [CYTAlertView alertViewWithTitle:@"提示" message:logisticsCancelTip confirmAction:^{
            [weakSelf cancelOrderWithType:type orderStauts:orderState orderId:orderId];
        } cancelAction:nil];
        return;
    }
    
    if (logisticsStatus == 2) {
        [CYTToast errorToastWithMessage:logisticsCancelTip];
        return;
    }
    [weakSelf cancelOrderWithType:type orderStauts:orderState orderId:orderId];
}
/**
 *  取消订单（卖家/买家）
 */
- (void)cancelOrderWithType:(CarOrderType)type orderStauts:(CarOrderState)orderState orderId:(NSString *)orderId{
    CYTOrderExtendType orderExtendType = type == CarOrderTypeBought?CYTOrderExtendTypeBuyerCancel:CYTOrderExtendTypeSellerCancel;
    CYTOrderExtendViewController *orderDetailViewController = [CYTOrderExtendViewController orderExtendWithExtendType:orderExtendType orderStatus:orderState orderId:orderId];
    orderDetailViewController.view.backgroundColor = CYTGreenNormalColor;
    [self.orderList pushViewController:orderDetailViewController withAnimate:YES];
}


///去支付
- (void)payOrderWithModel:(CYTCarOrderItemModel_item *)model {
    CYTLog(@"去支付");
    //1
    CYTPaymentModel *payModel = [CYTPaymentModel new];
    payModel.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    payModel.paymentType = PaymentType_dingjin;;
    payModel.payType = PayType_zhifubao;
    payModel.sourceType = PaySourceTypeOrderList;
    [CYTPaymentManager getPayInfoWithModel:payModel andSuperController:self.orderList];
}

///叫个物流
- (void)needLogisticsWithModel:(CYTCarOrderItemModel_item *)model {
    CYTLog(@"叫个物流");
    //2
    CYTLogisticsNeedWriteVM *vm = [CYTLogisticsNeedWriteVM new];
    vm.needGetLogisticInfo = YES;
    vm.orderId = model.orderId;
    CYTLogisticsNeedWriteTableController *need = [[CYTLogisticsNeedWriteTableController alloc] initWithViewModel:vm];
    [self.orderList pushViewController:need withAnimate:YES];
}

///发车信息
- (void)sendCarInfoWithModel:(CYTCarOrderItemModel_item *)model andType:(CarOrderType)type {
    CYTOrderSenderCarInfo *info = [CYTOrderSenderCarInfo new];
    info.viewModel.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    [self.orderList pushViewController:info withAnimate:YES];
}

///确认收车
- (void)affirmReceiveWithModel:(CYTCarOrderItemModel_item *)model {
    CarOrderState carOrderState = model.orderStatus;
    NSString *orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    CYTOrderExtendViewController *orderDetailViewController = [CYTOrderExtendViewController orderExtendWithExtendType:CYTOrderExtendTypeConfirmRecCar orderStatus:carOrderState orderId:orderId];
    [self.orderList pushViewController:orderDetailViewController withAnimate:YES];
}

///确认发车
- (void)affirmSendWithModel:(CYTCarOrderItemModel_item *)model {
    CYTWeakSelf
    if (model.logisticsStatus != 0) {
        [CYTAlertView alertViewWithTitle:@"提示" message:@"买家已叫物流，请和买家核对物流信息后再确认接单" confirmAction:^{
            [weakSelf confirmSendCarWithModel:model];
        } cancelAction:nil];
        return;
    }
    [weakSelf confirmSendCarWithModel:model];
}

/**
 *  确认发车
 */
- (void)confirmSendCarWithModel:(CYTCarOrderItemModel_item *)model{
    CYTConfirmSendCarViewController *confirmSendCarViewController = [[CYTConfirmSendCarViewController alloc] init];
    confirmSendCarViewController.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    [self.orderList pushViewController:confirmSendCarViewController withAnimate:YES];
}

///评价
- (void)commentWithModel:(CYTCarOrderItemModel_item *)model andType:(CarOrderType)type {
    CYTLog(@"评价");
    CYTOrderDetailViewController *detail = [CYTOrderDetailViewController new];
    detail.orderType = self.viewModel.orderType;
    detail.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    detail.showCommentView = YES;
    [self.orderList pushViewController:detail withAnimate:YES];
}

///退款
- (void)refundWithModel:(CYTCarOrderItemModel_item *)model andIndex:(NSInteger)index {
    //0-不同意，1-同意
    NSString *agree = [NSString stringWithFormat:@"同意买家申请退款%@元？",model.refundMoney];
    NSString *alert = (index==0)?kDisagreeRefund:agree;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:alert delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        if ([x integerValue] == 1) {
            self.viewModel.orderId = model.orderId;
            self.viewModel.agreeOrNot = (index==0)?NO:YES;
            [self.viewModel.refundCommand execute:nil];
        }
    }];
    [alertView show];
}

#pragma mark- 订单详情
- (void)orderDetailWithModel:(CYTCarOrderItemModel_item *)model {
    CYTOrderDetailViewController *detail = [CYTOrderDetailViewController new];
    detail.orderStatus = self.viewModel.orderState;
    detail.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    detail.orderType = self.viewModel.orderType;
    [self.orderList pushViewController:detail withAnimate:YES];
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTItemMarginV;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTCarOrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTCarOrderItemCell identifier] forIndexPath:indexPath];
    @weakify(self);
    [cell setActionBlock:^(CYTCarOrderItemCell *tmpCell, NSInteger index) {
        @strongify(self);
        NSIndexPath *tmpIndexPath = [self.mainView.tableView indexPathForCell:tmpCell];
        CYTCarOrderItemModel_item *tmpModel = self.viewModel.listArray[tmpIndexPath.section];
        [self handleActionWithModel:tmpModel withIndex:index];
    }];
    CYTCarOrderItemModel_item *model = self.viewModel.listArray[indexPath.section];
    cell.model = model;
    [cell configActionWithOrderType:self.viewModel.orderType andOrderState:model.orderStatus];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CYTCarOrderItemModel_item *model = self.viewModel.listArray[indexPath.section];
    [self orderDetailWithModel:model];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    self.viewModel.lastId = 0;
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        [_mainView registerCellWithIdentifier:@[[CYTCarOrderItemCell identifier]]];
        
        UIView *footerView = [UIView new];
        footerView.size = CGSizeMake(kScreenWidth, CYTItemMarginV);
        _mainView.tableView.tableFooterView = footerView;
    }
    return _mainView;
}

- (CYTCarOrderItemVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarOrderItemVM new];
    }
    return _viewModel;
}

@end
