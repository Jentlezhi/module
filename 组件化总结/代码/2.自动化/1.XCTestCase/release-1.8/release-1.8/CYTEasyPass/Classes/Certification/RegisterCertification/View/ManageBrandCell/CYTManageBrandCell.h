//
//  CYTManageBrandCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTManageBrandModel;

@interface CYTManageBrandCell : UITableViewCell

/** 公司类型模型 */
@property(strong, nonatomic) CYTManageBrandModel *manageBrandModel;

/** 是否被选中 */
@property(assign, nonatomic, getter=isCellSelected) BOOL cellSelected;

+ (instancetype)manageBrandCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
