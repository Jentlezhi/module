//
//  CYTDealerHeadModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

@interface CYTDealerHeadModel : CYTExtendViewModel
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
///头像
@property (nonatomic, copy) NSString *avatar;
///评论数量
@property (nonatomic, copy) NSString *evalCount;
///
/** 星级分数 */
@property(assign, nonatomic) CGFloat starScore;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *carBrandName;
///店铺类别简称（资|4S|综）
@property (nonatomic, copy) NSString *businessModel;
@property (nonatomic, copy) NSString *phone;

@end
