//
//  CYTDealerHomeCommentCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTDealerCommentCellView.h"

@interface CYTDealerHomeCommentCell : FFExtendTableViewCell
@property (nonatomic, strong) CYTDealerCommentCellView *cellView;
@property (nonatomic, strong) CYTDealerCommentListModel *model;
@property (nonatomic, assign) BOOL needSep;

@end
