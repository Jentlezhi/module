//
//  CYTCreateOrderPar.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCreateOrderCarSourcePar : NSObject

/** 成交总价格 */
@property(copy, nonatomic) NSString *dealPrice;
/** 成交数量 */
@property(copy, nonatomic) NSString *dealCarNum;
/** 成交单价 */
@property(copy, nonatomic) NSString *dealUnitPrice;
/** 订金金额 */
@property(copy, nonatomic) NSString *depositAmount;
/** 备注 */
@property(copy, nonatomic) NSString *remark;
/** 收车地址Id */
@property(copy, nonatomic) NSString *receiveAddressId;
/** 车源id */
@property(copy, nonatomic) NSString *carSourceId;
/** 收车人信息id（联系人） */
@property(copy, nonatomic) NSString *receiverInfoId;
/** 是否同意协议 */
@property(assign, nonatomic,getter=isCustomRefuseProtocal) BOOL customRefuseProtocal;


@end
