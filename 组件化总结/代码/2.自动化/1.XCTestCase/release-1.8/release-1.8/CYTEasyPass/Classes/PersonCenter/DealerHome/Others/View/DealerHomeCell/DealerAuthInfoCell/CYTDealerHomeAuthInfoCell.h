//
//  CYTDealerHomeAuthInfoCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTDealerHomeAuthInfoModel.h"
#import "CYTDealerAuthInfoCellView.h"

@interface CYTDealerHomeAuthInfoCell : FFExtendTableViewCell
@property (nonatomic, strong) CYTDealerAuthInfoCellView *cellView;
@property (nonatomic, strong) CYTDealerHomeAuthInfoModel *model;

@end
