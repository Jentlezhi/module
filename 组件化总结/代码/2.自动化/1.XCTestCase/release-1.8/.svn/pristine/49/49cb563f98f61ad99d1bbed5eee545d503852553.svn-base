//
//  CYTPaymentManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTPaymentModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "CYTExtendViewModel.h"
#import "CYTBalancePaymentModel.h"
#import "CYTPayCellModel.h"

#define kPayExistAlertDefault   @"支付未完成,请您尽快完成支付。"

@interface CYTPaymentManager : CYTExtendViewModel
///请求参数
@property (nonatomic, strong) CYTPaymentModel *requestModel;
///余额支付信息
@property (nonatomic, strong) CYTBalancePaymentModel *balanceModel;

///请求支付信息
+ (void)getPayInfoWithModel:(CYTPaymentModel *)model andSuperController:(UIViewController *)controller;
///支付结果处理，取消或者成功后的页面跳转处理
+ (void)handlePayResultWithController:(UIViewController *)controller andPayManager:(CYTPaymentManager *)manager;
///返回的规则，从详情进入则返回详情，从列表进入则返回列表。
+ (void)popToOrderListWithNoti:(BOOL)needNoti andController:(UIViewController *)controller;


//cell数据
@property (nonatomic, strong) NSMutableArray *listArray;
///待支付总金额
@property (nonatomic, copy) NSString *unpayCashString;
///余额支付后账户余额
@property (nonatomic, copy) NSString *accountBalanceCashString;
///使用余额
@property (nonatomic, copy) NSString *useBalanceString;
///使用余额支付密码
@property (nonatomic, copy) NSString *pwdString;


///请求支付宝支付信息
@property (nonatomic, strong) RACCommand *requestAlipayInfoCommand;
///请求余额付信息
@property (nonatomic, strong) RACCommand *requestBalanceInfoCommand;
///确定支付结果
@property (nonatomic, strong) RACCommand *affirmCommand;
///请求支付退出提示
@property (nonatomic, strong) RACCommand *payExistAlertCommand;
@end
