//
//  CYTCarOrderItemModel_stateNumber.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTCarOrderItemModel_stateNumber : FFExtendModel
@property (nonatomic, copy) NSString *pendingReceiveCar;
@property (nonatomic, copy) NSString *pendingPay;
@property (nonatomic, copy) NSString *pendingEvaluate;
@property (nonatomic, copy) NSString *pendingRefund;
@property (nonatomic, copy) NSString *pendingSendCar;

@end
