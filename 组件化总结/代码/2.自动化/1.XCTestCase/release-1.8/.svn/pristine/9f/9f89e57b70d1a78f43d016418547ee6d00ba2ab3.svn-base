//
//  CYTLogisticInfoView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTConfirmOrderInfoModel;

@class CYTLogisticDemandModel;

@interface CYTLogisticInfoView : UIView

/** 物流信息模型 */
@property(strong, nonatomic) CYTConfirmOrderInfoModel *confirmOrderInfoModel;

/** 车辆详情模型 */
@property(strong, nonatomic) CYTLogisticDemandModel *logisticDemandModel;

/** 是否显示提车司机 */
@property(assign, nonatomic,getter = isShowDriverPhone) BOOL showDriverPhone;

- (instancetype)initWithShowDriverPhone:(BOOL)showDriverPhone;

@end
