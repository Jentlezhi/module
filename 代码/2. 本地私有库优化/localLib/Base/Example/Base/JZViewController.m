//
//  JZViewController.m
//  Base
//
//  Created by jentlezhi on 06/10/2020.
//  Copyright (c) 2020 jentlezhi. All rights reserved.
//

#import "JZViewController.h"
#import "UIView+Extension.h"

@interface JZViewController ()

@end

@implementation JZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *v;
    v.centerX = self.view.width*0.5;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
