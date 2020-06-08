//
//  CYTDealerCommentPublishContentView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTCommentPhraseView.h"
#import "CYTCommentScoreView.h"
#import "CYTDealerCommentPublishVM.h"

@interface CYTDealerCommentPublishContentView : FFExtendView
@property (nonatomic, strong) CYTDealerCommentPublishVM *viewModel;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) UIView *titleLine;

@property (nonatomic, strong) CYTCommentScoreView *scoreView;
@property (nonatomic, strong) CYTCommentPhraseView *phraseView;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) void (^cancelBlock) (void);
@property (nonatomic, copy) void (^publishBlock) (CYTDealerCommentPublishVM *model);

@end
