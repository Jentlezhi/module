//
//  FFCallCenterViewModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 注意：
 1）不能做成单利，因为每个实例需要不同的condition，单利无法实现
 2）使用时注意如果在回调方法中修改UI需要到主线程中操作。
 
 */

#import "FFExtendViewModel.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface FFCallCenterViewModel : FFExtendViewModel

///电话监听实例
@property (nonatomic, strong) CTCallCenter *callCenter;
///在当前app中拨出了电话
@property (nonatomic, copy) void (^isDialingBlock) (id);
///在当前app中拨出电话，并且接通
@property (nonatomic, copy) void (^isConnectedBlock) (id);

///开始监听
- (void)startMonitoringWithCondition:(id (^)(void))condition;
///结束监听
- (void)endMonitoring;


@end
