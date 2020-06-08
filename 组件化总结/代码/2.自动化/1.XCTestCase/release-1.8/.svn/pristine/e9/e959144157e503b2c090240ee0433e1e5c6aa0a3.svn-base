//
//  CYTPriceInputContentView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTPriceInputContentView : FFExtendView
@property (nonatomic, strong) FFBasicSegmentView *segmentView;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UITextField *textFiled;

@property (nonatomic, copy) void (^indexBlock) (NSInteger);
@property (nonatomic, copy) void (^priceBlock) (NSString *);

- (float)viewHeight;
- (void)clearMethod;
@property (nonatomic, copy) NSString *guidePrice;

@end
