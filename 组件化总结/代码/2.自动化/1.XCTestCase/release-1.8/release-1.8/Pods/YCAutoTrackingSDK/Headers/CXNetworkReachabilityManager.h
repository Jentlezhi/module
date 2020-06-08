//
//  CXNetworkReachabilityManager.h
//  Pods
//
//  Created by ishaolin on 2017/7/4.
//
//

#import <Foundation/Foundation.h>
#import "CXExternDefines.h"

typedef NS_ENUM(NSInteger, CXNetworkReachabilityStatus){
    CXNetworkReachabilityStatusNone = 0, // 无网络
    CXNetworkReachabilityStatusWiFi = 1, // WiFi
    CXNetworkReachabilityStatusWWAN = 2  // Wireless Wide Area Network
};

typedef NSString *CXNetworkStatusText;

@interface CXNetworkReachabilityManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)startMonitor;

- (void)stopMonitor;

- (CXNetworkReachabilityStatus)currentNetworkReachabilityStatus;

- (CXNetworkStatusText)currentNetworkReachabilityStatusString;

- (BOOL)connectionRequired;

- (BOOL)isReachable;

- (NSString *)carrierName;

@end

CX_FOUNDATION_EXTERN NSNotificationName const CXNetworkReachabilityChangedNotification;

CX_FOUNDATION_EXTERN CXNetworkStatusText const CXNetworkReachabilityStatusTextWiFi;
CX_FOUNDATION_EXTERN CXNetworkStatusText const CXNetworkReachabilityStatusText2G;
CX_FOUNDATION_EXTERN CXNetworkStatusText const CXNetworkReachabilityStatusText3G;
CX_FOUNDATION_EXTERN CXNetworkStatusText const CXNetworkReachabilityStatusText4G;
CX_FOUNDATION_EXTERN CXNetworkStatusText const CXNetworkReachabilityStatusTextUnknown;
