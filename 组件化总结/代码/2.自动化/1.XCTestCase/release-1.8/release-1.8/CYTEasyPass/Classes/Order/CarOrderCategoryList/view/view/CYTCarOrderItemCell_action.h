//
//  CYTCarOrderItemCell_action.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTCarOrderItemCell_action : FFExtendView
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;
@property (nonatomic, strong) UIButton *midButton;

//0
@property (nonatomic, copy) void (^firstBlock) (NSInteger);
//1
@property (nonatomic, copy) void (^secondBlock) (NSInteger);
//5
@property (nonatomic, copy) void (^midBlock) (NSInteger);

@end
