//
//  CYTDealerHisHomeVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTDealerHomeAuthInfoModel.h"
#import "CYTDealerHomeCarFriendsModel.h"
#import "CYTDealerHeadModel.h"
#import "CYTDealerCommentListModel.h"
#import "CYTDealerHomeModel.h"

@interface CYTDealerHisHomeVM : CYTExtendViewModel
///userid
@property (nonatomic, copy) NSString *userId;
///showComment 是否自动显示评价
@property (nonatomic, assign) NSInteger commentShow;
///commentSourceid 1：车源，2：寻车
@property (nonatomic, assign) NSInteger commentType;

///homemodel
@property (nonatomic, strong) CYTDealerHomeModel *homeModel;

///服务评论数据
@property (nonatomic, strong) NSArray *commentArray;
///车商圈数据
@property (nonatomic, strong) NSArray *carFriendsArray;
///在售车源数据
@property (nonatomic, strong) NSArray *onSaleCarArray;

///sectionNumber 5或0
@property (nonatomic, assign) NSInteger sectionNumber;
///获取row number
- (NSInteger)rowNumberWithSection:(NSInteger)section;
///获取section title
- (NSString *)titleForSection:(NSInteger)section;

@end
