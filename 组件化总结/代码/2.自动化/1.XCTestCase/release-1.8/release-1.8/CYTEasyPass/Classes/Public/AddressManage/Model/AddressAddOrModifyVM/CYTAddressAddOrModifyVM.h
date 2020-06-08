//
//  CYTAddressAddOrModifyVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTAddressModel.h"

@interface CYTAddressAddOrModifyVM : CYTExtendViewModel
///add or modify
@property (nonatomic, assign) BOOL addressAdd;
@property (nonatomic, strong) CYTAddressModel *addressModel;

///省市区
@property (nonatomic, copy) NSString *chooseContent;
///详细地址
@property (nonatomic, copy) NSString *detailContent;



@end
