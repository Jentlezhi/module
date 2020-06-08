//
//  CYTSeekCarCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTSeekCarListModel;

@interface CYTSeekCarCell : UITableViewCell
/** 数据模型 */
@property(strong, nonatomic) CYTSeekCarListModel *seekCarListModel;
/** 下架停售/重新发布点击回调 */
@property(copy, nonatomic) void(^soldOutOrRepublishClickBack)();
///分享
@property(copy, nonatomic) void(^shareBlock)(CYTSeekCarListModel *);
///刷新
@property(copy, nonatomic) void(^refreshBlock)(CYTSeekCarListModel *);
///编辑
@property(copy, nonatomic) void(^editBlock)(CYTSeekCarListModel *);

/** 按钮标题 */
@property(copy, nonatomic) NSString *btnTitle;
///状态
@property (nonatomic, assign) BOOL onSale;

+ (instancetype)seekCarCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
