//
//  CYTLaunchAdManager.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLaunchAdManager.h"
#import "CYTSpreadAdModel.h"
#import "XHLaunchAdDownloader.h"
#import "XHLaunchAd.h"

#define kLaunchAdfilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"launchAdInfo"]


@interface CYTLaunchAdManager()

/** 图片启动工具 */
@property(strong, nonatomic) XHLaunchImageAdConfiguration *imageAdconfiguration;

@end

@implementation CYTLaunchAdManager

/**
 *  单例
 */
+ (instancetype)sharedLaunchAdManager{
    static CYTLaunchAdManager *launchAdManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launchAdManager = [[CYTLaunchAdManager alloc] init];
    });
    return launchAdManager;
}

- (instancetype)init{
    if (self = [super init]) {
        self.launchAdType = CYTLaunchAdTypeImage;
        self.waitDataDuration = 3.f;
        self.adsStayTime = 5.f;
        self.showWhenEnterForeground = NO;
    }
    return self;
}

- (void)showLaunchAd{
    [self requestLaunchData];
    NSDictionary *dictData = [NSDictionary dictionaryWithContentsOfFile:kLaunchAdfilePath];
    CYTSpreadAdModel *spreadAdModel = [CYTSpreadAdModel mj_objectWithKeyValues:dictData];
    [self showLaunchAdsWithModel:spreadAdModel];
}

- (void)requestLaunchData{
    [CYTNetworkManager GET:kURL.basic_index_getSpreadAd parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        NSDictionary *dictData = [responseObject.dataDictionary valueForKey:@"spreadAd"];
        if (!dictData)return;
        CYTSpreadAdModel *spreadAdModel = [CYTSpreadAdModel mj_objectWithKeyValues:dictData];
        [dictData writeToFile:kLaunchAdfilePath atomically:YES];
        if (spreadAdModel.imageUrl.length) {
            [[XHLaunchAdImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:spreadAdModel.imageUrl] options:self.imageAdconfiguration.imageOption progress:nil completed:nil];
        }
    }];
}

- (void)showLaunchAdsWithModel:(CYTSpreadAdModel *)spreadAdModel{
    if (!spreadAdModel.isDisplay) return;
    [XHLaunchAd setWaitDataDuration:self.waitDataDuration];
    self.imageAdconfiguration.imageNameOrURLString = spreadAdModel.imageUrl;
    self.imageAdconfiguration.openURLString = spreadAdModel.protocol;
    [XHLaunchAd imageAdWithImageAdConfiguration:self.imageAdconfiguration delegate:self];
}

- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString{
    [[CYTMessageCenterVM manager] handleMessageURL:openURLString];
}
#pragma mark - 懒加载
- (XHLaunchImageAdConfiguration *)imageAdconfiguration{
    if (!_imageAdconfiguration) {
        _imageAdconfiguration = [XHLaunchImageAdConfiguration new];
        _imageAdconfiguration.duration = self.adsStayTime;
        _imageAdconfiguration.frame = [UIScreen mainScreen].bounds;
        _imageAdconfiguration.GIFImageCycleOnce = NO;
        _imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
        _imageAdconfiguration.showFinishAnimateTime = 0.8f;
        _imageAdconfiguration.imageOption = XHLaunchAdImageCacheInBackground;
        _imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
        _imageAdconfiguration.skipButtonType = SkipTypeRoundProgressText;
        _imageAdconfiguration.showEnterForeground = self.showWhenEnterForeground;
    }
    return _imageAdconfiguration;
}

@end
