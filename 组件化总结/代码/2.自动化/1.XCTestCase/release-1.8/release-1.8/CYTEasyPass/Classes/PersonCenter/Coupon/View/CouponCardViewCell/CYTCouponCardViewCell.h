//
//  CYTCouponCardViewCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTCouponListItemModel;

@interface CYTCouponCardViewCell : UITableViewCell

/** 卡券模型 */
@property(strong, nonatomic) CYTCouponListItemModel *couponListItemModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
