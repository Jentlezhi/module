//
//  CYTDealerCommentVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTDealerCommentListModel.h"
#import "CYTDealerCommentCountModel.h"

@interface CYTDealerCommentVM : CYTExtendViewModel
///userId
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) CYTDealerCommentCountModel *countModel;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger lastId;
@property (nonatomic, assign) NSInteger isMore;
///0=全部 1=好评 2=中评 3=差评
@property (nonatomic, assign) NSInteger evalType;

@end
