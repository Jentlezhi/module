//
//  CYTCoinHeaderModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCoinSectionModel : NSObject

/** 标题 */
@property(copy, nonatomic) NSString *title;
/** 内容 */
@property(copy, nonatomic) NSString *content;
/** 元素 */
@property(strong, nonatomic) NSMutableArray *items;

@end
