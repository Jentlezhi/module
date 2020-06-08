//
//  CYTEditCarContactsViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
@class CYTCarContactsModel;
typedef enum : NSUInteger {
    CYTEditCarContactsTypeReceiverSave = 0,    //收车联系人保存
    CYTEditCarContactsTypeReceiverEdit,        //收车联系人编辑
    CYTEditCarContactsTypeSenderSave,          //发车联系人保存
    CYTEditCarContactsTypeSenderEdit,          //发车联系人编辑
} CYTEditCarContactsType;

@interface CYTEditCarContactsViewController : CYTBasicViewController

+ (instancetype)editCarContactsWithType:(CYTEditCarContactsType)editCarContactsType;

/** 联系人类型 */
@property(assign, nonatomic) CYTEditCarContactsType carContactsType;

/** 联系人模型 */
@property(strong, nonatomic) CYTCarContactsModel *carContactsModel;

@property(copy, nonatomic) void(^editSuccess)();

@end
