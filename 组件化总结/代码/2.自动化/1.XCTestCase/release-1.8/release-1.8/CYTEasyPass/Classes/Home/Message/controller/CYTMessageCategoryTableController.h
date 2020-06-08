//
//  CYTMessageCategoryTableController.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewController.h"
#import "CYTMessageCategoryVM.h"

@interface CYTMessageCategoryTableController : FFExtendTableViewController
@property (nonatomic, strong) CYTMessageCategoryVM *viewModel;
@property (nonatomic, copy)ffDefaultBlock refreshBlock;

@end
