//
//  CYTLogListCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTLogListModel;

@interface CYTLogListCell : UITableViewCell

/** 交易模型 */
@property(strong, nonatomic) CYTLogListModel *logListModel;

+ (instancetype)logListCelllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
