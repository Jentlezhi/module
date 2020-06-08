//
//  CYTCarOrderListVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderListVM.h"

@implementation CYTCarOrderListVM

- (void)ff_initWithModel:(FFExtendModel *)model {
    
}

- (void)getControllersArrayWithParent:(id)parent {
    NSArray *titleArray = @[@"全部",@"待付款",@"待接单",@"待成交",@"待评价",@"退款"];
    NSArray *stateArray = @[@(CarOrderStateAll),@(CarOrderStateUnPay),@(CarOrderStateUnSendCar),@(CarOrderStateUnReceiveCar),@(CarOrderStateUnComment),@(CarOrderStateRefund)];
    
    self.statecontrollerArray = [NSMutableArray array];
    
    for (int i=0; i<titleArray.count; i++) {
        CYTCarOrderItemViewController *itemController = [CYTCarOrderItemViewController new];
        itemController.orderList = parent;
        itemController.title = titleArray[i];
        itemController.viewModel.title = titleArray[i];
        itemController.viewModel.orderState = [stateArray[i] integerValue];
        [self.statecontrollerArray addObject:itemController];
    }
}

- (void)setOrderType:(CarOrderType)orderType {
    _orderType = orderType;
    
    for (int i=0; i<self.statecontrollerArray.count; i++) {
        CYTCarOrderItemViewController *item = self.statecontrollerArray[i];
        item.viewModel.orderType = orderType;
    }
}

@end
