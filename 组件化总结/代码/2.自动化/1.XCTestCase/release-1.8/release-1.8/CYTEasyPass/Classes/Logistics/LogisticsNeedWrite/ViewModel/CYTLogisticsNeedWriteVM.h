//
//  CYTLogisticsNeedWriteVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTLogisticsNeedWriteCellModel.h"
#import "CYTAddressModel.h"
#import "CYTAddressDataWNCManager.h"
#import "CYTBrandSelectResultModel.h"

@interface CYTLogisticsNeedWriteVM : CYTExtendViewModel

///需要从网络获取物流信息
@property (nonatomic, assign) BOOL needGetLogisticInfo;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, strong) RACCommand *requestLogisticInfo;
@property (nonatomic, strong) FFBasicNetworkResponseModel *logisticInfoResult;

@property (nonatomic, strong) NSMutableArray *cellModelArray;
@property (nonatomic, assign) BOOL agreeProtocal;
///数据是否可提交
@property (nonatomic, assign) BOOL valid;

/** 已选择地址 */
@property (nonatomic, assign) NSInteger addressIndex;
//回显使用
@property (nonatomic, strong) CYTAddressDataWNCManager *sendManager;
@property (nonatomic, strong) CYTAddressDataWNCManager *receiveManager;

///保存品牌车型选择的数据模型用于回显
@property (nonatomic, strong) CYTBrandSelectResultModel *brandSelectModel;
///记录车辆数量单价，并计算总价
- (void)saveAndCalculatePriceWithText:(NSString *)text andIndexPath:(NSIndexPath *)indexPath;
///选择车款并处理指导价
- (void)saveCarInfoAndGuidePriceWithModel:(CYTBrandSelectResultModel *)brandModel;

@end
