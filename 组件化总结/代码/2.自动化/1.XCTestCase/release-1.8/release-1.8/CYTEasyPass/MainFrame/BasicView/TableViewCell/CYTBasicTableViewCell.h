//
//  CYTBasicTableViewCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTBasicTableViewCell : UITableViewCell

- (void)initSubComponents;
- (void)makeSubConstrains;
+ (instancetype)celllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
