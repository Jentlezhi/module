//
//  CYTAppManager.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAppManager.h"

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

- (instancetype)init{
    if (self = [super init]) {
        [self appManagerBasicConfig];
    }
    return self;
}
/**
 *  基本设置
 */
- (void)appManagerBasicConfig{
    [self setShowPageOfIntroduce];
}

/**
 *  设置是否需要显示引导页
 */
- (void)setShowPageOfIntroduce{
    NSString *key = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sandBoxVersion = [defaults objectForKey:key];
    if ([currentVersion isEqualToString:sandBoxVersion]) {
        self.showIntroPage = NO;
    }else{
        self.showIntroPage = YES;
    }
}
/**
 *  设置项目根视图控制器
 */
- (void)setRootViewController{
    
}


@end
