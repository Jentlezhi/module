//
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTMessageCategoryModel : FFExtendModel
///图标
@property (nonatomic, copy) NSString *icon;
///未读消息数
@property (nonatomic, assign) NSInteger num;

@property (nonatomic, copy) NSString *time;
///最新的消息标题
@property (nonatomic, copy) NSString *lastMessageTitle;
///消息类型(1:公告，2：活动通知，3：与我相关)
@property (nonatomic, assign) NSInteger type;
///分类名称
@property (nonatomic, copy) NSString *typeName;

@end
