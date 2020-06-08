//
//  CYTWithdrawFinishedTableController.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewController.h"

@interface CYTWithdrawFinishedTableController : FFExtendTableViewController
@property (nonatomic, copy) NSString *accountString;
///提现金额
@property (nonatomic, copy) NSString *cashMount;
///手续费
@property (nonatomic, copy) NSString *poundage;

@end
