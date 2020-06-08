//
//  CYTCarContactsViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTCarContactsModel;

typedef enum : NSUInteger {
    CYTCarContactsTypeReceiverDefault = 0,     //收车联系人
    CYTCarContactsTypeSenderDefault,           //发车联系人
    CYTCarContactsTypeReceiverSelect,          //收车联系人选择
    CYTCarContactsTypeSenderSelect,            //发车联系人选择
} CYTCarContactsType;

@interface CYTCarContactsViewController : CYTBasicViewController

+ (instancetype)carContactsWithType:(CYTCarContactsType)carContactsType;
/** 选择联系人的地址回调 */
@property(copy, nonatomic) void(^carContactBlock)(CYTCarContactsModel *carContactsModel);


@end
