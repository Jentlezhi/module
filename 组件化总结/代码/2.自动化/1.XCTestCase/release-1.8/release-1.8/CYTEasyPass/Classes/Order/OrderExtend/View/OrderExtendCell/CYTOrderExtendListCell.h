//
//  CYTOrderExtendListCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTOrderExtendItemModel;

@interface CYTOrderExtendListCell : UITableViewCell


/** 是否被选中 */
@property(assign, nonatomic) BOOL cellSelected;
/** 取消原因模型 */
@property(strong, nonatomic) CYTOrderExtendItemModel *orderExtendItemModel;

+ (instancetype)celllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
