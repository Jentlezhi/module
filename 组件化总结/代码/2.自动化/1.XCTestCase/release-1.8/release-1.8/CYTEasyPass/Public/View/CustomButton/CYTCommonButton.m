//
//  CYTCommonButton.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommonButton.h"

@implementation CYTCommonButton

+ (instancetype)commonButtonWithTitle:(NSString *)title action:(void(^)(CYTCommonButton *))actionBlock{
    CYTCommonButton *customBtn = [CYTCommonButton buttonWithTitle:title];
    [[customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !actionBlock?:actionBlock(customBtn);
    }];
    return customBtn;
}



@end
