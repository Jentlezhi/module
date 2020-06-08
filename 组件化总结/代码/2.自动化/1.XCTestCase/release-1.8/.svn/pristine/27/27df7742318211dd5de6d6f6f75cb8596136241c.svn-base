//
//  UITableView+Extension.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UITableView (Extension)

- (void)scrollToRow:(NSUInteger)row section:(NSInteger)section animated:(BOOL)animated;

- (void)customRefreshGifHeaderWithRefreshingBlock:(void(^)(MJRefreshGifHeader *refreshGifHeader))refreshingBlock;

- (void)reloadDataAtIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation;

- (void)reloadDataAtSection:(NSInteger)section animation:(BOOL)animation;

@end
