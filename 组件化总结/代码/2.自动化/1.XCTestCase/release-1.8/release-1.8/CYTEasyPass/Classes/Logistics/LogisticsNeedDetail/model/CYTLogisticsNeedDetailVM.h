//
//  CYTLogisticsNeedDetailVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTLogisticsNeedDetailModel.h"
#import "CYTLogisticsNeedDetailOfferModel.h"
#import "CYTLogisticsNeedWriteCellModel.h"
#import "CYTLogisticsNeedDetailCarModel.h"

typedef NS_ENUM(NSInteger,LogisticsDetailSource) {
    ///默认
    LogisticsDetailSourceNormal = 0,
    ///叫个物流
    LogisticsDetailSourceCallTransport,
    ///发布进入
    LogisticsDetailSourcePublish,
    
};

@interface CYTLogisticsNeedDetailVM : CYTExtendViewModel

@property (nonatomic, assign) NSInteger neeId;
///物流需求状态,物流需求单状态（-1全部、1待下单，2已完成，3已过期,4已取消）
@property (nonatomic, assign) CYTLogisticsNeedStatus status;
///叫个物流
@property (nonatomic, assign) LogisticsDetailSource source;

@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, strong) CYTLogisticsNeedDetailModel *detailModel;
@property (nonatomic, strong) CYTLogisticsNeedWriteCellModel *sendModel;
@property (nonatomic, strong) CYTLogisticsNeedWriteCellModel *receiveModel;
@property (nonatomic, strong) CYTLogisticsNeedDetailCarModel *carModel;
@property (nonatomic, strong) NSMutableArray *listArray;

///取消物流需求
@property (nonatomic, strong) RACCommand *cancelCommand;
@property (nonatomic, strong) FFBasicNetworkResponseModel *cancelCommandResult;

@end
