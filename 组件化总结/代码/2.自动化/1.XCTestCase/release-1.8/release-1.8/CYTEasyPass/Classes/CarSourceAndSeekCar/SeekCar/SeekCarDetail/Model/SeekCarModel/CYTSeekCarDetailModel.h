//
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTSeekCarInfoModel.h"
@class CYTDealer;

@interface CYTSeekCarDetailModel : NSObject
///寻车数据
@property(strong, nonatomic) CYTSeekCarInfoModel *seekCarInfo;
///流程图信息
@property (nonatomic, strong) NSArray *descList;
/** 经销商模型 */
@property(strong, nonatomic) CYTDealer *dealer;

@end
