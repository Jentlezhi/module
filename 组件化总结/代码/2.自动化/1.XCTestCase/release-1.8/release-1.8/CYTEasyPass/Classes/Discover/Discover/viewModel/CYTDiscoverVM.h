//
//  CYTDiscoverVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTDiscoverModel_cell.h"

@interface CYTDiscoverVM : CYTExtendViewModel
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger isMore;

@end
