//
//  ViewController.m
//  BaseDemo
//
//  Created by Jentle on 2020/6/10.
//  Copyright © 2020 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = UIView.new;
    view.centerX = UIScreen.mainScreen.bounds.size.width*0.5;
    [self.view addSubview:view];
}


@end
