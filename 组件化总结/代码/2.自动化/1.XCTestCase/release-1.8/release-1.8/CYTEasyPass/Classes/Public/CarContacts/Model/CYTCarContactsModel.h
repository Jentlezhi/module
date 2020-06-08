//
//  CYTCarContactsModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCarContactsModel : NSObject

/** 联系记录Id */
@property(copy, nonatomic) NSString *contactId;
/** 姓名 */
@property(copy, nonatomic) NSString *name;
/** 隐藏证件号 */
@property(copy, nonatomic) NSString *cerNumber;
/** 未隐藏证件号 */
@property(copy, nonatomic) NSString *cerNumberAll;
/** 证件类型名称 */
@property(copy, nonatomic) NSString *cerTypeName;
/** 证件类型Id 1:身份证 2:护照 */
@property(assign, nonatomic) int cerTypeId;
/** 电话 */
@property(copy, nonatomic) NSString *phone;
/** 是否默认 */
@property(assign, nonatomic) BOOL isDefault;
/** 联系人详情 */
@property(copy, nonatomic) NSString *customContactDetail;

@end
