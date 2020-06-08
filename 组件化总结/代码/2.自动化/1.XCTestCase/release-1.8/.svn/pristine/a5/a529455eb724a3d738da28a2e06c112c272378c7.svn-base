//
//  CYTAppManager.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAppManager.h"

@interface CYTAppManager()

@end

@implementation CYTAppManager

/**
 *  单例
 */
+ (instancetype)sharedAppManager{
    static CYTAppManager *appManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appManager = [[CYTAppManager alloc] init];
    });
    
    return appManager;
}

/**
 *  网络监测
 */
- (void)checkNetWork{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    CYTWeakSelf
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.reachable = YES;
                !weakSelf.reachableBlock?:weakSelf.reachableBlock(YES);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.reachable = NO;
                !weakSelf.reachableBlock?:weakSelf.reachableBlock(NO);
                break;
        }
    }];
}
/**
 *  设置是否显示引导
 */
- (BOOL)showNewfeature{
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"sandBoxVersion"];
    if (!sandBoxVersion || ![sandBoxVersion isEqualToString:kFF_APP_VERSION]) {
        [[NSUserDefaults standardUserDefaults] setObject:kFF_APP_VERSION forKey:@"sandBoxVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}


@end
