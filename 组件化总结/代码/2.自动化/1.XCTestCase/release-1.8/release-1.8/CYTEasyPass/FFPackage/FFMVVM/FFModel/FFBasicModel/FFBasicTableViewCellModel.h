//
//  FFBasicTableViewCellModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface FFBasicTableViewCellModel : FFExtendModel
@property (nonatomic, copy) NSString *ffIdentifier;
@property (nonatomic, strong) NSIndexPath *ffIndexPath;

@end
