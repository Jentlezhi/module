//
//  CYTCarSourcePublishVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTCarSourcePublishItemModel.h"
#import "CYTCarSourcePublishRequestModel.h"
#import "CYTStockCarModel.h"
#import "CarSourceDetailModel.h"
#import "CYTCarSourceListModel.h"

@class CYTBrandSelectResultModel;

@interface CYTCarSourcePublishVM : CYTExtendViewModel
///cell数据数组
@property (nonatomic, strong) NSMutableArray <NSArray *>*listArray;
///必要
@property (nonatomic, strong) NSMutableArray <CYTCarSourcePublishItemModel *>*necessaryArray;
///非必要
@property (nonatomic, strong) NSMutableArray <CYTCarSourcePublishItemModel *> *inecessaryArray;


///是否选择了车源类型
@property (nonatomic, assign) BOOL selectCarSourceType;
///index
@property (nonatomic, strong) NSIndexPath *carSourceTypeIndexPath;
///是否选择了车款
@property (nonatomic, assign) BOOL selectCarBrand;
///是否选择了车源状态
@property (nonatomic, assign) BOOL selectCarSourceStatus;
///是否选择了颜色
@property (nonatomic, assign) BOOL selectColor;
///是否选择了车源地
@property (nonatomic, assign) BOOL selectCarSourceAddress;
///是否选择了到港日期
@property (nonatomic, assign) BOOL selectArriveData;
///内饰颜色数组
@property (nonatomic, strong) NSArray *inColorArray;
///外观颜色数据
@property (nonatomic, strong) NSArray *exColorArray;
///获取外+内颜色字符串
@property (nonatomic, copy) NSString *colorString;
///车原地
@property (nonatomic, copy) NSString *carSourceLocationString;
///到港日期
@property (nonatomic, copy) NSString *arrivalDateString;
///使用指导价
@property (nonatomic, copy) NSString *guidePrice;

///是否可提交
@property (nonatomic, assign) BOOL canSubmit;
///刷新table
@property (nonatomic, strong) RACSubject *reloadSubject;
///当前在进行编辑
@property (nonatomic, assign) BOOL editingState;
///已编辑
@property (nonatomic, assign) BOOL haveEdit;
///编辑数据模型
@property (nonatomic, strong) CYTCarSourceListModel *editModel;
///请求详情数据模型
@property (nonatomic, strong) CarSourceDetailModel *carDetailModel;
///请求详情
@property (nonatomic, strong) RACCommand *requestDetailCommand;
///网络错误
@property (nonatomic, strong) RACSubject *backSubject;
///编辑后保存提交
@property (nonatomic, strong) RACCommand *editSaveCommond;
@property (nonatomic, strong) FFBasicNetworkResponseModel *editSaveCommandResult;

///分享
@property (nonatomic, assign) NSInteger carSourceId;


///section title
- (NSString *)titleForHeaderWithSection:(NSInteger)section;

///清空数据方法  0-车源类型以外清空，1-车源，车型以外清空
- (void)clearWithType:(NSInteger)type;

///根据车源类型，修改显示cell，设置是否显示
- (void)modifyShowView;

///请求颜色
@property (nonatomic, strong) RACCommand *requestColorCommand;

///处理品牌车型数据
///保存品牌车型选择的数据模型用于回显
@property (nonatomic, strong) CYTBrandSelectResultModel *brandSelectModel;
- (void)handleCarBrandData:(CYTBrandSelectResultModel *)brandModel;
- (void)handleCarSourceData:(CYTCarSourceTypeModel *)model;
///处理报价
- (void)handlePriceWithMode:(NSInteger)mode andValue:(NSString *)value andResultString:(NSString *)resultString;

///处理指导价搜索数据
- (void)handleSearchModel:(CYTStockCarModel *)model;
/**
 *  获取必填项
 */
- (CYTCarSourcePublishItemModel *)necessaryItemModelWithTitle:(NSString *)title;
/**
 *  获取非必填项
 */
- (CYTCarSourcePublishItemModel *)unnecessaryItemModelWithTitle:(NSString *)title;
/**
 *  添加必填项
 */
- (void)addNecessaryItemWithModel:(CYTCarSourcePublishItemModel *)model beforeTitle:(NSString *)beforeTitle;
/**
 *  移除必填项
 */
- (void)removeNecessaryItemWithTitle:(NSString *)title;
/**
 *  是否包含该item
 */
- (BOOL)containNecessaryItemWithTitle:(NSString *)title;
@end
