//
//  CYTBrandSelectSeriesModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 车系
 */

#import "FFExtendModel.h"

@interface CYTBrandSelectSeriesModel : FFExtendModel<NSCopying>
@property (nonatomic, assign) NSInteger serialId;
@property (nonatomic, copy) NSString *serialName;
///车款类型Id, 国产/合资车：1, 中规：3, 美规：201, 欧规：202, 中东：203, 加版：204, 墨版：205
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeName;
///是否是平行进口车系
@property (nonatomic, assign) BOOL isParallelImportCar;

@end
