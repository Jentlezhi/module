//
//  JZPrint.m
//  MRCFramework
//
//  Created by Jentle on 2017/12/28.
//  Copyright © 2017年 Jentle. All rights reserved.
//

#import "JZPrint.h"

@implementation JZPrint


+ (void)print {
    NSObject *obj = NSObject.new;
    [obj release];
    NSLog(@"我是MRC下JZPrint静态库");
}

@end
