//
//  CYTLogisticsOrderVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

@interface CYTLogisticsOrderVM : CYTExtendViewModel
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger lastId;
@property (nonatomic, assign) NSInteger isMore;
///订单状态
@property (nonatomic, assign) CYTLogisticsOrderStatus state;

///orderId
@property (nonatomic, copy) NSString *orderId;
///确认收车
@property (nonatomic, strong) RACCommand *affirmReceiveCarCommand;

@end
