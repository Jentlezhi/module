//
//  CYTFindCarListViewModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTFindCarListRequestModel.h"
#import "CYTSeekCarListModel.h"
#import "CYTBrandSelectResultModel.h"

@interface CYTFindCarListViewModel : CYTExtendViewModel
@property (nonatomic, strong) CYTFindCarListRequestModel *requestModel;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger isMore;

///筛选条件字符串处理
- (NSString *)filterString:(NSDictionary *)filterDic;

///保存品牌车型选择的数据模型用于回显
@property (nonatomic, strong) CYTBrandSelectResultModel *brandSelectModel;

@end
