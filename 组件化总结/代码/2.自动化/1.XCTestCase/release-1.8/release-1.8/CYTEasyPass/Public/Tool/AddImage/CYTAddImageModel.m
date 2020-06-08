
//
//  CYTAddImageModel.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddImageModel.h"

@implementation CYTAddImageModel

- (instancetype)init {
    if (self = [super init]) {
        _imageMaxNum = 9;
        _perLineNum = 5;
    }
    return self;
}

- (float)imageWH {
    return ((kScreenWidth - 2*CYTAutoLayoutH(30) - 1.0*(self.perLineNum-1)*imageMargin)/self.perLineNum);
}

- (void)setImageModelArray:(NSMutableArray *)imageModelArray {
    if (imageModelArray.count>self.imageMaxNum) {
        _imageModelArray = [imageModelArray subarrayWithRange:NSMakeRange(0, self.imageMaxNum)].mutableCopy;
    }else {
        _imageModelArray = imageModelArray;
    }
}

@end
