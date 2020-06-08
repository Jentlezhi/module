//
//  CYTCarSourceListRequestModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCarSourceListRequestModel : NSObject
@property (nonatomic, assign) NSInteger lastId;
///车源类型Id,选择全部为-1
@property (nonatomic, assign) NSInteger carSourceTypeId;
///车系Id,选择全部为-1
@property (nonatomic, assign) NSInteger carSerialId;
///价格排序：0默认，1升序，2降序
@property (nonatomic, assign) NSInteger orderByPrice;
@property (nonatomic, copy) NSString *exteriorColor;
@property (nonatomic, copy) NSString *interiorColor;
@property (nonatomic, assign) NSInteger provinceId;
@property (nonatomic, assign) NSInteger locationGroupId;

@end
