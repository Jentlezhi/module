//
//  CYTRecCarInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTConfirmOrderInfoModel;

@interface CYTLogisticRecCarInfoCell : UITableViewCell<UITextViewDelegate>

/** 物流信息模型 */
@property(strong, nonatomic) CYTConfirmOrderInfoModel *confirmOrderInfoModel;

/** 收车人姓名 */
@property(copy, nonatomic) NSString *receiverName;
/** 收车人电话 */
@property(copy, nonatomic) NSString *receiverTel;
/** 详细地址 */
@property(copy, nonatomic) NSString *rDetailAddress;
/** 收车人身份证 */
@property(copy, nonatomic) NSString *receiverIdentityNo;


+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
