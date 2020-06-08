//
//  CarSourceDetailModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTCarSourceInfoModel.h"
#import "CYTDealer.h"

@interface CarSourceDetailModel : FFExtendModel
@property (nonatomic, strong) CYTCarSourceInfoModel *carSourceInfo;
///图片
@property (nonatomic, strong) NSArray *media;
@property (nonatomic, strong) CYTDealer *dealer;
///流程图信息
@property (nonatomic, strong) NSArray *descList;

@end
