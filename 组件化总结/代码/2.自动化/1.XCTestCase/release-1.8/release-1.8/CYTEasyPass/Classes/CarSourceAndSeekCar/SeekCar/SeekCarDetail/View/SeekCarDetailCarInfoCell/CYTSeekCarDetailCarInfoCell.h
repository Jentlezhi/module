//
//  CYTSeekCarDetailCarInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTOptionTagModel;

@interface CYTSeekCarDetailCarInfoCell : UITableViewCell

/** 模型 */
@property(strong, nonatomic) CYTOptionTagModel *optionTagModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
