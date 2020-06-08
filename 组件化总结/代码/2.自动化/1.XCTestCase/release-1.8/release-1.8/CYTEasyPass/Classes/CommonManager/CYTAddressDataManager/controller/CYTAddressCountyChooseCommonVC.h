//
//  CYTAddressCountyChooseCommonVC.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendViewController.h"
#import "CYTAddressDataWNCManager.h"

@interface CYTAddressCountyChooseCommonVC : FFExtendViewController
@property (nonatomic, strong) CYTAddressDataWNCManager *viewModel;
@property (nonatomic, copy) void (^backBlock) (void);

@end
