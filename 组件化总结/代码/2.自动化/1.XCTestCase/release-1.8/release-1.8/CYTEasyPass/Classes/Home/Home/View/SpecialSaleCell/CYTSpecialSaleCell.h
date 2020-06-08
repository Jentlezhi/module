//
//  CYTSpecialSaleCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTHomeCarSourceInfoModel.h"

@interface CYTSpecialSaleCell : UITableViewCell

/** 数据模型 */
@property(strong, nonatomic) CYTHomeCarSourceInfoModel *carSourceInfoModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
