//
//  CXBase64Utils.h
//  Pods
//
//  Created by ishaolin on 2017/7/13.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXBase64Utils : NSObject

+ (nullable NSData *)encodeBase64Data:(NSData *)data;

+ (nullable NSData *)decodeBase64Data:(NSData *)data;

+ (nullable NSString *)encodeBase64String:(NSString *)string;

+ (nullable NSString *)decodeBase64String:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
