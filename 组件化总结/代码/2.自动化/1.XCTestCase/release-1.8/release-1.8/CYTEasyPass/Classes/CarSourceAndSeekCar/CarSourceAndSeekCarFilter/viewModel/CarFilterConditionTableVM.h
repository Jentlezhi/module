//
//  CarFilterConditionTableVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTBrandSelectCarModel.h"
#import "CarFilterConditonRequestModel.h"
#import "CarFilterConditionColorModel.h"
#import "CarFilterConditionSubbrand_seriesModel.h"
#import "CarFilterConditionModel.h"
#import "CarFilterConditionArea_provinceModel.h"
#import "CarFilterConditionDealerTypeModel.h"
@class CarFilterConditionView;

typedef NS_ENUM(NSInteger,CarFilterConditionTableType) {
    ///车款
    CarFilterConditionTableCar,
    ///颜色
    CarFilterConditionTableColor,
    ///地区
    CarFilterConditionTableArea,
    ///经销商类型
    CarFilterConditionTableDealer,
};

@interface CarFilterConditionTableVM : CYTExtendViewModel

///筛选条件数据
///conditionView
@property (nonatomic, weak) CarFilterConditionView *conditionViewRef;
///table类型
@property (nonatomic, assign) CarFilterConditionTableType type;
///是否是单车系
@property (nonatomic, assign, getter=isSingleSeries) BOOL singleSeries;
///table数据
@property (nonatomic, strong) NSArray *leftListArray;
///rightTable数据
@property (nonatomic, strong) NSArray *rightListArray;
///是否是搜索-单车款
@property (nonatomic, assign, getter = isSingleCar) BOOL singleCar;
///如果数据无效则点击方法无效
@property (nonatomic, assign) BOOL invalid;
///获取车款列表高度
- (float)heightOfCarList;
///获取偏移量
- (NSIndexPath *)tableOffsetWithTableIndex:(NSInteger)index;
///保存偏移量
- (void)saveTableOffsetWithTableIndex:(NSInteger)index andOffset:(NSIndexPath *)indexPath;


///table内部使用选择的车系
@property (nonatomic, strong) CarFilterConditionSubbrand_seriesModel *inSelectSeriesModel;
///选择的车系
@property (nonatomic, strong) CarFilterConditionSubbrand_seriesModel *selectSeriesModel;
///选中的车款
@property (nonatomic, strong) CYTBrandSelectCarModel *selectCarModel;
///选中的颜色id
@property (nonatomic, strong) CarFilterConditionColorModel *selectColorModel;
///选中的地区id
@property (nonatomic, strong) CarFilterConditionArea_provinceModel *selectProvinceModel;
///选中的经销商类型id
@property (nonatomic, strong) CarFilterConditionDealerTypeModel *selectDealerModel;
///判断是否选中
- (BOOL)selectedModelWithModel:(id)model;
///获取当前index对应的model
- (id)getModelWithIndexPath:(NSIndexPath *)indexPath andTableIndex:(NSInteger)index;



- (NSInteger)numberWithTableIndex:(NSInteger)index;
- (NSInteger)numberWithSection:(NSInteger)section andTableIndex:(NSInteger)index;
- (NSString *)titleWithIndexPath:(NSIndexPath *)indexPath andTableIndex:(NSInteger)index;
- (float)sectionHeightWithTableIndex:(NSInteger)index andSection:(NSInteger)section;
- (NSString *)sectionTitleWithTableIndex:(NSInteger)index andSection:(NSInteger)section;



///点击车系
- (void)selectSeries:(CarFilterConditionSubbrand_seriesModel *)seriesModel;
///获取右侧table选中时carModel
- (CYTBrandSelectCarModel *)carModelWithIndexPath:(NSIndexPath *)indexPath;
///获取车系
- (CarFilterConditionSubbrand_seriesModel *)seriesModelWithIndex:(NSIndexPath *)indexPath;
///获取单车系的车系
- (CarFilterConditionSubbrand_seriesModel *)singleSeriesModel;
///请求车款数据
@property (nonatomic, strong) RACCommand *conditionCarCommand;



///选中的筛选条件模型
@property (nonatomic, strong) CarFilterConditonRequestModel *requestModel;
///满足条件的车，请求模型
@property (nonatomic, strong) CarFilterConditionModel *listRequestModel;
@property (nonatomic, strong) RACSubject *reloadRightTableSubject;
///保存筛选条件，更新segmentView的item
- (void)saveFilterConditionWithTableIndex:(NSInteger)index andIndexPath:(NSIndexPath *)indexPath;




@end
