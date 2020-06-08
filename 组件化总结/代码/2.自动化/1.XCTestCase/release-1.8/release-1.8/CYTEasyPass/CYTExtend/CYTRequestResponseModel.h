//
//  CYTRequestResponseModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTRequestResponseModel : NSObject
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL result;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, strong) NSDictionary *data;

@end
