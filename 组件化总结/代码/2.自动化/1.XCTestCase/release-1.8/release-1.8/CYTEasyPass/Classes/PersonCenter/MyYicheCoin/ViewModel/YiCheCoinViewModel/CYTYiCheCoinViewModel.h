//
//  CYTYiCheCoinViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTCoinSignResultModel.h"

@class CYTCoinSectionModel;

@interface CYTYiCheCoinViewModel : NSObject

/** 签到 */
@property(strong, nonatomic) RACCommand *signInCommand;
/** 数据 */
@property(strong, nonatomic) NSMutableArray <CYTCoinSectionModel*>*sectionModels;
/**
 *  请求展示数据
 */
- (void)requestData;
/** 请求数据的回调 */
@property(copy, nonatomic) void(^finishRequestData)(CYTNetworkResponse *signInStateData,CYTNetworkResponse *goodsData,CYTNetworkResponse *tasksData);

@end
