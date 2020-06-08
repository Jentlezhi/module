//
//  CYTPhoneCallHandler.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTPhoneCallHandler : NSObject

///打电话带提示还有回调方法
+ (void)makePhoneWithNumber:(NSString *)number alert:(NSString *)alertString resultBlock:(void(^)(BOOL))resultBlock;
///直接拨打电话（无title）
+ (void)makePhoneWithNumber:(NSString *)number withInterval:(NSTimeInterval)interval;
///打客服电话
+ (void)makeServicePhone;
///物流客服
+ (void)makeLogisticsServicePhone;

@end
