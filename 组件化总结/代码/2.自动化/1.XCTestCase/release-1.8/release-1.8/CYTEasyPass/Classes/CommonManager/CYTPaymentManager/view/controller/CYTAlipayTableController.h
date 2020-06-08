//
//  CYTAlipayTableController.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewController.h"
#import "CYTPaymentManager.h"

@interface CYTAlipayTableController : FFExtendTableViewController
///数据
@property (nonatomic, strong) CYTPaymentManager *manager;

@end
