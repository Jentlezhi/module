//
//  LogisticsHomeModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface LogisticsHomeModel : FFExtendModel
@property (nonatomic, copy) NSString *origin;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *transportPrice;

@end
