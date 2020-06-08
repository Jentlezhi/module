//
//  CYTOrderDetailViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewController.h"
#import "CYTCarOrderEnum.h"


@interface CYTOrderDetailViewController : CYTBasicTableViewController

/** 订单id */
@property(copy, nonatomic) NSString *orderId;
///订单状态
@property (nonatomic, assign) CarOrderState orderStatus;
///订单类型
@property (nonatomic, assign) CarOrderType orderType;
///弹出评论视图
//- (void)showCommentViewNow;
@property (nonatomic, assign) BOOL showCommentView;
/** 车源提交push */
@property(assign, nonatomic,getter=isCarSourceCommitPushed) BOOL carSourceCommitPushed;
/** 寻车提交push */
@property(assign, nonatomic,getter=isSeekCarCommitPushed) BOOL seekCarCommitPushed;

@end
