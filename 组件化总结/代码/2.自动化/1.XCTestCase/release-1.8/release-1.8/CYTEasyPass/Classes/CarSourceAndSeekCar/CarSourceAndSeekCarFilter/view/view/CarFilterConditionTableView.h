//
//  CarFilterConditionTableView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CarFilterConditionTableVM.h"
#import "CarFilterConditionTabelCell_text.h"

@interface CarFilterConditionTableView : FFExtendView<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) CarFilterConditionTableVM *viewModel;
@property (nonatomic, strong) FFMainView *leftTable;
@property (nonatomic, strong) FFMainView *rightTable;

- (void)loadData;

@end
