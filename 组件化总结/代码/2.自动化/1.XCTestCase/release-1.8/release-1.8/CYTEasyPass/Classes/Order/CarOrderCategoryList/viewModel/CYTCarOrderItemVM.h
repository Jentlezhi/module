//
//  CYTCarOrderItemVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTCarOrderItemModel.h"
#import "CYTCarOrderEnum.h"
#import "CYTCarSourceListModel.h"

@interface CYTCarOrderItemVM : CYTExtendViewModel
///title
@property (nonatomic, copy) NSString *title;
///订单状态,仅请求数据使用!
@property (nonatomic, assign) CarOrderState orderState;
///订单类型
@property (nonatomic, assign) CarOrderType orderType;
///data
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger isMore;
@property (nonatomic, assign) NSInteger lastId;

///退款
@property (nonatomic, strong) RACCommand *refundCommand;
///同意不同意
@property (nonatomic, assign) BOOL agreeOrNot;
///orderId
@property (nonatomic, assign) NSInteger orderId;

///个状态数据个数
@property (nonatomic, strong) CYTCarOrderItemModel_stateNumber *stateNumberModel;

///数据模型转换
+ (CYTCarSourceListModel *)carInfoModelWithOrderModel:(CYTCarOrderItemModel_item *)model;

@end
