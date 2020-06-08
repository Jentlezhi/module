//
//  CYTCompleteUserInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTCompleteInfoItemModel;

@interface CYTCompleteUserInfoCell : UITableViewCell

/** 模型 */
@property(strong, nonatomic) CYTCompleteInfoItemModel *completeInfoItemModel;

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
