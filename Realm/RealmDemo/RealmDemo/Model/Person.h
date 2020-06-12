//
//  Person.h
//  RealmDemo
//
//  Created by Jentle on 2020/6/11.
//Copyright © 2020 Jentle. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dog.h"

@interface Person : RLMObject

@property int num;
@property NSString *name;
///一对多的写法：
@property RLMArray <Dog *><Dog> *pets;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Person *><Person>
RLM_ARRAY_TYPE(Person)
