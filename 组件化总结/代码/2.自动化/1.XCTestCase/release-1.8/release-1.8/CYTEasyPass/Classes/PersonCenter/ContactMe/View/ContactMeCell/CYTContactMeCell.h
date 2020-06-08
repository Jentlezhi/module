//
//  CYTContactMeCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicTableViewCell.h"

@class CYTGetContactedMeListModel;

@interface CYTContactMeCell : CYTBasicTableViewCell

/** 数据模型 */
@property(strong, nonatomic) CYTGetContactedMeListModel *getContactedMeListModel;

@end
