//
//  CYTDealerAuthInfoCellView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTDealerHomeAuthInfoModel.h"

@interface CYTDealerAuthInfoCellView : FFExtendView
///身份证
@property (nonatomic, strong) UIButton *idButton;
///营业执照
@property (nonatomic, strong) UIButton *businessButton;
///实体店
@property (nonatomic, strong) UIButton *entityButton;

@property (nonatomic, strong) CYTDealerHomeAuthInfoModel *model;

@end
