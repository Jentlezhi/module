//
//  CYTEditCarContactsParemeters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTEditCarContactsParemeters : NSObject


/** 证件类型Id */
@property(assign, nonatomic) int certificateType;
/** 是否默认(0非默认，1默认) */
@property(assign, nonatomic) BOOL isDefault;
/** 电话 */
@property(copy, nonatomic) NSString *phone;
/** 联系记录Id(新增传0 */
@property(assign, nonatomic) int contactId;
/** 证件号 */
@property(copy, nonatomic) NSString *certificateNumber;
/** 姓名 */
@property(copy, nonatomic) NSString *name;
/** 0:收车 1:发车 */
@property(assign, nonatomic) int contactType;

@end
