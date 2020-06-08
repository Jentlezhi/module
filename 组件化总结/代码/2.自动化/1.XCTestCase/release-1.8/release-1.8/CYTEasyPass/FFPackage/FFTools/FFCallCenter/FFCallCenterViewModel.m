//
//  FFCallCenterViewModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCallCenterViewModel.h"

@interface FFCallCenterViewModel ()
///是当前程序中自己拨出的电话
@property (nonatomic, assign) BOOL isDialing;

@end

@implementation FFCallCenterViewModel

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
}

#pragma mark- method
- (void)startMonitoringWithCondition:(id (^)(void))condition {
    
    if (!_callCenter) {
        _callCenter = [CTCallCenter new];
    }
    
    @weakify(self);
    self.callCenter.callEventHandler = ^(CTCall* call){
        @strongify(self);
        
        if (call.callState == CTCallStateConnected){
            if (self.isDialing) {
                //如果是在当前app中自己拨出的
                if (self.isConnectedBlock) {
                    self.isConnectedBlock(condition());
                }
            }
        }else if (call.callState == CTCallStateDialing){
            //判断播出电话时候，app的运行状态
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                //在程序内部播出电话
                self.isDialing = YES;
                if (self.isDialingBlock) {
                    self.isDialingBlock(condition());
                }
            }else {
                //其他情况
                self.isDialing = NO;
            }
        }else if (call.callState == CTCallStateIncoming) {
            self.isDialing = NO;
        }else if (call.callState == CTCallStateDisconnected) {
            self.isDialing = NO;
        }
    };
}

- (void)endMonitoring {
    _callCenter = nil;
}



@end
