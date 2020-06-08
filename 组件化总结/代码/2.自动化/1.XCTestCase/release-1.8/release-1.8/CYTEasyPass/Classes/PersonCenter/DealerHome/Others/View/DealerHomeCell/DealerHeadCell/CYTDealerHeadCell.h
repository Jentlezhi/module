//
//  CYTDealerHeadCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTDealerHeadCellView.h"

@interface CYTDealerHeadCell : FFExtendTableViewCell
@property (nonatomic, strong) CYTDealerHeadCellView *headView;
@property (nonatomic, strong) CYTDealerHeadModel *model;

@end
