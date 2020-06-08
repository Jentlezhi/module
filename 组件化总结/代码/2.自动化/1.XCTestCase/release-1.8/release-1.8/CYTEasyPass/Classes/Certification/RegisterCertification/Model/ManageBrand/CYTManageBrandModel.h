//
//  CYTManageBrandModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTManageBrandModel : NSObject

/** 品牌拼写 */
@property(copy, nonatomic) NSString *spell;
/** 品牌id */
@property(copy, nonatomic) NSString *brandId;
/** 品牌名称 */
@property(copy, nonatomic) NSString *brandName;

@end
