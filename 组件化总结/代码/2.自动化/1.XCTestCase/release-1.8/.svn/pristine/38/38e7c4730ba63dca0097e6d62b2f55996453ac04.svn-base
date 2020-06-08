//
//  CYTCarOrderItemCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTCarOrderItemCell_action.h"
#import "CYTCarOrderItemCell_orderNum.h"
#import "CYTCarOrderItemModel.h"
#import "CYTCarOrderEnum.h"
#import "CYTCarListInfoView.h"
#import "CYTOrderBottomInfoView.h"

@interface CYTCarOrderItemCell : FFExtendTableViewCell
@property (nonatomic, strong) CYTCarOrderItemCell_orderNum *numberView;
@property (nonatomic, strong) CYTCarListInfoView *infoView;
@property (nonatomic, strong) CYTOrderBottomInfoView *bottomInfoView;
@property (nonatomic, strong) CYTCarOrderItemCell_action *actionView;
///action事件
@property (nonatomic, copy) void (^actionBlock) (CYTCarOrderItemCell *,NSInteger);
///数据
@property (nonatomic, strong) CYTCarOrderItemModel_item *model;
///设置actionview
- (void)configActionWithOrderType:(CarOrderType)orderType andOrderState:(CarOrderState)orderState;

@end
