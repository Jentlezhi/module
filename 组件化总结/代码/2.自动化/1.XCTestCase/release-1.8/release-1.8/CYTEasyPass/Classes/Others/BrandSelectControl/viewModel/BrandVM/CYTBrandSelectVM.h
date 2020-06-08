//
//  CYTBrandSelectVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTBrandSelectModel.h"
#import "CYTBrandSelectResultModel.h"

typedef NS_ENUM(NSInteger,CYTBrandSelectType) {
    ///选择到车系
    CYTBrandSelectTypeSeries,
    ///选择到车型
    CYTBrandSelectTypeCar,
};

@interface CYTBrandSelectVM : CYTExtendViewModel
///type
@property (nonatomic, assign) CYTBrandSelectType type;
///品牌数据
@property (nonatomic, strong) NSArray *brandCacheArray;
@property (nonatomic, strong) NSArray *groupNameArray;

///选择的主品牌
@property (nonatomic, strong) CYTBrandSelectModel *mainBrandModel;
///默认选择brand
@property (nonatomic, strong) CYTBrandSelectModel *selectedBrandModel;
///发出消息
@property (nonatomic, strong) RACSubject *getSelectedBrandModelFinishedSubject;
///处理selectedBrandModel
- (void)handleSelectedBrand;

///最后的品牌模型
@property (nonatomic, strong) CYTBrandSelectResultModel *brandResultModel;
///是否需要返回
@property (nonatomic, assign) BOOL needBack;

@end
