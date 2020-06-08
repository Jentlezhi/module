//
//  CYTCarConfirmListCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTConfirmSendCarModel;

@interface CYTCarConfirmListCell : UITableViewCell

/** 确认发车模型 */
@property(strong, nonatomic) CYTConfirmSendCarModel *confirmSendCarModel;

+ (instancetype)celllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
