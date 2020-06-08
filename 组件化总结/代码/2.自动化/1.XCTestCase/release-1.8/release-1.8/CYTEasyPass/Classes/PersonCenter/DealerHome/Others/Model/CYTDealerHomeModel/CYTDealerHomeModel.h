//
//  CYTDealerHomeModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTDealerHeadModel.h"
#import "CYTDealerHomeAuthInfoModel.h"
#import "CYTDealerHome_commentModel.h"
#import "CYTDealerHome_carFriendsModel.h"
#import "CYTDealerHome_onSaleCarModel.h"

@interface CYTDealerHomeModel : FFExtendModel
@property (nonatomic, strong) CYTDealerHeadModel *basic;
@property (nonatomic, strong) CYTDealerHomeAuthInfoModel *auth;
@property (nonatomic, strong) CYTDealerHome_commentModel *serviceEval;
@property (nonatomic, strong) CYTDealerHome_carFriendsModel *moment;
@property (nonatomic, strong) CYTDealerHome_onSaleCarModel *inSaleCar;

@end
