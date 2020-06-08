//
//  CYTCarTradeCircleCallMonitorModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTCarTradeCircleCallMonitorModel : FFExtendModel
///userId
@property (nonatomic, copy) NSString *userId;
///类型0-右上角打电话，1-车商圈类表中打电话
@property (nonatomic, assign) NSInteger type;

@end
