//
//  AppDelegate.m
//  CYTEasyPass
//
//  Created by bita on 15/8/21.
//  Copyright (c) 2015年 EasyPass. All rights reserved.
//  

#import "CYTAppDelegate.h"
#import "CYTAppManager.h"
#import "CYTPaymentManager.h"
#import "CYTLoginViewController.h"
#import "CYTPersonalCertificateViewController.h"
#import "CYTNewfeatureController.h"
#import "UMMobClick/MobClick.h" 
#import <Bugly/Bugly.h>
#import "CYTPersonalHomeTableController.h"
#import "FCUUID.h"
#import "CYTSendCarSupernatant.h"
#import "AvoidCrash.h"
#import "CYTLinkHandler.h"
#import "CYTLaunchAdManager.h"
#import <YCAutoTrackingSDK/YCAutoTrackingSDK.h>
#import "CYTShareManager.h"

#ifdef DEBUG
#import "CYTTestViewController.h"
#import "JentleTestViewController.h"

//#define dev_Jentle
//#define dev_JunQuan

#endif


@implementation CYTAppDelegate

#pragma mark- api

- (void)finishLaunching{

#ifdef dev_Jentle
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[JentleTestViewController new]];
    
#elif defined dev_JunQuan
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[CYTTestViewController new]];
    
#else
    if ([[CYTAppManager sharedAppManager] showNewfeature]) {
        //设置订单提示再次有效
        [[CYTSendCarSupernatant new] reShow];
        //广告显示逻辑
        [[CYTLaunchAdManager sharedLaunchAdManager] requestLaunchData];
        //引导图片显示
        CYTNewfeatureController *newfeatureController = [[CYTNewfeatureController alloc] init];
        newfeatureController.clearIndicator = YES;
        newfeatureController.showPageControl = NO;
        newfeatureController.experienceNowOperation = ^{
            [[CYTLaunchAdManager sharedLaunchAdManager] showLaunchAd];
            [self mainTabBar];
        };
        self.window.rootViewController = newfeatureController;
    }else{
        [[CYTLaunchAdManager sharedLaunchAdManager] showLaunchAd];
        [self mainTabBar];
    }
#endif
}

- (void)goCarSourceView {
    [self setTabbarIndex:1];
}

- (void)goSeekCarView {
    [self setTabbarIndex:2];
}

- (void)goDiscover {
    [self setTabbarIndex:3];
}

- (void)goMe {
    [self setTabbarIndex:4];
}

- (void)setTabbarIndex:(NSInteger)index {
    if (index<0 || index>4) {
        return;
    }
    self.tabBarController.selectedIndex = index;
}

- (void)mainTabBar{
    self.window.rootViewController = self.tabBarController;
}

- (void)goHomeView{
    self.tabBarController = nil;
    self.window.rootViewController = self.tabBarController;
}

- (CYTCustomTabbarController *)tabBarController{
    if(!_tabBarController){
        _tabBarController = [[CYTCustomTabbarController alloc] init];
        _tabBarController.delegate = self;
    }
    return _tabBarController;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UINavigationController *nav = (UINavigationController *)viewController;
    id controllers = nav.viewControllers[0];
    
    if ([controllers isKindOfClass:[CYTPersonalHomeTableController class]]) {
        //当前是我
        if (![CYTAuthManager manager].isLogin) {
            //弹出登录页面
            [[CYTAuthManager manager] goLoginView];
            return NO;
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kMeRefreshKey object:nil];
            return YES;
        }
    }
    return YES;
}

#pragma mark- setting
- (void)loadSettingForThirPlatWithOptions:(NSDictionary *)launchOptions {
    
    //获取设备信息并保存
    NSString *deviceId = [FCUUID uuidForDevice];
    [CYTCommonTool setValue:deviceId forKey:CYTDeviceUUIDKey];
    
    //友盟统计
    UMConfigInstance.appKey = @"58fda267f43e48322d0018f6";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    //版本号取值使用类型
    [MobClick setAppVersion:kFF_APP_VERSION];
    
    //大数据统计
    // 设置appkey和渠道id
    // enableAutoTrack 必须为yes
    [C4BraveSDK launchWithOptions:launchOptions
                           appKey:@"W48H4SISFT45C6WWCEKRFMQIJKQK165X"
                          channel:@"App Store"
                  enableAutoTrack:YES];
    // log开关(上线请务必关闭)
    [C4BraveSDK setLogEnabled:NO];
    
    //微信分享
    [WXApi registerApp:@"wxfd99fd1538ffcc7a"];
    
    //bugly
    [Bugly startWithAppId:@"528cba1268"];
    
    //极光消息推送注册服务
    [[FFJPUSHManager manager] setNotificationBlock:^(NSDictionary *info,FFChannelType type) {
        //处理推送数据
        [[CYTMessageCenterVM manager] handleJPUSHInfo:info channelType:type];
    }];
    [[FFJPUSHManager manager] setJpushIdBlock:^(NSString *jpushId) {
        //获取到极光登录id，并上传到服务器
        [[CYTMessageCenterVM manager] saveJPUSHID:jpushId];
        [[CYTMessageCenterVM manager] uploadJPUSHID];
    }];
    
    [[FFJPUSHManager manager] registerPushServiceWithToken:@"2f3c193833ef1e432b865af0" andChannel:@"App Store" launchOptions:launchOptions];

}

//处理键盘
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    __block BOOL hiddenThirdKeyboard = NO;
    extern NSString *CYTKeyboardSwitchNot;
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:CYTKeyboardSwitchNot object:nil] subscribeNext:^(NSNotification *not) {
        hiddenThirdKeyboard = not.object;
    }];
    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
        return !hiddenThirdKeyboard;
    }
    return YES;
}

#pragma mark- 推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[FFJPUSHManager manager] registerDeviceToken:deviceToken];
}

//静态消息推送支持
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[FFJPUSHManager manager] didReceiveSilentRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark- 微信代理
///如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
-(void) onResp:(BaseResp*)resp {
    if (resp.errCode == 0) {
        [CYTToast successToastWithMessage:@"分享成功"];
        //反馈分享结果(车源、寻车)
        [CYTShareManager feedBackShareResultWithType:self.wxShareType andBusinessId:self.wxShareBusinessId];
    }else if (resp.errCode == -2) {
        [CYTToast errorToastWithMessage:@"取消分享"];
    }else {
        [CYTToast errorToastWithMessage:@"分享失败"];
    }
}

#pragma mark- url处理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleURL:url];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [self handleURL:url];
}


#warning 不可修改
- (BOOL)handleURL:(NSURL *)url {
    //轩辕大数据统计
    [C4BraveSDK handleOpenURL:url];
    
    //不可改动 kappschemeSmall
    //支付宝
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kPayResultNotiKey object:resultDic];
        }];
        return YES;
    }
 
    //自定义跳转
    if ([url.scheme isEqualToString:kappschemeSmall] || [url.scheme isEqualToString:kAppScheme]) {
        //app自定义跳转处理，使用scheme判断
        return [[CYTLinkHandler new] handleAPPInnerLinkWithURL:url.absoluteString];
    }
    
    //微信分享
    if ([url.scheme isEqualToString:@"wxfd99fd1538ffcc7a"]) {
        //微信分享
        return [WXApi handleOpenURL:url delegate:self];
    }

    return YES;
}

////ios9 以上深度链接跳转app方法
//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
//    if (![userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
//        return YES;
//    }
//
////    NSURL *webUrl = userActivity.webpageURL;
////    [[CYTMessageCenterVM manager] handleMessageURL:webUrl.absoluteString];
//    return YES;
//}

#pragma mark-
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self addObserver];
    [self checkNetWork];
    [self avoidCrash];
    [self statusBarConifg];
    //第三方设置
    [self loadSettingForThirPlatWithOptions:launchOptions];

    //首页
    [self finishLaunching];
//    [self applicationShortcutItemConfig];
    return YES;
}

/**
 *  监听通知
 */
- (void)addObserver{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kGoMainHomeViewKey object:nil] subscribeNext:^(id x) {
        [self goHomeView];
    }];
}

/**
 *  避免部分崩溃
 */
- (void)avoidCrash{
#ifdef DEBUG
#else
    [AvoidCrash becomeEffective];
#endif
}
/**
 *  状态栏设置
 */
- (void)statusBarConifg{
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
   [CYTApplication setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}
/**
 *  网络状态监控
 */
- (void)checkNetWork{
    //本地设置
    self.appManager = [CYTAppManager sharedAppManager];
    [self.appManager checkNetWork];
}
/**
 *  3DTouch shortcutItem
 */
- (void)applicationShortcutItemConfig{
    UIApplicationShortcutIcon *publishSeekcarIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *publishSeekcarItem = [[UIApplicationShortcutItem alloc] initWithType:@"publishSeekcarItem" localizedTitle:@"发布寻车" localizedSubtitle:nil icon:publishSeekcarIcon userInfo:nil];
    
    UIApplicationShortcutIcon *publishCarsourceIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *publishCarsourceItem = [[UIApplicationShortcutItem alloc] initWithType:@"publishCarsourceItem" localizedTitle:@"发布车源" localizedSubtitle:nil icon:publishCarsourceIcon userInfo:nil];
    
    UIApplicationShortcutIcon *publishCircleIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutItem *publishCircleItem = [[UIApplicationShortcutItem alloc] initWithType:@"publishCircleItem" localizedTitle:@"发车商圈" localizedSubtitle:nil icon:publishCircleIcon userInfo:nil];
    
    UIApplicationShortcutIcon *searchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *searchItem = [[UIApplicationShortcutItem alloc] initWithType:@"searchItem" localizedTitle:@"搜索" localizedSubtitle:nil icon:searchIcon userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[publishSeekcarItem,publishCarsourceItem,publishCircleItem,searchItem];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [[NSNotificationCenter defaultCenter] postNotificationName:CYTTabBarDidSelectNotification object:nil userInfo:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
