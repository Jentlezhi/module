//
//  CYTCarSourcePriceInputView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTPriceInputView.h"

@interface CYTCarSourcePriceInputView : FFExtendView
@property (nonatomic, strong) CYTPriceInputView *inputView;
@property (nonatomic, copy) void (^cancelBlock) (void);
@property (nonatomic, copy) void (^affirmBlock) (NSInteger , NSString *, NSString *);

- (float)viewHeight;
- (void)showOnView:(UIView *)view;
@property (nonatomic, assign) BOOL effective;
@property (nonatomic, copy) NSString *guidePrice;

@end
