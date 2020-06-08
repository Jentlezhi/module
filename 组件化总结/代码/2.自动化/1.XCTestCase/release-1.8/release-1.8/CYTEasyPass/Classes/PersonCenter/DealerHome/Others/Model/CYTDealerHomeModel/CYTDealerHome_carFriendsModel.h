//
//  CYTDealerHome_carFriendsModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTDealerHomeCarFriendsModel.h"

@interface CYTDealerHome_carFriendsModel : FFExtendModel
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, strong) NSArray *list;

@end
