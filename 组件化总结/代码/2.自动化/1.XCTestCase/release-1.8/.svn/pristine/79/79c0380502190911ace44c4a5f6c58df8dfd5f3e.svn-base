//
//  CYTCarSourceListFrequentlyBrandVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTBrandSelectModel.h"

@interface CYTCarSourceListFrequentlyBrandVM : CYTExtendViewModel
///常用品牌列表
@property (nonatomic, strong) NSMutableArray *brandList;
///刷新常用品牌
@property (nonatomic, strong) RACSubject *refreshSubject;
///在车源寻车发布、车源寻车筛选中选中了车系后保存模型
- (void)updateBrandListWithModel:(CYTBrandSelectModel *)model;

@end
