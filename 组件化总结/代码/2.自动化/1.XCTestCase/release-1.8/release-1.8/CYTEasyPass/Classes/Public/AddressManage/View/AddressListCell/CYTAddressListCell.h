//
//  CYTAddressListCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTAddressModel;

@interface CYTAddressListCell : UITableViewCell

/** 地址模型 */
@property(strong, nonatomic) CYTAddressModel *addressModel;

/** 设置为默认 */
@property(copy, nonatomic) void(^defaultSetBlock)();
/** 编辑 */
@property(copy, nonatomic) void(^editBlock)();
/** 删除 */
@property(copy, nonatomic) void(^deleteBlock)();

+ (instancetype)addressListCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath containToolBar:(BOOL)containToolBar;

@end
