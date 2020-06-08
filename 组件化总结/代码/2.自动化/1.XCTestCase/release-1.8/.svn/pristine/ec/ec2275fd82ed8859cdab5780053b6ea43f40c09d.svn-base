//
//  CYTLogisticsOrderListItemTableController.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewController.h"
#import "CYTLogisticsOrderVM.h"
#import "CYTLogisticsOrderListModel.h"
@class CYTLogisticsOrderList;

@interface CYTLogisticsOrderListItemTableController : FFExtendTableViewController
@property (nonatomic, weak) CYTLogisticsOrderList *orderList;
@property (nonatomic, strong) CYTLogisticsOrderVM *viewModel;
@property (nonatomic, copy) void (^selectBlock) (CYTLogisticsOrderListModel *);

- (void)refreshMethodWithNeed:(BOOL)need;

@end
