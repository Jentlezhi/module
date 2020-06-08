//
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTAddressDataItemModel : FFExtendModel
@property (nonatomic, assign) NSInteger idCode;
@property (nonatomic, assign) NSInteger locationGroupID;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *citys;

@end
