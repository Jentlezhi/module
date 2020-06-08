//
//  CYTCarOrderListViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarOrderListViewController.h"

@interface CYTCarOrderListViewController ()

@end

@implementation CYTCarOrderListViewController

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    self.segmentHeight = CYTAutoLayoutV(80);
    self.segmentView.itemMinWidth = CYTAutoLayoutH(150);
    self.segmentView.indicatorBgColor = [UIColor whiteColor];
    self.segmentView.lineHeight = CYTAutoLayoutV(2);
    self.segmentView.titleNorColor = kFFColor_title_L2;
    self.segmentView.bubbleBgColor = CYTRedColor;
    self.segmentView.showBubble = YES;
    self.tabControllersArray = self.viewModel.statecontrollerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = (self.viewModel.orderType == CarOrderTypeBought)?@"买车订单":@"卖车订单";
    self.view.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
}

- (void)indexChangeWithIndex:(NSInteger)index {
    CYTCarOrderItemViewController *item = self.viewModel.statecontrollerArray[index];
    [item reloadOrderData];
}

- (void)changeSegmentBubbleNumberWithModel:(CYTCarOrderItemModel_stateNumber *)model {
    [self.segmentView bubbleNumber:@"" withIndex:0];
    [self.segmentView bubbleNumber:model.pendingPay withIndex:1];
    [self.segmentView bubbleNumber:model.pendingSendCar withIndex:2];
    [self.segmentView bubbleNumber:model.pendingReceiveCar withIndex:3];
    [self.segmentView bubbleNumber:model.pendingEvaluate withIndex:4];
    [self.segmentView bubbleNumber:model.pendingRefund withIndex:5];
}

#pragma mark- get
- (CYTCarOrderListVM *)viewModel {
    if (!_viewModel) {
        
        _viewModel = [CYTCarOrderListVM new];
        [_viewModel getControllersArrayWithParent:self];
    }
    return _viewModel;
}

@end
