//
//  NoticeModel.h
//  RealmDemo
//
//  Created by Jentle on 2020/6/13.
//Copyright © 2020 Jentle. All rights reserved.
//

#import <Realm/Realm.h>

@interface NoticeModel : RLMObject

@property int a;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<NoticeModel *><NoticeModel>
RLM_ARRAY_TYPE(NoticeModel)
