//
//  NSData+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "NSData+Extension.h"

static const char *fileIDKey = "fileIDKey";
static const char *IDKey = "IDKey";

@implementation NSData (Extension)

- (void)setFileID:(NSString *)fileID{
    objc_setAssociatedObject(self, fileIDKey, fileID, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)fileID{
    return objc_getAssociatedObject(self, fileIDKey);
}

- (void)setID:(NSInteger)ID{
    objc_setAssociatedObject(self, IDKey, [NSNumber numberWithInteger:ID], OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)ID{
    return [objc_getAssociatedObject(self, IDKey) integerValue];
}


@end
