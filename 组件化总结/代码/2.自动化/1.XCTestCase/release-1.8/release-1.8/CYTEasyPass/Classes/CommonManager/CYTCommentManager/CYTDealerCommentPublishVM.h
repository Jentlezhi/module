//
//  CYTDealerCommentPublishVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTDealerCommentPublishModel.h"

typedef NS_ENUM(NSInteger,CommentViewType) {
    ///用户相关评论
    CommentViewTypeUser = 0,
    ///物流评论
    CommentViewTypeLogistics,
};

@interface CYTDealerCommentPublishVM : CYTExtendViewModel
@property (nonatomic, strong) CYTDealerCommentPublishModel *model;
@property (nonatomic, assign) CommentViewType type;

@end
