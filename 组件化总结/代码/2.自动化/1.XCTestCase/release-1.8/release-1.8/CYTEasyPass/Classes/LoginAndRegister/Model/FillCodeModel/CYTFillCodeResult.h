//
//  CYTFillCodeResult.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTFillCodeResult : NSObject

/** 结果 */
@property(assign, nonatomic) BOOL Result;
/** 信息 */
@property(copy, nonatomic) NSString *Message;
/** 版本 */
@property(copy, nonatomic) NSString *Version;

@end
