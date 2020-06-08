//
//  CYTCarSourcePublishItemModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourcePublishItemModel.h"

@implementation CYTCarSourcePublishItemModel

- (instancetype)init {
    if (self = [super init]) {
        _placeholder = @"请选择";
    }
    return self;
}

- (NSMutableArray *)fileIdImageArray{
    if (!_fileIdImageArray) {
        _fileIdImageArray = [NSMutableArray array];
    }
    return _fileIdImageArray;
}

@end
