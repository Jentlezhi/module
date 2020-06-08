//
//  CYTDealerHome_commentModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"
#import "CYTDealerCommentListModel.h"

@interface CYTDealerHome_commentModel : FFExtendModel
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, copy) NSString *totalCount;
@property (nonatomic, strong) NSArray *list;

@end
