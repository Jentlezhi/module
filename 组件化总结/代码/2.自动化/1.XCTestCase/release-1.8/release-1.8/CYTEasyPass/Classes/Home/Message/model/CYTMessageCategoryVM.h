//
//  CYTMessageCategoryVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTMessageCategoryModel.h"

@interface CYTMessageCategoryVM : CYTExtendViewModel
///cell使用数据
@property (nonatomic, strong) NSMutableArray *listArray;
///清空分类消息数量
- (void)clearAllMessageWithType:(NSInteger)type;

@end
