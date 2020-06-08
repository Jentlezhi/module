//
//  CYTCarDealerChartItemModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarDealerChartItemModel.h"

@implementation CYTCarDealerChartItemModel

- (BOOL)isEqual:(id)object {
    CYTCarDealerChartItemModel *obj = (CYTCarDealerChartItemModel *)object;
    return obj.userId == self.userId;
}

@end
