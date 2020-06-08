//
//  CYTGetContactedMeListViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTGetContactedMeListPar.h"

@class CYTGetContactedMeListPar;

@interface CYTGetContactedMeListViewModel : NSObject

/** 请求参数 */
@property(strong, nonatomic) CYTGetContactedMeListPar *getContactedMeListPar;
/** 请求类型 */
@property(assign, nonatomic) CYTRequestType requestType;
/** 获取联系记录数据 */
@property(strong, nonatomic) RACCommand *getContactedMeListCommand;

@end
