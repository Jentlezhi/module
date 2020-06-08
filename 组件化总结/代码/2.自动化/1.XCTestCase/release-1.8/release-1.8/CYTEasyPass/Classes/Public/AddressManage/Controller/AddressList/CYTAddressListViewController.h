//
//  CYTAddressListViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTAddressModel;

typedef enum : NSUInteger {
    CYTAddressListTypeDefault = 0,     //默认模式
    CYTAddressListTypeSelect,          //选择模式
} CYTAddressListType;

@interface CYTAddressListViewController : CYTBasicViewController

+ (instancetype)addressListWithType:(CYTAddressListType)addressListType;
/** 已选择地址 */
@property(strong, nonatomic) CYTAddressModel *addressModel;
/** 选择地址回调 */
@property(copy, nonatomic) void(^addressSelectBlock)(CYTAddressModel *addressModel);

@end
