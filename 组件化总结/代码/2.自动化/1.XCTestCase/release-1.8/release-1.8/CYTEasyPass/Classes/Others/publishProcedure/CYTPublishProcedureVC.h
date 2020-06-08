//
//  CYTPublishProcedureVC.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTPublishProcedureVM.h"

@interface CYTPublishProcedureVC : CYTBasicViewController
@property (nonatomic, strong) CYTPublishProcedureVM *viewModel;
@property (nonatomic, copy) void (^procedureBlock) (NSString *);

@end
