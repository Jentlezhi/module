//
//  CXBaseModel.h
//  Pods
//
//  Created by ishaolin on 2017/7/4.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXBaseModel : NSObject<NSCopying>

@property (nonatomic, strong, readonly) NSDictionary<NSString *, id> *dictionary;

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

- (nullable id)c4ValueForKey:(NSString *)key; // If the value is NSNull class. then return nil.
- (BOOL)hasKey:(NSString *)key;

- (nullable NSString *)stringForKey:(NSString *)key;
- (nullable NSNumber *)numberForKey:(NSString *)key;

- (nullable NSArray *)arrayForKey:(NSString *)key;
- (nullable NSDictionary *)dictionaryForKey:(NSString *)key;

- (NSInteger)integerForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
