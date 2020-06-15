//
//  Person.m
//  RealmDemo
//
//  Created by Jentle on 2020/6/11.
//Copyright © 2020 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSString *)primaryKey {
    
    return @"num";
}

///
+ (NSArray<NSString *> *)requiredProperties {
    
    return @[@"num"];
}

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
