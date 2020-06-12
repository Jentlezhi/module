//
//  Student.h
//  RealmDemo
//
//  Created by Jentle on 2020/6/11.
//Copyright © 2020 Jentle. All rights reserved.
//

#import <Realm/Realm.h>

@interface Student : RLMObject

@property NSInteger number;
@property NSInteger age;
@property NSString *name;
@property NSString *ageStr;

@end
// This protocol enables typed collections. i.e.:
// RLMArray<Student *><Student>
RLM_ARRAY_TYPE(Student)
