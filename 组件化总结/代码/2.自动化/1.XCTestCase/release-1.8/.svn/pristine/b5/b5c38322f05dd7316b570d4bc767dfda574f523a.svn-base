//
//  CYTExchangeCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

@class CYTGoodsModel;

@interface CYTExchangeCell : CYTBasicTableViewCell

/** 任务模型 */
@property(strong, nonatomic) NSArray *goodsModels;
/** 兑换的回调 */
@property(copy, nonatomic) void(^exchangeCallback)(NSString *userBitautoCoin);
/** 点击的回调 */
@property(copy, nonatomic) void(^clickCallback)(CYTGoodsModel *goodsModel);

@end
