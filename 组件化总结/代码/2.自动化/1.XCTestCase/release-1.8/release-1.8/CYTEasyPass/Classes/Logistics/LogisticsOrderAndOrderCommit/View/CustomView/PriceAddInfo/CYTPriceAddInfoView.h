//
//  CYTPriceAddInfoView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTConfirmOrderInfoModel;
@class CYTLogisticDemandPriceModel;

@interface CYTPriceAddInfoView : UIView

/** 物流信息模型 */
@property(strong, nonatomic) CYTConfirmOrderInfoModel *confirmOrderInfoModel;
/** 物流需求报价 */
@property(strong, nonatomic) CYTLogisticDemandPriceModel *logisticDemandPriceModel;

@end

