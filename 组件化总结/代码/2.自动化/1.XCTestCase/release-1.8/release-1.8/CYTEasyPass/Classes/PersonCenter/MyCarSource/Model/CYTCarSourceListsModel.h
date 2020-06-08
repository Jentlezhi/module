//
//  CYTCarSourceListsModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCarSourceListsModel : NSObject

/** 数据 */
@property(strong, nonatomic) NSArray *list;
/** 是否有更多数据 */
@property(assign, nonatomic) BOOL isMore;

@end
