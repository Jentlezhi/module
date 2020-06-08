//
//  YCLite.h
//  YCAnalytics_Sdk_Demo
//
//  Created by YICHE on 16/3/3.
//  Copyright © 2016年 YICHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXExternDefines.h"

typedef NS_ENUM(NSUInteger, YCACCOUNTTYPE) {
    YCACCOUNTTYPE_CUSTOM,
    YCACCOUNTTYPE_MAIL,
    YCACCOUNTTYPE_TEL,
};

CX_CLASS_DEPRECATED("YCLite is deprecated", "Use C4BraveSDK instead")
@interface YCLite : NSObject

+ (void)setLogEnabled:(BOOL)enabled;
+ (void)setAppKey:(NSString *)appKey ChannelId:(NSString *)channelId ;
+ (void)loginStatisticsWithYCUserName:(NSString *)yc_UserName AccountType:(YCACCOUNTTYPE)accountType;
+ (void)loginStatisticsWithThirdPartUserName:(NSString *)userName andThirdpartyType:(NSString *)thirdType;
+ (void)recordPageInfoWithPageName:(NSString *)pageName seconds:(int)seconds;
+ (void)beginRecordPageInfoWithPageName:(NSString *)pageName;
+ (void)endRecordPageInfoWithPageName:(NSString *)pageName;
+ (void)readyToRecordWebEvent;
+ (void)startRecordWebViewDuring;
+ (void)recordWebViewDuringWithUrl:(NSString *)urlString;
+ (void)endRecordWebViewDuring;
+ (void)recordCountClickWithEvent:(NSString *)eventName;
+ (void)recordCustomWithEventName:(NSString *)eventName andEventDic:(NSDictionary<NSString *, id> *)eventDic;
+ (void)setLocationWithLatitude:(double)latitude longitude:(double)longitude;

@end
