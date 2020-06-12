//
//  Dog.m
//  RealmDemo
//
//  Created by Jentle on 2020/6/11.
//Copyright © 2020 Jentle. All rights reserved.
//

#import "Dog.h"
#import "Person.h"

@implementation Dog

+ (NSString *)primaryKey {
    
    return @"num";
}

+ (NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties {
    
    return @{@"master":[RLMPropertyDescriptor descriptorWithClass:Person.class propertyName:@"pets"]};
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
