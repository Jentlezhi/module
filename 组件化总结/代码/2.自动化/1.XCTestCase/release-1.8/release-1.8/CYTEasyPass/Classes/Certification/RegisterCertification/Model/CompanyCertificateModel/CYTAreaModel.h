//
//  CYTAreaModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTAreaModel : NSObject

/** 省份ID */
@property(assign, nonatomic) NSInteger ProvinceID;
/** 省份名称 */
@property(copy, nonatomic) NSString *ProvinceName;
/** 城市ID */
@property(copy, nonatomic) NSString *CityID;
/** 城市名称 */
@property(copy, nonatomic) NSString *CityName;


@end
