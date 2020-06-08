//
//  CYTOrderSendCarInfoModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTOrderSendCarInfoModel : FFExtendModel
///车架号
@property (nonatomic, copy) NSString *vin;
///随车手续
@property (nonatomic, copy) NSString *carDocuments;
///随车附件
@property (nonatomic, copy) NSString *carGoods;
///司机姓名
@property (nonatomic, copy) NSString *expressDriverName;
///联系电话
@property (nonatomic, copy) NSString *expressDriverMobile;
///承运公司
@property (nonatomic, copy) NSString *expressCompanyName;
///备注
@property (nonatomic, copy) NSString *remark;

@end
