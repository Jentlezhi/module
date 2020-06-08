//
//  CYTOrderSendCarInfoVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTOrderSendCarInfoModel.h"

@interface CYTOrderSendCarInfoVM : CYTExtendViewModel
///发车信息
@property (nonatomic, strong) CYTOrderSendCarInfoModel *infoModel;
///orderid
@property (nonatomic, copy) NSString *orderId;
///数据条数
@property (nonatomic, assign) NSInteger dataCount;
///flag数组
@property (nonatomic, strong) NSArray *flagArray;
///获取cell数据
- (NSString *)itemInfoWithIndex:(NSInteger)index;


@end
