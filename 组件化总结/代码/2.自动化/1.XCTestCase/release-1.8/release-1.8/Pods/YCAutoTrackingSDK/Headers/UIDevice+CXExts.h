//
//  UIDevice+CXExts.h
//  Pods
//
//  Created by ishaolin on 2017/9/4.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (CXExts)

@property (nonatomic, copy, readonly) NSString *c4_identifier;  // e.g. @"9E8A133A3BD54345BC139411CE7BE460"
@property (nonatomic, copy, readonly) NSString *c4_resolution;  // e.g. @"2208x1240"
@property (nonatomic, copy, readonly) NSString *c4_model;       // e.g. @"iPhone7,1"
@property (nonatomic, strong, readonly) NSNumber *c4_platform;  // Always @(1)->iOS platform
@property (nonatomic, assign, readonly) BOOL c4_isJailbreak;    // If jailbreak return YES, else return NO.

@end
