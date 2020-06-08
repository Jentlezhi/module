//
//  CarFilterVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CarFilterConditionModel.h"
#import "CarFilterConditionSubbrandModel.h"
#import "CarFilterConditionDealerTypeModel.h"
#import "CarFilterConditionAreaModel.h"
#import "CarFilterConditonRequestModel.h"
#import "CarFilterConditionSubbrand_seriesModel.h"
#import "CarFilterConditionArea_provinceModel.h"

@interface CarFilterVM : CYTExtendViewModel
///搜索来源
@property (nonatomic, assign) CarViewSource source;
@property (nonatomic, copy) NSString *titleString;
///筛选条件，请求模型
@property (nonatomic, strong) CarFilterConditonRequestModel *requestModel;
///满足条件的车，请求模型
@property (nonatomic, strong) CarFilterConditionModel *listRequestModel;
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, strong) NSMutableArray *listArray;


@end
