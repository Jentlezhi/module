//
//  CYTMyAccountCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyAccountCtr.h"
#import "CYTGetCashCtr.h"

@implementation CYTMyAccountCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"我的账户" andShowBackButton:YES showRightButtonWithTitle:@"提现"];
}

- (void)rightButtonClick:(UIButton *)rightButton {
    CYTGetCashCtr *ctr = [CYTGetCashCtr new];
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
