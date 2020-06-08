//
//  CXBaseModel+CXExts.h
//  Pods
//
//  Created by ishaolin on 2017/9/4.
//
//

#import "CXBaseModel.h"

@interface CXBaseModel (CXExts)

- (instancetype)initWithC4Data:(NSData *)data;

- (NSData *)c4_toData;

@end
