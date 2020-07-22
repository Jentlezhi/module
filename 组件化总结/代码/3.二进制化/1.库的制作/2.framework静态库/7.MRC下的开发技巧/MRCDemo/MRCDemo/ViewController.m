//
//  ViewController.m
//  MRCDemo
//
//  Created by Jentle on 2017/12/28.
//  Copyright © 2017年 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "JZPrint.h"
#import "MRCPrint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [JZPrint print];
    [MRCPrint print];

}


@end
