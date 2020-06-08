//
//  CYTCarTradeCircleCtr.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTH5WithInteractiveCtr.h"
#import "CYTCarTradeCircleCallMonitorModel.h"

typedef NS_ENUM(NSInteger,CarTradeViewType) {
    CarTradeViewTypeHome,
    CarTradeViewTypeList,
    CarTradeViewTypeDetail,
};

@interface CYTCarTradeCircleCtr : CYTH5WithInteractiveCtr

@property (nonatomic, assign) CarTradeViewType type;

@property (nonatomic, copy) NSString *telNumber;
@property (nonatomic, copy) NSString *pubUserId;
@property (nonatomic, copy) NSString *momentId;

@property(copy, nonatomic) NSString *rightBarItemTitle;
///删除操作回调
@property (nonatomic, copy) void (^deleteBlock) (void);

@end
