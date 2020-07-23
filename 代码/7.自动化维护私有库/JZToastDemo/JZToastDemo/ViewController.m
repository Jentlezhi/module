//
//  ViewController.m
//  JZToastDemo
//
//  Created by Jentle on 2020/7/23.
//  Copyright © 2020 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "JZToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [JZToast successToastWithMessage:@"成功"];
}


@end
