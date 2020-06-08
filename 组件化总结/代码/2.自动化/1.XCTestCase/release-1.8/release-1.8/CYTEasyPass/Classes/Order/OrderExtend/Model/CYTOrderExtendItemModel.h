//
//  CYTOrderExtendItemModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTOrderExtendItemModel : NSObject

/** 内容ID */
@property(copy, nonatomic) NSString *contentId;
/** 内容 */
@property(copy, nonatomic) NSString *content;
/** 是否选中 */
@property(assign, nonatomic) BOOL customHasSelect;
/** 是否最后一个 */
@property(assign, nonatomic) BOOL customLast;
/** 输入内容 */
@property(copy, nonatomic) NSString *inputContent;

@end
