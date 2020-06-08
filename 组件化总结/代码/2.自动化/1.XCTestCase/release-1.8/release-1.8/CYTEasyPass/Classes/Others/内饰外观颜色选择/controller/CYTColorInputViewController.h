//
//  CYTColorInputViewController.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTGetColorBasicVM.h"

@interface CYTColorInputViewController : CYTBasicViewController
@property (nonatomic, strong) CYTGetColorBasicVM *viewModel;
@property (nonatomic, assign) BOOL inColor;

@end
