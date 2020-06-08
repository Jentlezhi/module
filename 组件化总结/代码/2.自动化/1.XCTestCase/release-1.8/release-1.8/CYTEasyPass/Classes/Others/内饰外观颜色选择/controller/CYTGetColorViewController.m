//
//  CYTGetColorViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetColorViewController.h"
#import "CYTColorInputViewController.h"
#import "CYTGetColorConst.h"

@interface CYTGetColorViewController ()

@end

@implementation CYTGetColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inColor = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getColorFinished) name:kGetColorFinished object:nil];
}

- (void)getColorFinished {
    if (self.getColorFinishedBlock) {
        self.getColorFinishedBlock(self.viewModel);
    }
    //返回
    [self.navigationController popToViewController:self.parentCtr animated:YES];
}

@end
