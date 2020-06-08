//
//  CYTBrandSelectResultModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTBrandSelectCarModel.h"
#import "CYTBrandSelectSeriesModel.h"

@interface CYTBrandSelectResultModel : FFExtendModel<NSCopying>
///品牌id（回显使用而已）
@property (nonatomic, assign) NSInteger inBrandId;
///子品牌id(外部使用)
@property (nonatomic, assign) NSInteger subBrandId;
@property (nonatomic, copy) NSString *subBrandName;
@property (nonatomic, strong) CYTBrandSelectSeriesModel *seriesModel;
///如果=-1则为自定义车款
@property (nonatomic, strong) CYTBrandSelectCarModel *carModel;

@end
