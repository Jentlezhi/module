//
//  DataModel.h
//  RealmDemo
//
//  Created by Jentle on 2020/6/14.
//Copyright © 2020 Jentle. All rights reserved.
//

#import <Realm/Realm.h>

@interface DataModel : RLMObject
@property int a;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<DataModel *><DataModel>
RLM_ARRAY_TYPE(DataModel)
