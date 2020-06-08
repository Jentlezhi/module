//
//  CYTLaunchAdManager.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CYTLaunchAdTypeImage,//图片/gif广告
    CYTLaunchAdTypeVideo,//视频广告
} CYTLaunchAdType;

@interface CYTLaunchAdManager : NSObject

/** 广告停留时间:默认5s */
@property(assign, nonatomic) NSInteger adsStayTime;
/** 等待数据请求时间:默认3s */
@property(assign, nonatomic) NSInteger waitDataDuration;
/** 广告类型：默认图片/gif广告 */
@property(assign, nonatomic) CYTLaunchAdType launchAdType;
/** 切换到前台是否显示广告:默认不显示 */
@property(assign, nonatomic) BOOL showWhenEnterForeground;
/** 广告图片Url */
@property(copy, nonatomic) NSString *imageUrl;
/** 广告视频Url */
@property(copy, nonatomic) NSString *videoUrl;
/** 点击打开链接 */
@property(copy, nonatomic) NSString *openUrl;

+ (instancetype)sharedLaunchAdManager;
/**
 * 加载数据
 */
- (void)requestLaunchData;
/**
 * 显示启动广告
 */
- (void)showLaunchAd;

@end
