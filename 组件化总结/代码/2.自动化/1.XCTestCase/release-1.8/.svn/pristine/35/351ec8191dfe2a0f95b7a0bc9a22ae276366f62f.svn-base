//
//  CYTMessageListVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTMessageCategoryModel.h"
#import "CYTMessageListModel.h"

@interface CYTMessageListVM : CYTExtendViewModel
///选择的消息分类
@property (nonatomic, strong) CYTMessageCategoryModel *categoryModel;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger lastId;
@property (nonatomic, assign) NSInteger isMore;

///发送消息阅读状态
@property (nonatomic, strong) RACCommand *sendStateCommand;
///选择的消息
@property (nonatomic, strong) CYTMessageListModel *messageModel;
///一条消息还是全部设置状态
@property (nonatomic, assign) BOOL isAll;
///获取最新一条消息的id
- (NSInteger)getNewestMessageId;

@end
