//
//  CXBaseResponseModel.h
//  Pods
//
//  Created by ishaolin on 2017/7/3.
//
//

#import "CXBaseModel.h"

@interface CXBaseResponseModel : CXBaseModel

@property (nonatomic, assign, readonly) BOOL isValid;

@property (nonatomic, strong, readonly, nullable) NSNumber *code;

@property (nonatomic, copy, readonly, nullable) NSString *msg;

@end
