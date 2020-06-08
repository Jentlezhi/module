//
//  CYTLogisticsOrderDetailController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 self.noDataView.content = @"抱歉，该订单未使用平台物流\n- 暂无实时状态 -";
 self.noDataView.imageName = @"bg_manage_dl";
 [self showNoDataView];
 */

#import "CYTLogisticsOrderDetailController.h"

@class CYTLogisticDemandPriceModel;

@interface CYTLogisticsOrderDetailController : CYTBasicViewController

/** 订单id */
@property(copy, nonatomic) NSString *orderId;
/** 费用明细回调 */
@property(copy, nonatomic) void(^expensesDetailBlock)(CYTLogisticDemandPriceModel *);
/** 是否提交物流订单push */
@property(assign, nonatomic,getter=isLogisticsOrderPushed) BOOL logisticsOrderPushed;
///弹出评论视图
//- (void)showCommentViewNow;
@property (nonatomic, assign) BOOL showCommentView;

@end
