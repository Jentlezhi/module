//
//  Student.m
//  RealmDemo
//
//  Created by Jentle on 2020/6/11.
//Copyright © 2020 Jentle. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (NSString *)primaryKey{
    
    return @"number";
}

+ (NSArray<NSString *> *)requiredProperties {
    
    return @[@"name"];
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{@"number":@0};
//}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"ageStr"];
}

@end
