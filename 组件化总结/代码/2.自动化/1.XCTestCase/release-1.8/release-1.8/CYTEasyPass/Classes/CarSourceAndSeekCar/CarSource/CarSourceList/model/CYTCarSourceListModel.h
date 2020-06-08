//
//  CYTCarSourceListModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTCarSourceInfo.h"
#import "CYTDealer.h"

@class CYTSeekCarListModel;

@interface CYTCarSourceListModel : FFExtendModel
@property (nonatomic, strong) CYTCarSourceInfo *carSourceInfo;
@property (nonatomic, strong) CYTDealer *dealer;
/** 控制显示过期标签（我联系的 ）*/
@property(assign, nonatomic) BOOL myContect;
@end
