//
//  CarSourceDetailItemModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTDealer.h"
#import "CarSourceDetailDescModel.h"

@interface CarSourceDetailItemModel : FFExtendModel
///index
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *flagString;
@property (nonatomic, copy) NSString *contentString;

///车源数据
@property (nonatomic, copy) NSString *carInfoString;
@property (nonatomic, copy) NSString *carTypeString;

///图片数据
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, copy) NSString *imageCountString;

///经销商数据
@property (nonatomic, strong) CYTDealer *dealerInfoModel;

///交易流程图
@property (nonatomic, strong) CarSourceDetailDescModel *flowModel;

///线路
@property (nonatomic, copy) NSArray *routeArray;
@property (nonatomic, copy) NSString *routeText;

@end
