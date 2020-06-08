//
//  CYTGetMyContactListViewModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTGetMyContactListPar.h"

@interface CYTGetMyContactListViewModel : NSObject
/** 请求类型 */
@property(assign, nonatomic) CYTRequestType requestType;
/** 获取联系记录数据：车源 */
@property(strong, nonatomic) RACCommand *getMyContactedCarSourceListCommand;
/** 获取联系记录数据：寻车 */
@property(strong, nonatomic) RACCommand *getMyContactedSeekCarListCommand;

@end
