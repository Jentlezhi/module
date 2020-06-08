//
//  CYTDealerAuthImageVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTDealerAuthImageModel.h"

@interface CYTDealerAuthImageVM : CYTExtendViewModel
///只显示实体店面认证图片
@property (nonatomic, assign) BOOL onlyEntityShow;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, copy) NSString *userId;

@end
