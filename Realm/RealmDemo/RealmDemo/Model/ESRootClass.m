//
//Created by ESJsonFormatForMac on 20/06/10.
//

#import "ESRootClass.h"
@implementation ESRootClass

+ (NSString *)primaryKey {
    
    return @"ID";
}

+ (NSArray<NSString *> *)ignoredProperties {
    
    return @[@"list",@""];
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"ID":@0};
}

@end

@implementation List

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end

@implementation Data

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end


