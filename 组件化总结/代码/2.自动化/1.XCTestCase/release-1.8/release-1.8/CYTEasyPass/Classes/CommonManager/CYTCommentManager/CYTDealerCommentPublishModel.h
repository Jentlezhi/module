//
//  CYTDealerCommentPublishModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTDealerCommentPublishModel : FFExtendModel
///评论等级（1=好评 2=中评 3=差评）
@property (nonatomic, copy) NSString *evalType;
///评论内容
@property (nonatomic, copy) NSString *content;
///被评论认用户Id
@property (nonatomic, copy) NSString *beEvalUserId;
///评价类型1=电话、2=订单
@property (nonatomic, copy) NSString *sourceType;
///评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈 7
@property (nonatomic, copy) NSString *sourceId;
///orderId订单评价使用
@property (nonatomic, copy) NSString *orderId;

@end
