//
//  CYTSendCarInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTConfirmOrderInfoModel;

@interface CYTLogisticSendCarInfoCell : UITableViewCell<UITextViewDelegate>

/** 物流信息模型 */
@property(strong, nonatomic) CYTConfirmOrderInfoModel *confirmOrderInfoModel;

/** 发车人姓名 */
@property(copy, nonatomic) NSString *senderName;
/** 发车人电话 */
@property(copy, nonatomic) NSString *senderTel;
/** 详细地址 */
@property(copy, nonatomic) NSString *sDetailAddress;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
