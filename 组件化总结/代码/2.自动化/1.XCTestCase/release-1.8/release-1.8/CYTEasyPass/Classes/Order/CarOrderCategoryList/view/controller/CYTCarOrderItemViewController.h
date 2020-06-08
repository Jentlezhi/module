//
//  CYTCarOrderItemViewController.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTCarOrderItemVM.h"
@class CYTCarOrderListViewController;

@interface CYTCarOrderItemViewController : CYTBasicViewController
@property (nonatomic, weak) CYTCarOrderListViewController *orderList;
@property (nonatomic, strong) CYTCarOrderItemVM *viewModel;
///刷新数据，只要切状态就刷新数据
- (void)reloadOrderData;

@end
