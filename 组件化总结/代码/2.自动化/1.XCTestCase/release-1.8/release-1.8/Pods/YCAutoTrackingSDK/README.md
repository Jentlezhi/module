# YCAutoTrackingSDK

[![CI Status](https://img.shields.io/travis/wangshaolin/YCAutoTrackingSDK.svg?style=flat)](http://travis-ci.org/wangshaolin/YCAutoTrackingSDK)
[![Version](https://img.shields.io/cocoapods/v/YCAutoTrackingSDK.svg?style=flat)](http://cocoapods.org/pods/YCAutoTrackingSDK)
[![License](https://img.shields.io/cocoapods/l/YCAutoTrackingSDK.svg?style=flat)](http://cocoapods.org/pods/YCAutoTrackingSDK)
[![Platform](https://img.shields.io/cocoapods/p/YCAutoTrackingSDK.svg?style=flat)](http://cocoapods.org/pods/YCAutoTrackingSDK)

![](http://gitlab.bitautotech.com/wangshaolin/YCAutoTrackingSDK/raw/master/%E5%9C%88%E9%80%89%E8%BF%87%E7%A8%8B.gif)

## 系统要求

动态库(framework)和静态库(.a + Header)都从iOS8开始支持【主要针对新的UI组件的支持：UIAlertController、WKWebView】。

## SDK安装

YCAutoTrackingSDK 通过[CocoaPods](http://cocoapods.org)集成，请按需将下面的其中一行加入到工程的Podfile文件中:

```ruby
# 以动态库(framework)的方式集成，从iOS8开始支持（以前的老工程升级从iOS8支持的也不支持）
pod "YCAutoTrackingSDK/Dynamic", :git => "git@gitlab.bitautotech.com:wangshaolin/YCAutoTrackingSDK.git", :tag => "201711091433"

# 以静态库(.a + Header)的方式集成，从iOS8开始支持，支持以前的老工程
pod "YCAutoTrackingSDK/Static", :git => "git@gitlab.bitautotech.com:wangshaolin/YCAutoTrackingSDK.git", :tag => "201711091433"
```

## 接入代码

```objective-c
#import <YCAutoTrackingSDK/YCAutoTrackingSDK.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置appkey和渠道id
    [C4BraveSDK launchWithOptions:options
                           appKey:@"4793987ED0CA46C693A9D81E0B9F4D98"
                          channel:@"yc_ad_hoc"
                  enableAutoTrack:YES];
    // log开关(上线请务必关闭)
    // [C4BraveSDK setLogEnabled:NO];
    
    ......
    
    return YES;
}
```

## 事件埋点代码

```objective-c
[C4BraveSDK recordEvent:@"eventId" params:@{@"key" : @"value"}];
```

## handleOpenURL（用于唤醒圈选）
    
修改Info.plist，在CFBundleURLTypes中增加以下配置：其中“com.yiche.AutoReport”是app的bundleId, “autotrack.e3b3404f”是跳转openURL的scheme,
    具体值请联系大数据中心部门获取，联系人：吴晓泉 <wuxiaoquan@yiche.com> 或者 汪绍林 <wangshaolin@yiche.com>。
```xml
    <dict>
        <key>CFBundleURLName</key>
        <string>com.yiche.AutoReport</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>autotrack.e3b3404f</string>
        </array>
    </dict>
```

```objective-c
#pragma mark - handleOpenURL

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [C4BraveSDK handleOpenURL:url];
    
    ......

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [C4BraveSDK handleOpenURL:url];

    ......
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    [C4BraveSDK handleOpenURL:url];
    
    ......
    
    return YES;
}
```

## 注意事项

* 如果已经接入过旧版的SDK，需要手动删除对应的头文件和.a文件；
* 我们建议都使用[CocoaPods](http://cocoapods.org)的方式集成SDK，这样可以减少部分工作量，例如：SDK依赖库的引入、后续SDK升级等；
* [[C4BraveSDK launchWithOptions:appKey:channel:enableAutoTrack:]](http://gitlab.bitautotech.com/wangshaolin/YCAutoTrackingSDK/blob/master/YCAutoTrackingSDK/Headers/C4BraveSDK.h)方法的enableAutoTrack参数可以控制是否开启自动埋点，YES:开启，NO:不开启，此方法禁止重复调用。

## 系统库依赖

使用[CocoaPods](http://cocoapods.org)集成请忽略。

* UIKit.framework
* Foundation.framework
* CoreGraphics.framework
* QuartzCore.framework
* CoreLocation.framework
* CoreTelephony.framework
* SystemConfiguration.framework
* CoreFoundation.framework
* Security.framework
* libz.1.2.5.tbd
* libsqlite3.tbd

## 技术支持

大数据中心, wangshaolin@yiche.com
