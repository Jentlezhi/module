//
//  UITableView+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (void)scrollToRow:(NSUInteger)row section:(NSInteger)section animated:(BOOL)animated{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

- (void)customRefreshGifHeaderWithRefreshingBlock:(void(^)(MJRefreshGifHeader *refreshGifHeader))refreshingBlock{
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        !refreshingBlock?:refreshingBlock(gifHeader);
    }];
    [gifHeader setImages:@[[[self animationImages] firstObject]]forState:MJRefreshStateIdle];
    [gifHeader setImages:[self animationImages] forState:MJRefreshStateRefreshing];
    self.mj_header = gifHeader;
}

- (NSArray *)animationImages{
    NSArray *animationImages = [NSArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [tempArray addObject:image];
    }
    
    animationImages = [tempArray copy];
    return animationImages;
}

- (void)reloadDataAtIndexPath:(NSIndexPath *)indexPath animation:(BOOL)animation{
    UITableViewRowAnimation  tableViewRowAnimation = animation ? UITableViewRowAnimationFade:UITableViewRowAnimationNone;
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:tableViewRowAnimation];
}

- (void)reloadDataAtSection:(NSInteger)section animation:(BOOL)animation{
    UITableViewRowAnimation  tableViewRowAnimation = animation ? UITableViewRowAnimationFade:UITableViewRowAnimationNone;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:tableViewRowAnimation];
}
@end
