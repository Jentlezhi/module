//
//  CYTBrandGroupModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTBrandGroupModel : FFExtendModel
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray *masterBrands;

@end
