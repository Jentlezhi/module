//
//  CYTBrandSelectCarModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTBrandSelectCarModel : FFExtendModel<NSCopying>
@property (nonatomic, assign) NSInteger carId;
@property (nonatomic, copy) NSString *carName;
@property (nonatomic, copy) NSString *carReferPrice;
///车款类型Id, 国产/合资车：1, 中规：3, 美规：201, 欧规：202, 中东：203, 加版：204, 墨版：205
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeName;
///是否是平行进口车系
@property (nonatomic, assign) BOOL isParallelImportCar;

@end
