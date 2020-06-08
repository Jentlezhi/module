//
//  CYTManageTypeCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTManageTypeModel;

@interface CYTManageTypeCell : UITableViewCell

/** 公司类型模型 */
@property(strong, nonatomic) CYTManageTypeModel *manageTypeModel;

+ (instancetype)manageTypeCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
