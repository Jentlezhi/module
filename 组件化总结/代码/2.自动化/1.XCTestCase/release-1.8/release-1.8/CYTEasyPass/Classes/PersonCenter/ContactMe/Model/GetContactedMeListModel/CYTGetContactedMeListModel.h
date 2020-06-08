//
//  CYTGetContactedMeListModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYTContactRecordCarInfoModel;
@class CYTDealer;

@interface CYTGetContactedMeListModel : NSObject

/** 车款信息 */
@property(strong, nonatomic) CYTContactRecordCarInfoModel *carInfo;
/** 车款信息 */
@property(strong, nonatomic) CYTDealer *dealer;

@end
