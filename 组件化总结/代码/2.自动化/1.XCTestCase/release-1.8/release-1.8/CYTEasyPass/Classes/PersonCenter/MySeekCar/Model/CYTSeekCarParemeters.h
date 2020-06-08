//
//  CYTSeekCarParemeters.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTSeekCarParemeters : NSObject

/** 寻车状态 */
@property(assign, nonatomic) NSInteger seekCarStatus;
/** 末尾ID 首次0 */
@property(assign, nonatomic) NSInteger lastId;

@end
