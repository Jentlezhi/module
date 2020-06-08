//
//  CYTDealerCommentItemVC.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTDealerCommentVM.h"

@interface CYTDealerCommentItemVC : CYTBasicViewController
@property (nonatomic, strong) CYTDealerCommentVM *viewModel;
//两个方法不要合并
- (void)loadData;
- (void)refreshData;

@end
