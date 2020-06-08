//
//  FFBasicMacro.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#ifndef FFBasicMacro_h
#define FFBasicMacro_h

#pragma mark- 第三方库
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#pragma mark- common
#define kFFAnimationDuration    (0.25)


//#define kFFDebug    1
#define kFFDebugViewColor   ([UIColor redColor])


#pragma mark- device
#define kFF_IPHONE_SYSTEMVERSION    ([[UIDevice currentDevice] systemVersion])

#define kFF_SCREEN_WIDTH    ([[UIScreen mainScreen]bounds].size.width)
#define kFF_SCREEN_HEIGHT  ([[UIScreen mainScreen]bounds].size.height)

#define kFF_APP_NAME          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kFF_APP_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kFF_APP_BUILD_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#define kFF_IS_IPAD         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kFF_IS_IPHONE       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kFF_IS_IPHONE_4     (kFF_IS_IPHONE && kFF_SCREEN_HEIGHT < 568.0)
#define kFF_IS_IPHONE_5     (kFF_IS_IPHONE && kFF_SCREEN_HEIGHT == 568.0)
#define kFF_IS_IPHONE_6     (kFF_IS_IPHONE && kFF_SCREEN_HEIGHT == 667.0)
#define kFF_IS_IPHONE_6P    (kFF_IS_IPHONE && kFF_SCREEN_HEIGHT == 736.0)

#pragma mark- log
#ifdef DEBUG
#define kFFLog_Debug( s, ... ) NSLog( @"\n<mem=%p,file=%@,line=%d,fun=(%@)>\n%@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define kFFLog_Debug( s, ... )
#endif

#endif /* FFBasicMacro_h */
