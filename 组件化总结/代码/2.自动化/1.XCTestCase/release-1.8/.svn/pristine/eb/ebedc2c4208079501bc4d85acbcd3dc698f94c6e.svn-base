//
//  CYTCarSourceCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTCarSourceListModel;

@interface CYTCarSourceCell : UITableViewCell
/** 数据模型 */
@property(strong, nonatomic) CYTCarSourceListModel *carSourceListModel;
/** 下架停售/重新发布点击回调 */
@property(copy, nonatomic) void(^soldOutOrRepublishClickBack)();
///分享
@property(copy, nonatomic) void(^shareBlock)(CYTCarSourceListModel *);
///刷新
@property(copy, nonatomic) void(^refreshBlock)(CYTCarSourceListModel *);
///编辑
@property(copy, nonatomic) void(^editBlock)(CYTCarSourceListModel *);

/** 按钮标题 */
@property(copy, nonatomic) NSString *btnTitle;
///状态
@property (nonatomic, assign) BOOL onSale;

+ (instancetype)carSourceCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
