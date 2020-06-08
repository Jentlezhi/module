//
//  FFJPUSHManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 使用
 1）注册
 //极光消息推送注册服务
 [[FFJPUSHManager manager] setNotificationBlock:^(NSDictionary *info) {
 //处理推送数据
 [[CYTMessageCenterVM manager] handleJPUSHInfo:info];
 }];
 [[FFJPUSHManager manager] setJpushIdBlock:^(NSString *jpushId) {
 //获取到极光登录id，并上传到服务器
 [[CYTMessageCenterVM manager] saveJPUSHID:jpushId];
 [[CYTMessageCenterVM manager] uploadJPUSHID];
 }];
 
 [[FFJPUSHManager manager] registerPushServiceWithToken:@"2f3c193833ef1e432b865af0" andChannel:@"App Store" launchOptions:launchOptions];

 
 2）反馈token、
 
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 [[FFJPUSHManager manager] registerDeviceToken:deviceToken];
 }
 
 
 3）silent消息推送支持
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
 
 [[FFJPUSHManager manager] didReceiveSilentRemoteNotification:userInfo];
 completionHandler(UIBackgroundFetchResultNewData);
 }
 
 
 */
#import "FFExtendViewModel.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

typedef NS_ENUM(NSInteger,FFChannelType) {
    ///apns正常数据
    FFChannelTypeApns,
    ///极光长连接数据
    FFChannelTypeJpush,
};

@interface FFJPUSHManager : FFExtendViewModel<JPUSHRegisterDelegate>

+ (instancetype)manager;

///回传消息推送数据
@property (nonatomic, copy) void (^notificationBlock) (NSDictionary *noti,FFChannelType type);
///极光回传id，外部使用上传到服务器
@property (nonatomic, copy) void (^jpushIdBlock) (NSString *);

///注册消息推送,模拟器不注册
- (void)registerPushServiceWithToken:(NSString *)token andChannel:(NSString *)channel launchOptions:(NSDictionary *)launchOptions;

///使用token注册JPUSH,必要的
- (void)registerDeviceToken:(NSData *)deviceToken;

///silent消息推送支持
- (void)didReceiveSilentRemoteNotification:(NSDictionary *)userInfo;


@end
