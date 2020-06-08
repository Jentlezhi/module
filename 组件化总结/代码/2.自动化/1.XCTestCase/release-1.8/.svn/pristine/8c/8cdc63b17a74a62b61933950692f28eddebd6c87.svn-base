//
//  CYTCardView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 
 */

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CYTCardViewTypeUnauthorized = 0,//未认证
    CYTCardViewTypeCarSourceEvaluate,//车源评价
    CYTCardViewTypeSeekCarEvaluate,//寻车评价
    CYTCardViewTypeLogisticsServe,//物流首页客服
    CYTCardViewTypeLogisticComment,//物流订单评价
} CYTCardViewType;

@interface CYTCardView : UIView

/** 操作按钮点击回调 */
@property(copy, nonatomic) void(^operationBtnClick)(BOOL neverShowAgain);//neverShowAgain:YES:不再显示，NO:继续显示
/** 选中按钮点击回调 */
@property(copy, nonatomic) void(^selectedBtnClick)();
/** 移除按钮点击回调 */
@property(copy, nonatomic) void(^removeBtnClick)(BOOL neverShowAgain);

+ (instancetype)showCardViewWithType:(CYTCardViewType)cardViewType;
///是否不显示“移除”
@property (nonatomic, assign) BOOL hideRemoveView;


@end
