//
//  Dog.h
//  RealmDemo
//
//  Created by Jentle on 2020/6/11.
//Copyright © 2020 Jentle. All rights reserved.
//

#import <Realm/Realm.h>

@class Person;

@interface Dog : RLMObject

@property int num;
@property NSString *name;
///readonly,
@property (readonly)RLMLinkingObjects *master;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Dog *><Dog>
RLM_ARRAY_TYPE(Dog)
