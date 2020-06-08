//
//  CYTOnSaleCarSourceViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
// 在售车源
/*
 CYTOnSaleCarSourceViewController *imagePickerNavController = [CYTOnSaleCarSourceViewController onSaleCarSourceWithType:CYTOnSaleCarSourceTypeOtherList];
 imagePickerNavController.userId = 2145;
 [self.navigationController pushViewController:imagePickerNavController animated:YES];
 */

#import "CYTBasicTableViewController.h"


@interface CYTOnSaleCarSourceViewController : CYTBasicTableViewController

/** 用户ID */
@property(assign, nonatomic) NSInteger userId;



@end
