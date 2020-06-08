//
//  CYTCarSourcePublishRequestModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTCarSourcePublishRequestModel : FFExtendModel

///车源类型
@property (nonatomic, assign) NSInteger CarSourceType;
@property (nonatomic, assign) NSInteger BrandId;
@property (nonatomic, assign) NSInteger SerialId;
@property (nonatomic, assign) NSInteger CarId;

@property (nonatomic, assign) NSInteger ArrivalDate;
@property (nonatomic, assign) NSInteger ProvinceId;
@property (nonatomic, assign) NSInteger LocationGroupId;

///报价
@property (nonatomic, assign) float SalePrice;
@property (nonatomic, copy) NSString *PriceBasePoint;
@property (nonatomic, assign) NSInteger PriceMode;

///自定义车款
@property (nonatomic, copy) NSString *CustomCarName;
@property (nonatomic, copy) NSString *ExteriorColor;
@property (nonatomic, copy) NSString *InteriorColor;
@property (nonatomic, copy) NSString *CarConfigure;
@property (nonatomic, copy) NSString *CarProcedures;
@property (nonatomic, copy) NSString *SalableArea;
@property (nonatomic, copy) NSString *Remark;

///图片
@property (nonatomic, strong) NSMutableArray *Media;

///车源id  (编辑保存使用)
@property (nonatomic, assign) NSInteger CarSourceId;

//1.7新增
/** 货物状态 1：现货 2：期货 */
@property(assign, nonatomic) NSInteger goodsStatus;
/** 货物类型, 国产/合资车：1, 中规：3, 美规：201, 欧规：202, 中东：203, 加版：204, 墨版：205 */
@property(assign, nonatomic) NSInteger goodsType;

@end
