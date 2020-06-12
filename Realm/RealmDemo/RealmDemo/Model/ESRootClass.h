//
//Created by ESJsonFormatForMac on 20/06/10.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <YYModel/YYModel.h>

@class Data,List;

@interface ESRootClass : RLMObject<YYModel>

@property BOOL result;

@property Data *data;

@property NSString *message;

@property NSInteger errorCode;

@property NSInteger version;

@property NSInteger ID;

@end

RLM_ARRAY_TYPE(List)

@interface Data : RLMObject<YYModel>

@property BOOL isHint;

@property NSString *viewModelUrl;

@property BOOL isMore;

@property NSInteger total;
///一对多
@property RLMArray<List*><List> *list;

@property NSString *moreUrl;

@property NSString *url;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Data *><Data>
RLM_ARRAY_TYPE(Data)

@interface List : RLMObject<YYModel>

@property NSInteger newsId;

@property NSString *publishTimeStr;

@property NSString *relateSerialId;

@property NSString *title;

@property NSInteger categoryId;

@property RLMArray<NSString*><RLMString> *cover;

@property NSString *newsUrl;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<List *><List>
//RLM_ARRAY_TYPE(List)


