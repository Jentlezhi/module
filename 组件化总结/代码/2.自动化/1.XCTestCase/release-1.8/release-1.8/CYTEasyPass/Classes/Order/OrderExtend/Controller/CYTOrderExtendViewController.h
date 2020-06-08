//
//  CYTOrderExtendViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 CYTOrderExtendViewController *orderDetailViewController = [CYTOrderExtendViewController orderExtendWithExtendType:CYTOrderExtendTypeBuyerCancel orderStatus:CarOrderStateUnPay orderId:@"3052"];
 [self.navigationController pushViewController:orderDetailViewController animated:YES];
 */

#import "CYTBasicTableViewController.h"
#import "CYTCarOrderEnum.h"


typedef NS_ENUM(NSInteger, CYTOrderExtendType) {
    CYTOrderExtendTypeBuyerCancel = 1,//买家取消订单
    CYTOrderExtendTypeSellerCancel,//卖家取消订单
    CYTOrderExtendTypeConfirmRecCar,//确认收车
};

@interface CYTOrderExtendViewController : CYTBasicTableViewController

+ (instancetype)orderExtendWithExtendType:(CYTOrderExtendType)extendType orderStatus:(CarOrderState)orderStatus orderId:(NSString *)orderId;

@end
