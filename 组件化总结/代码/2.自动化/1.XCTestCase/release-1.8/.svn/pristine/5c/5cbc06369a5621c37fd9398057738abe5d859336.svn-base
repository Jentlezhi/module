//
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTCarSearchAssociateModel.h"

typedef NS_ENUM(NSInteger,SearchViewShowType) {
    ///历史
    SearchViewShowTypeHistory,
    ///联想
    SearchViewShowTypeAssociate,
};

@interface CYTCarSearchVM : CYTExtendViewModel
///显示模式（搜索历史还是搜索结果）
@property (nonatomic, assign) SearchViewShowType type;
///搜索来源
@property (nonatomic, assign) CarViewSource source;
///搜索联想数据
@property (nonatomic, strong) NSMutableArray *listArray;
///搜索历史数据
@property (nonatomic, strong) NSMutableArray *historyList;

///进行搜索联想
@property (nonatomic, copy) NSString *searchString;
@property (nonatomic, strong) NSString *nowString;
///搜索结果
@property (nonatomic, copy) void (^searchResultBlock) (FFBasicNetworkResponseModel *resultModel);

@property (nonatomic, strong) RACSubject *searchFinishedSubject;
///清空搜索历史
- (void)clearHistoryData;
///增加搜索历史
- (void)addSearchHistoryWithModel:(CYTCarSearchAssociateModel *)model;

@end
