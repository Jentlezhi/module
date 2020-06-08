//
//  CGDZNCustomViewModel.m
//  Pcms
//
//  Created by xujunquan on 16/10/20.
//  Copyright © 2016年 cig. All rights reserved.
//

#import "FFDZNCustomViewModel.h"

@implementation FFDZNCustomViewModel

#pragma mark- set/get
- (RACSubject *)requestAgainSubject {
    if (!_requestAgainSubject) {
        _requestAgainSubject = [RACSubject subject];
    }
    return _requestAgainSubject;
}

@end
