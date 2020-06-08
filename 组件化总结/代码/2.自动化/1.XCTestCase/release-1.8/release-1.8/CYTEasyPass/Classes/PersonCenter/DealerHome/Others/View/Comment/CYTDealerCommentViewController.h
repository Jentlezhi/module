//
//  CYTDealerCommentViewController.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFTabControl.h"
#import "CYTDealerCommentItemVC.h"

@interface CYTDealerCommentViewController : FFTabControl
///用户id
@property (nonatomic, copy) NSString *userId;
///添加评论成功则调用。
@property (nonatomic, copy) void (^refreshBlock) (void);

@end
