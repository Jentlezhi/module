//
//  CYTLogisticsNeedBottomView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTLogisticsNeedBottomView : FFExtendView
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIButton *rightButton;
//@property (nonatomic, copy) NSString *priceString;
@property (nonatomic, assign) BOOL valid;
@property (nonatomic, copy) void (^clickedBlock) (void);

@end


