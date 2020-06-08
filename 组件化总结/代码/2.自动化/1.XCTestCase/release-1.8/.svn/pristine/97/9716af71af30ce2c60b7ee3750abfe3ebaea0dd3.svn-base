//
//  FFJPUSHManager.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFJPUSHManager.h"

@implementation FFJPUSHManager

+ (instancetype)manager {
    static FFJPUSHManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FFJPUSHManager new];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kJPFNetworkDidLoginNotification object:nil] subscribeNext:^(id x) {
            @strongify(self);
            if (self.jpushIdBlock) {
                self.jpushIdBlock([JPUSHService registrationID]);
            }
        }];
        
        //极光长连接静态消息（只有app在前台能收到）
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kJPFNetworkDidReceiveMessageNotification object:nil] subscribeNext:^(NSNotification *notification) {
            @strongify(self);
            NSDictionary *userInfo = [notification userInfo];
            if (self.notificationBlock) {
                self.notificationBlock(userInfo, FFChannelTypeJpush);
            }
        }];
    }
    return self;
}


- (void)registerPushServiceWithToken:(NSString *)token andChannel:(NSString *)channel launchOptions:(NSDictionary *)launchOptions {
#if !TARGET_OS_SIMULATOR
    //极光推送
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    
    BOOL isProduction = YES;
#ifdef DEBUG
    isProduction = NO;
#endif
    
    [JPUSHService setupWithOption:launchOptions appKey:token
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
#endif
}

- (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark-

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    //前台运行时收到消息
    if (self.notificationBlock) {
        self.notificationBlock(userInfo,FFChannelTypeApns);
    }
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //发送状态给极光，获取用户数据接口状况用来进行统计
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //前台运行使用0不弹出顶部提示栏
    completionHandler(0);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //点击通知栏获取到消息
    if (self.notificationBlock) {
        self.notificationBlock(userInfo,FFChannelTypeApns);
    }
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //发送状态给极光，获取用户数据接口状况用来进行统计
        [JPUSHService handleRemoteNotification:userInfo];
    }
    //系统要求执行这个方法
    completionHandler();
}

- (void)didReceiveSilentRemoteNotification:(NSDictionary *)userInfo {
    if (self.notificationBlock) {
        self.notificationBlock(userInfo,FFChannelTypeApns);
    }
    //发送状态给极光，获取用户数据接口状况用来进行统计
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
