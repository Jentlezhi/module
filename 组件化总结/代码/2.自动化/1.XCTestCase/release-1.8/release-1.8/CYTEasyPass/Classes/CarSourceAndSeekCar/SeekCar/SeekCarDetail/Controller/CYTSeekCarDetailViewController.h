//
//  CYTSeekCarDetailViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

typedef enum : NSUInteger {
    CYTSeekCarDetailTypeSelf = 1, //自己的需求详情
    CYTSeekCarDetailTypeOthersSeekCar,//他的寻车
    CYTSeekCarDetailTypeOrderDetail,//订单详情
} CYTSeekCarDetailType;

@interface CYTSeekCarDetailViewController : CYTBasicViewController

/** 寻车ID */
@property(copy, nonatomic) NSString *seekCarId;
/** 用户id */
@property(assign, nonatomic) NSInteger userId;
/** 需求详情类型 */
@property(assign, nonatomic) CYTSeekCarDetailType seekCarDetailType;

@end
