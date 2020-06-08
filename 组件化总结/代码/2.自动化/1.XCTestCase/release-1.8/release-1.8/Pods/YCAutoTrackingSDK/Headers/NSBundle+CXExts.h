//
//  NSBundle+CXExts.h
//  Pods
//
//  Created by ishaolin on 2017/9/4.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (CXExts)

@property (nonatomic, copy, readonly) NSString *c4_appName;         // CFBundleDisplayName
@property (nonatomic, copy, readonly) NSString *c4_appId;           // CFBundleIdentifier
@property (nonatomic, copy, readonly) NSString *c4_appVersion;      // CFBundleShortVersionString
@property (nonatomic, copy, readonly) NSString *c4_buildVersion;    // CFBundleVersion
@property (nonatomic, copy, readonly) NSString *c4_executableName;  // CFBundleExecutable

@end
