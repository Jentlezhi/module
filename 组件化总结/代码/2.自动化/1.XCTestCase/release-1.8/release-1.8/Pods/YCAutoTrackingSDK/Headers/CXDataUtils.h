//
//  CXDataUtils.h
//  Pods
//
//  Created by ishaolin on 2017/7/20.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXDataUtils : NSObject

/**
 * Use defalut AES128 private key encode data，steps：
 * 1. zip data
 * 2. AES128 encrypt data
 * 3. base64 encode data
 *
 * @param data original data
 * @param error zip error
 
 * @return encode data
 */
+ (nullable NSData *)encodeData:(NSData *)data error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Use defalut AES128 private key decode data，steps：
 * 1. base64 decode data
 * 2. AES128 decrypt data
 * 3. unzip data
 *
 * @param data Through `[CXDataUtils encodeData:error:]` return data
 * @param error unzip error
 
 * @return decode data(original data)
 */
+ (nullable NSData *)decodeData:(NSData *)data error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Encode data，steps：
 * 1. zip data
 * 2. AES128 encrypt data
 * 3. base64 encode data
 *
 * @param data original data
 * @param privateKey AES128 encrypt private key
 * @param error zip error
 
 * @return encode data
 */
+ (nullable NSData *)encodeData:(NSData *)data privateKey:(NSString *)privateKey error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
 * Decode data，steps：
 * 1. base64 decode data
 * 2. AES128 decrypt data
 * 3. unzip data
 *
 * @param data Through `[CXDataUtils encodeData:aesKey:error:]` return data
 * @param privateKey AES128 decrypt private key
 * @param error unzip error
 
 * @return decode data(original data)
 */
+ (nullable NSData *)decodeData:(NSData *)data privateKey:(NSString *)privateKey error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
