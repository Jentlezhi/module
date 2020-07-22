//
//  MRCPrint.m
//  MRCDemo
//
//  Created by Jentle on 2017/12/28.
//  Copyright © 2017年 Jentle. All rights reserved.
//

#import "MRCPrint.h"

@implementation MRCPrint

+ (void)print {
    NSObject *obj = NSObject.new;
    [obj release];
    NSLog(@"我是MRC下MRCPrint");
}

@end
