//
//  CYTPhoneCallHandler.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhoneCallHandler.h"

@implementation CYTPhoneCallHandler

+ (void)makePhoneWithNumber:(NSString *)number alert:(NSString *)alertString resultBlock:(void (^)(BOOL))resultBlock{
    [CYTAlertView alertViewWithTitle:@"提示" message:alertString confirmAction:^{
        //确定拨打电话
        if (resultBlock) {
            resultBlock(YES);
        }
        [self makePhoneWithNumber:number withInterval:0.5];
    } cancelAction:nil];
}

+ (void)makePhoneWithNumber:(NSString *)number withInterval:(NSTimeInterval)interval{
    NSURL *phoneNum = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", number]];
    NSDecimalNumber *deviceVersionNum = [CYTCommonTool deviceVersion];
    NSDecimalNumber *desVersion = [NSDecimalNumber decimalNumberWithString:@"10.0"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //判断系统版本,调用不同方法
        if ([deviceVersionNum compare:desVersion] != NSOrderedAscending) {
            if ([[UIApplication sharedApplication] canOpenURL:phoneNum]) {
                [[UIApplication sharedApplication] openURL:phoneNum options:@{} completionHandler:nil];
            }
        }else {
            if ([[UIApplication sharedApplication] canOpenURL:phoneNum]) {
                [[UIApplication sharedApplication] openURL:phoneNum];
            }
        }
    });
}

+ (void)makeServicePhone {
    [CYTPhoneCallHandler makePhoneWithNumber:kServicePhoneNumer alert:kServicePhoneAlert resultBlock:nil];
}

+ (void)makeLogisticsServicePhone {
    [CYTPhoneCallHandler makePhoneWithNumber:kLogisticsPhoneNumber alert:kServicePhoneAlert resultBlock:nil];
}

@end
