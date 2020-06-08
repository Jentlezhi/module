//
//  FFBasicModel.m
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFBasicModel.h"

@implementation FFBasicModel

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
