//
//  MigrateModel.h
//  RealmDemo
//
//  Created by Jentle on 2020/6/14.
//Copyright © 2020 Jentle. All rights reserved.
//

#import <Realm/Realm.h>

@interface MigrateModel : RLMObject

@property NSString *name;
@property NSString *number;
@property int age;
@property NSString *fullName;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<MigrateModel *><MigrateModel>
RLM_ARRAY_TYPE(MigrateModel)
