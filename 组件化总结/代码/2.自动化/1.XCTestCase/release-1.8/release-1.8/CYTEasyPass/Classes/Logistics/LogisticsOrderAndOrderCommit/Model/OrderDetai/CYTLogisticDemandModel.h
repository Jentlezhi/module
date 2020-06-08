//
//  CYTLogisticDemandModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTLogisticDemandModel : NSObject
/** 品牌名称 */
@property(copy, nonatomic) NSString *carBrandName;
/** 车款年份 */
@property(copy, nonatomic) NSString *carYearType;
/** 车型名称 */
@property(copy, nonatomic) NSString *carSerialName;
/** 车款名称 */
@property(copy, nonatomic) NSString *carName;
/** 车辆总数 */
@property(copy, nonatomic) NSString *carAmount;
/** 车辆总价 */
@property(copy, nonatomic) NSString *carPrice;
/** 是否需要上门提车 0-不需要 1-需要 */
@property(copy, nonatomic) NSString *takeCarByDropIn;
/** 是否需要送车上门 0-不需要 1-需要 */
@property(copy, nonatomic) NSString *sendCarByDropIn;
/** 发车地址 */
@property(copy, nonatomic) NSString *startAddress;
/** 收车地址 */
@property(copy, nonatomic) NSString *destinationAddress;
/** 发车省份名称 */
@property(copy, nonatomic) NSString *startProvinceName;
/** 发车城市 */
@property(copy, nonatomic) NSString *startCityName;
/** 发车区县名称 */
@property(copy, nonatomic) NSString *startCountyName;
/** 收车省份名称 */
@property(copy, nonatomic) NSString *destinationProvinceName;
/** 收车城市名称 */
@property(copy, nonatomic) NSString *destinationCityName;
/** 收车区县名称 */
@property(copy, nonatomic) NSString *destinationCountyName;
/** 发车人姓名 */
@property(copy, nonatomic) NSString *senderName;
/** 发车人电话 */
@property(copy, nonatomic) NSString *senderPhone;
/** 收车人姓名 */
@property(copy, nonatomic) NSString *receiverName;
/** 收车人电话 */
@property(copy, nonatomic) NSString *receiverPhone;
/** 收车人身份证号 */
@property(copy, nonatomic) NSString *receiverCerNumber;
/** 提车司机手机号 */
@property(copy, nonatomic) NSString *driverPhoneNum;

@end
