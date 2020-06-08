//
//  CYTNavigationController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTNavigationController.h"

@implementation CYTNavigationController

- (instancetype)init{
    if (self = [super init]) {
        self.navigationBar.alpha = 0.f;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfig];
    
}
/**
 *  基本配置
 */
- (void)basicConfig{
//    self.navigationBar.hidden = YES;
}
/**
 *  push到次级页面隐藏bottomBar
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    viewController.navigationController.navigationBar.hidden = YES;
    [super pushViewController:viewController animated:animated];
    
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated{
    modalViewController.navigationController.navigationBar.hidden = YES;
    [super presentModalViewController:modalViewController animated:animated];
}


@end
