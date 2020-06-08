//
//  CYTSourceAndFindCarSearchHeadView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTSourceAndFindCarSearchHeadView : FFExtendView
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, copy) void (^clearBlock) (void);

@end
