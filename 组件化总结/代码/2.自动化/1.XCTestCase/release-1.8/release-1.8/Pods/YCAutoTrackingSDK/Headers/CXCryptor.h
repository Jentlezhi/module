//
//  CXCryptor.h
//  Pods
//
//  Created by ishaolin on 2017/7/12.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXCryptor : NSObject

+ (NSString *)SHA1:(NSString *)string;

+ (NSString *)MD5:(NSString *)string;

+ (nullable NSData *)encryptDataByAES128:(NSData *)data privateKey:(NSString *)key;

+ (nullable NSData *)decryptDataByAES128:(NSData *)data privateKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
