//
//  UIViewController+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/message.h>

static const char *key = "sessionDataTask";

@implementation UIViewController (Extension)

- (void)setSessionDataTask:(NSURLSessionDataTask *)sessionDataTask{
    objc_setAssociatedObject(self, key, sessionDataTask, OBJC_ASSOCIATION_RETAIN);
}

- (NSURLSessionDataTask *)sessionDataTask{
    return objc_getAssociatedObject(self, key);
}

@end
