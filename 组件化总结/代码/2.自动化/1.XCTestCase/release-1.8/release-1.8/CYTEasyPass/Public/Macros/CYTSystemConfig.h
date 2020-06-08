//
//  CYTSystemConfig.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/2/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 iPhone6 分辨率 750*1334 (自动布局，主要配合masonry使用)
 */
#define CYTAutoLayoutH(x)   ((x) * kScreenWidth/750.0)
#define CYTAutoLayoutV(y)   ((y) * kScreenHeight/1334.0)
/*
 * 屏幕尺寸
 */
#define kScreenWidth                ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight               ([UIScreen mainScreen].bounds.size.height)
#define kScreenBounds               ([UIScreen mainScreen].bounds)
/*
 * 系统Application
 */
#define CYTApplication                [UIApplication sharedApplication]
#define kAppdelegate                ((CYTAppDelegate *)([UIApplication sharedApplication].delegate))
#define kTabbarCtr                  ((CYTAppDelegate *)([UIApplication sharedApplication].delegate)).tabBarController

/*
 * 主窗口
 */
#define kWindow                       CYTApplication.keyWindow
/*
 * 状态栏高度
 */
#define CYTStatusBarHeight    [[UIApplication sharedApplication] statusBarFrame].size.height
/*
 * 导航栏高度
 */
#define CYTNavigationBarHeight    (44.f)
/*
 * 状态栏高度
 */
#define CYTTabBarHeight           (49.f)
/**
 *  自动提示宏
 */
#define CYTAutoAttr(objc,kPath) @(((void)objc.kPath,#kPath))
/**
 *  导航栏按钮间距
 */
#define CYTNavBarItemMarigin    CYTAutoLayoutH(40)
/**
 *  控制器view的Y坐标
 */
#define CYTViewOriginY         ((CYTNavigationBarHeight)+(CYTStatusBarHeight))
/**
 *  字体大小（根据像素计算大小）
 */
#define CYTFontWithPixel(x)      [UIFont systemFontOfSize:((x)/2.0)]
#define CYTBoldFontWithPixel(x)  [UIFont boldSystemFontOfSize:((x)/2.0)]

/**
 *  默认间距
 */
#define CYTDefaultMarigin      CYTAutoLayoutH(40)
/**
 *  导航栏分割线高度
 */
#define CYTNavBarLineHeight    0.6f
/**
 *  self弱引用
 */
#define CYTWeakSelf __weak typeof(self) weakSelf = self;
/**
 *  十六进制颜色转换
 */
#define CYTHexColor(hexColorString) [UIColor colorWithHexColor:hexColorString]

/**
 *  偏好设置取值
 */
#define CYTValueForKey(key)  [[NSUserDefaults standardUserDefaults] valueForKey:(key)]
/**
 *  设置UUID
 */
#define  CYTUUID              CYTValueForKey(CYTDeviceUUIDKey)
/**
 *  图片设置访问权限
 */
#define  CYTSetSDWebImageHeader \
SDWebImageDownloader *sdmanager = [SDWebImageManager sharedManager].imageDownloader;\
[sdmanager  setValue:CYTAuthorization forHTTPHeaderField:@"Authorization"];
/**
 *  iPhone5（s）设备特殊处理
 */
#define iPhone5_s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

