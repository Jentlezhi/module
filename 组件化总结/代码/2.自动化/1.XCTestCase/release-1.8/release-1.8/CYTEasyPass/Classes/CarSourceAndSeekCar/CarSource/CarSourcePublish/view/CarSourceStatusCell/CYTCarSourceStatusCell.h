//
//  CYTCarSourceStatusCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

typedef NS_ENUM(NSUInteger, CYTCarSourceStatus) {
    CYTCarSourceStatusSpot = 0,//现货
    CYTCarSourceStatusFutures,//期货
};

@class CYTCarSourcePublishItemModel;

@interface CYTCarSourceStatusCell : CYTBasicTableViewCell

/** 模型 */
@property(strong, nonatomic) CYTCarSourcePublishItemModel *carSourcePublishItemModel;

/** 车源状态 */
@property(copy, nonatomic) void(^carSourceStatusBlock)(CYTCarSourceStatus carSourceStatus);

@end
