//
//  CYTCarSourcePublishItemModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTCarSourceTypeModel.h"
#import "CYTCarBrandModel.h"
#import "CYTAddressDataWNCManager.h"
#import "CYTArrivalDateModel.h"

@interface CYTCarSourcePublishItemModel : FFExtendModel

///数据index
@property (nonatomic, assign) NSInteger index;
///是否已操作
@property (nonatomic, assign) BOOL select;
///左侧标题
@property (nonatomic, copy) NSString *title;
///选中-显示content
@property (nonatomic, copy) NSString *content;
///不选中-显示placeholder
@property (nonatomic, copy) NSString *placeholder;
///辅助字符
@property (nonatomic, copy) NSString *assistanceString;
/** 隐藏箭头 */
@property(assign, nonatomic) BOOL hideArrow;
/** 车源状态 0:初始化 1：现货 2：期货 */
@property(assign, nonatomic) NSInteger carSourceStatus;


///车源类型
@property (nonatomic, strong) CYTCarSourceTypeModel *carSourceTypeModel;
///品牌车型model
@property (nonatomic, strong) CYTCarBrandModel *carModel;
///当前选择的内饰颜色
@property (nonatomic, copy) NSString *inColorSel;
///当前选择外观颜色
@property (nonatomic, copy) NSString *exColorSel;
///车源地
@property (nonatomic, strong) CYTAddressDataWNCManager *carSourceLocationModel;
///到港时间
@property (nonatomic, strong) CYTArrivalDateItemModel *arrivalModel;
///图片数据
@property (nonatomic, strong) NSMutableArray *imageArray;
///处理好的图片数组
@property (nonatomic, strong) NSMutableArray *fileIdImageArray;

///报价
@property (nonatomic, assign) NSInteger priceMode;
@property (nonatomic, copy) NSString *priceValue;



///价格排序规则0-默认   1-升序   2-降序
@property (nonatomic, assign) NSInteger priceSortType;


@end
