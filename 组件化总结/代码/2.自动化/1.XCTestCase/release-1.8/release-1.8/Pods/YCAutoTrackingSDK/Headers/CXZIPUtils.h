//
//  CXZIPUtils.h
//  Pods
//
//  Created by ishaolin on 2017/7/12.
//
//

#import <Foundation/Foundation.h>
#import "CXExternDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface CXZIPUtils : NSObject

// zip data failed, return nil.
+ (nullable NSData *)zipData:(NSData *)data error:(NSError * _Nullable __autoreleasing * _Nullable)error;

// unzip data failed, return nil.
+ (nullable NSData *)unzipData:(NSData *)data error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end

CX_FOUNDATION_EXTERN NSError *_CXZIPErrorMake(NSInteger code, NSString *msg);

NS_ASSUME_NONNULL_END
