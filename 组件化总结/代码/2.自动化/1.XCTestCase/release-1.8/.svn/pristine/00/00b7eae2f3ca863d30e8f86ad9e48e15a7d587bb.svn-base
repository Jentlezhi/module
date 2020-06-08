//
//  CYTPriceInputView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTPriceInputContentView.h"

#define kInputViewHeight (CYTAutoLayoutV(420))

@interface CYTPriceInputView : FFExtendView
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *hopePriceLabel;
@property (nonatomic, strong) UIButton *affirmButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *guidePriceView;
@property (nonatomic, strong) UILabel *guidePriceLabel;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) CYTPriceInputContentView *contentView;

@property (nonatomic, copy) void (^cancelBlock) (void);
@property (nonatomic, copy) void (^affirmBlock) (NSInteger , NSString *, NSString *);

@property (nonatomic, copy) NSString *guidePrice;

@end
