//
//  CYTCarSourceListViewModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTCarSourceListRequestModel.h"
#import "CYTCarSourceListModel.h"
#import "CYTBrandSelectResultModel.h"

typedef NS_ENUM(NSInteger,ListType) {
    ListTypeCarSource,
    ListTypeConnectHistory
};

@interface CYTCarSourceListViewModel : CYTExtendViewModel

@property (nonatomic, assign) ListType type;
@property (nonatomic, copy) NSString *requestURL;
@property (nonatomic, strong) CYTCarSourceListRequestModel *requestModel;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger isMore;

///筛选条件字符串处理
- (NSString *)filterString:(NSDictionary *)filterDic;

///保存品牌车型选择的数据模型用于回显
@property (nonatomic, strong) CYTBrandSelectResultModel *brandSelectModel;

@end
