//
//  CYTOrderCommitViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewController.h"

typedef enum : NSUInteger {
    CYTOrderCommitTypeBuyer = 0,//买家
    CYTOrderCommitTypeSeller,//卖家
} CYTOrderCommitType;

@interface CYTOrderCommitViewController : CYTBasicTableViewController

+ (instancetype)orderCommitViewControllerWithType:(CYTOrderCommitType)orderCommitType carID:(NSString *)carID;


@end
