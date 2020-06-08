//
//  CYTUpdateManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSupernatantViewModel.h"
#import "CYTUpdateModel.h"

@interface CYTUpdateManager : FFBasicSupernatantViewModel
@property (nonatomic, strong) CYTUpdateModel *updateModel;
+ (void)update;

@end
