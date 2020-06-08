//
//  CYTCarDealerChartItemVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTCarDealerChartItemModel.h"

typedef NS_ENUM(NSInteger,CarDealerChartType) {
    ///好评
    CarDealerChartTypeGoodComment,
    ///销量
    CarDealerChartTypeSales,
};

@interface CYTCarDealerChartItemVM : CYTExtendViewModel
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger isMore;

@property (nonatomic, strong) CYTCarDealerChartItemModel *meSortModel;
@property (nonatomic, assign) CarDealerChartType type;

@end
