//
//  CYTCreateOrderSeekCarPar.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTCreateOrderSeekCarPar : NSObject

/** 成交总价 */
@property(copy, nonatomic) NSString *dealPrice;
/** 成交数量 */
@property(copy, nonatomic) NSString *dealCarNum;
/** 成交单价 */
@property(copy, nonatomic) NSString *dealUnitPrice;
/** 订金总额 */
@property(copy, nonatomic) NSString *depositAmount;
/** 备注 */
@property(copy, nonatomic) NSString *remark;
/** 发车地址Id */
@property(copy, nonatomic) NSString *sendAddressId;
/** 寻车id */
@property(copy, nonatomic) NSString *seekCarId;
/** 发车人信息id（联系人） */
@property(copy, nonatomic) NSString *senderInfoId;
/** 是否同意协议 */
@property(assign, nonatomic,getter=isCustomRefuseProtocal) BOOL customRefuseProtocal;

@end
