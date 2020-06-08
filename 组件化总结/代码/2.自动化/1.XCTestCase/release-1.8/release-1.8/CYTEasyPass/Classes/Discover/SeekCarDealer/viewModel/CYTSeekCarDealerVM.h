//
//  CYTSeekCarDealerVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTDealer.h"

typedef NS_ENUM(NSInteger,SeekCarDealerType) {
    ///搜索历史
    SeekCarDealerTypeHistory,
    ///搜索结果
    SeekCarDealerTypeResult,
};

@interface CYTSeekCarDealerVM : CYTExtendViewModel
@property (nonatomic, strong) NSMutableArray *listArray;
///搜索历史数据
@property (nonatomic, strong) NSMutableArray *historyList;
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, assign) NSInteger lastId;
@property (nonatomic, assign) SeekCarDealerType type;
///开始搜索
@property (nonatomic, copy) NSString *searchString;
///清空搜索历史
- (void)clearHistoryData;

@end
