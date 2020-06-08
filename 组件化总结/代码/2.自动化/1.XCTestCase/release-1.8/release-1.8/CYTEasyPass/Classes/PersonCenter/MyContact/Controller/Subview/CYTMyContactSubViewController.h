//
//  CYTMyContactSubViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

typedef NS_ENUM(NSUInteger, CYTMyContactSubViewType) {
    CYTMyContactSubViewTypeCarSource = 1,//车源
    CYTMyContactSubViewTypeSeekCar,//寻车
};

@interface CYTMyContactSubViewController : CYTBasicViewController

+ (instancetype)subViewControllerWithType:(CYTMyContactSubViewType)myContactSubViewType;

@end
