//
//  CarFilterConditionVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CarFilterConditionModel.h"
#import "CarFilterConditonRequestModel.h"

@interface CarFilterConditionVM : CYTExtendViewModel
@property (nonatomic, strong) NSArray *carArray;
@property (nonatomic, strong) NSArray *singleCarArray;
@property (nonatomic, assign, getter = isSingleCar) BOOL singleCar;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *areaArray;
@property (nonatomic, strong) NSArray *dealerArray;


///如果数据无效则点击方法无效
@property (nonatomic, assign) BOOL invalid;
///满足条件的车，请求模型
@property (nonatomic, strong) CarFilterConditionModel *listRequestModel;

@property (nonatomic, strong) CarFilterConditonRequestModel *requestModel;
@property (nonatomic, strong) RACCommand *conditionGroupCommand;

@end
