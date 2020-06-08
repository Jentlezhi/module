//
//  CYTVouchersCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTSelectImageModel;

@interface CYTVouchersCell : UITableViewCell

/** 已选中的图片 */
@property(strong, nonatomic,readonly) NSMutableArray<CYTSelectImageModel *> *selectedImageModels;
/** 重新布局回调 */
@property(copy, nonatomic) void(^reSetcontentInset)(CGFloat bottomInset);

+ (instancetype)vouchersCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
