//
//  CYTArrivalDateVC.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFSideSlideContentBasicController.h"
#import "CYTArrivalDateVM.h"

@interface CYTArrivalDateVC : FFSideSlideContentBasicController
@property (nonatomic, strong) CYTArrivalDateVM *viewModel;
@property (nonatomic, copy) void (^selectModelBlock) (CYTArrivalDateItemModel *);

@end
