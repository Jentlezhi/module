//
//  CYTCommitPriceInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTCreateOrderTipsModel.h"

@interface CYTCommitPriceInfoCell : UITableViewCell

/** 成交总价 */
@property(copy, nonatomic) NSString *dealPrice;
/** 成交数量 */
@property(copy, nonatomic) NSString *dealNumber;
/** 成交单价 */
@property(copy, nonatomic) NSString *dealUnitPrice;
/** 订金金额 */
@property(copy, nonatomic) NSString *depositAmount;

/** 备注信息 */
@property(copy, nonatomic) NSString *remark;


///CYTOrderCommitType 车源或者寻车--0：买家，1：卖家
@property (nonatomic, assign) NSInteger commitType;
///点击订金提示
@property (nonatomic, copy) ffDefaultBlock clickDepositAlertBlock;
/** 备注点击回调 */
@property(copy, nonatomic) void(^remakeClick)(NSString *remake);
///tips
@property(strong, nonatomic) CYTCreateOrderTipsModel *tipsModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
