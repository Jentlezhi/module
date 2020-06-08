//
//  CYTLogisticsNeedWritePreAddress.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTLogisticsNeedWritePreAddress : FFExtendModel
@property (nonatomic, assign) NSInteger senderCityId;
@property (nonatomic, assign) NSInteger senderProvinceId;
@property (nonatomic, assign) NSInteger senderCountyId;
@property (nonatomic, strong) NSString *senderCityName;
@property (nonatomic, strong) NSString *senderAddress;
@property (nonatomic, strong) NSString *senderCountyName;
@property (nonatomic, strong) NSString *senderProvinceName;

@property (nonatomic, assign) NSInteger receiverCityId;
@property (nonatomic, assign) NSInteger receiverProvinceId;
@property (nonatomic, assign) NSInteger receiverCountyId;
@property (nonatomic, strong) NSString *receiverAddress;
@property (nonatomic, strong) NSString *receiverProvinceName;
@property (nonatomic, strong) NSString *receiverCountyName;
@property (nonatomic, strong) NSString *receiverCityName;

@end
