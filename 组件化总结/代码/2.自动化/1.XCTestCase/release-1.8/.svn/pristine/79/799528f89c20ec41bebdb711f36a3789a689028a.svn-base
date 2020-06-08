//
//  CYTPaymentManager.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPaymentManager.h"
#import "CYTBalancePayTableController.h"
#import "CYTAlipayTableController.h"
#import "AESCrypt.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTCarOrderListViewController.h"
#import "CYTOrderDetailViewController.h"

@interface CYTPaymentManager ()

@end

@implementation CYTPaymentManager

- (void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    CYTPayCellModel *obj0 = [CYTPayCellModel new];
    obj0.imageName = @"pay_zhifubao";
    obj0.title = @"支付宝";
    obj0.subTitle = @"推荐支付宝用户使用";
    obj0.selectState = YES;
    
    CYTPayCellModel *obj1 = [CYTPayCellModel new];
    obj1.imageName = @"pay_balance";
    obj1.title = @"余额支付";
    obj1.subTitle = @"";
    obj1.selectState = YES;
    
    self.listArray = [NSMutableArray array];
    [self.listArray addObject:obj0];
    [self.listArray addObject:obj1];
    
}

#pragma mark- 处理支付结果和跳转逻辑
+ (void)handlePayResultWithController:(UIViewController *)controller andPayManager:(CYTPaymentManager *)manager {
    if (manager.requestModel.payResultType == PayResultTypeBalanceCancel || manager.requestModel.payResultType == PayResultTypePayCancelWithNotBView) {
        //取消支付
        [controller.navigationController popViewControllerAnimated:YES];
    }else if (manager.requestModel.payResultType == PayResultTypePayCancelWithBView) {
        //取消支付
        NSInteger index = controller.navigationController.viewControllers.count-1;
        index = index-2;
        if (index<0) {
            index = 0;
        }
        UIViewController *theController = controller.navigationController.viewControllers[index];
        [controller.navigationController popToViewController:theController animated:YES];
    }else{
        //余额支付成功/非余额支付成功,支付中（支付中也发通知）
        if (manager.requestModel.sourceType == PaySourceTypeLogistics) {
            //返回物流详情页面
            [self popToLogisticsDetailWithNoti:YES andController:controller];
        }else if (manager.requestModel.sourceType == PaySourceTypeOrderList || manager.requestModel.sourceType == PaySourceTypeOrderDetail){
            [self popToOrderListWithNoti:YES andController:controller];
        }
    }
}

///返回物流详情
+ (void)popToLogisticsDetailWithNoti:(BOOL)needNoti andController:(UIViewController *)controller{
    if (needNoti) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticsOrderPaySuccessNotkey object:nil];
    }
    NSUInteger index = 0;
    for (UIViewController *subViewController in controller.navigationController.viewControllers) {
        if ([subViewController isKindOfClass:[CYTLogisticsOrderDetail3DController class]]) {
            index = [controller.navigationController.viewControllers indexOfObject:subViewController];
        }
    }
    [controller.navigationController popToViewController:[controller.navigationController.viewControllers objectAtIndex:index] animated:YES];
}

///返回订单列表
+ (void)popToOrderListWithNoti:(BOOL)needNoti andController:(UIViewController *)controller{
    if (needNoti) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderListKey object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderDetailKey object:nil];
    }
    NSUInteger index = 0;
    
    //此处考虑了订单列表和详情的关系，一定是    -->列表（-->详情）-->支付。
    //所以返回判断：如有有详情返回详情，否则返回列表
    NSArray *controllersArray = controller.navigationController.viewControllers;
    
    for (NSInteger i = controllersArray.count-1; i>=0;i--) {
        UIViewController *subViewController = controllersArray[i];
        //detail
        if ([subViewController isKindOfClass:[CYTOrderDetailViewController class]]) {
            index = [controller.navigationController.viewControllers indexOfObject:subViewController];
            break;
        }
        //list
        if ([subViewController isKindOfClass:[CYTCarOrderListViewController class]]) {
            index = [controller.navigationController.viewControllers indexOfObject:subViewController];
            break;
        }
    }
    
    [controller.navigationController popToViewController:[controller.navigationController.viewControllers objectAtIndex:index] animated:YES];
}

#pragma mark- api

+ (void)getPayInfoWithModel:(CYTPaymentModel *)model andSuperController:(UIViewController *)controller {
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
    
    NSDictionary *parameters = @{@"orderId":model.orderId,
                                 @"paymentType":@(model.paymentType)};
    
    @weakify(self);
    [CYTNetworkManager GET:kURL.order_pay_index parameters:parameters dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        @strongify(self);
        [self handleBalanceInfo:responseObject andController:controller andRequestModel:model];
    }];
}

#pragma mark- method
+ (void)handleBalanceInfo:(FFBasicNetworkResponseModel *)responseModel andController:(UIViewController *)controller andRequestModel:(CYTPaymentModel *)requestModel {
    
    if (responseModel.resultEffective) {
        CYTBalancePaymentModel *model = [CYTBalancePaymentModel mj_objectWithKeyValues:responseModel.dataDictionary];
        
        //如果将使用的余额大于等于0则进入余额支付页面，否则进入支付页面
        if (model.balancePayAmount >0 || (model.balancePayAmount ==0 && model.toPayAmount ==0)) {
            requestModel.haveBalanceView = YES;
            CYTBalancePayTableController *balancePayCtr = [CYTBalancePayTableController new];
            balancePayCtr.manager.requestModel = requestModel;
            balancePayCtr.manager.balanceModel = model;
            [controller.navigationController pushViewController:balancePayCtr animated:YES];
        }else {
            requestModel.haveBalanceView = NO;
            CYTAlipayTableController *payCtr = [CYTAlipayTableController new];
            payCtr.manager.requestModel = requestModel;
            payCtr.manager.requestModel.unPayTotalCash = model.toPayAmount;
            payCtr.manager.requestModel.balancePaidCash = model.balancePaidAmount;
            payCtr.manager.requestModel.unPaidCash = model.needPayAmount;
            [controller.navigationController pushViewController:payCtr animated:YES];
        }
    }else{
        [CYTToast errorToastWithMessage:responseModel.resultMessage];
    }
}

- (NSString *)unpayCashString {
    if (self.balanceModel) {
        return [NSString stringWithFormat:@"待支付金额：%.2f元",self.balanceModel.toPayAmount];
    }
    return @"";
}

- (NSString *)accountBalanceCashString {
    if (self.balanceModel) {
        return [NSString stringWithFormat:@"当前账户可用余额：%.2f元",self.balanceModel.balanceAmount];
    }
    return @"";
}

- (NSString *)useBalanceString {
    if (self.balanceModel) {
        return [NSString stringWithFormat:@"支付金额：%.2f元",self.balanceModel.balancePayAmount];
    }
    return @"";
}

#pragma mark- get
- (RACCommand *)requestAlipayInfoCommand {
    if (!_requestAlipayInfoCommand) {
        _requestAlipayInfoCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_pay_AppPay;
            model.needHud = YES;
            
            NSString *userName = [CYTAccountManager sharedAccountManager].userAuthenticateInfoModel.userName;
            NSDictionary *dic = @{@"orderId":self.requestModel.orderId,
                                  @"userName":userName,
                                  @"paymentType":@(self.requestModel.paymentType),
                                  @"payType":@(self.requestModel.payType)};
            model.requestParameters = dic.mutableCopy;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _requestAlipayInfoCommand;
}

- (RACCommand *)affirmCommand {
    if (!_affirmCommand) {
        _affirmCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_pay_payResult;
            model.methodType = NetRequestMethodTypeGet;
            model.needHud = YES;
            NSDictionary *parameters = @{@"orderId":self.requestModel.orderId,
                                         @"paymentType":@(self.requestModel.paymentType)};
            model.requestParameters = parameters;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _affirmCommand;
}

- (RACCommand *)requestBalanceInfoCommand {
    if (!_requestBalanceInfoCommand) {
        _requestBalanceInfoCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_pay_BalancePay;
            model.needHud = YES;
            NSString *secretKey = [NSString tokenValueOf16];
            NSString *passWord = [AESCrypt encrypt:self.pwdString password:secretKey];
            
            NSDictionary *parameters = @{@"orderId":self.requestModel.orderId,
                                         @"paymentType":@(self.requestModel.paymentType),
                                         @"payPassword":passWord,
                                         @"tokenValue":Token_Value};
            model.requestParameters = parameters;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _requestBalanceInfoCommand;
}

- (RACCommand *)payExistAlertCommand {
    if (!_payExistAlertCommand) {
        _payExistAlertCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.order_pay_payPromptMsg;
            model.methodType = NetRequestMethodTypeGet;
            model.needHud = YES;
            model.requestParameters = @{@"orderId":self.requestModel.orderId};
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *responseModel) {
            //none
        }];
    }
    return _payExistAlertCommand;
}

@end
