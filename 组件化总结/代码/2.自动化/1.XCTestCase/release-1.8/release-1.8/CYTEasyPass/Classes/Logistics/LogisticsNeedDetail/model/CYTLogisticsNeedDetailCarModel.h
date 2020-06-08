//
//  CYTLogisticsNeedDetailCarModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTLogisticsNeedDetailCarModel : FFExtendModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *priceString;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *numberString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, assign) BOOL transportHome;

@end
