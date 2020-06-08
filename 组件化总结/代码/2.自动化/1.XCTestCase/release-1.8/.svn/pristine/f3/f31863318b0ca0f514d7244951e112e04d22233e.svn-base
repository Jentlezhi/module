//
//  CYTLogisticsNeedCell_ActionView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedCell_ActionView.h"

@interface CYTLogisticsNeedCell_ActionView ()
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation CYTLogisticsNeedCell_ActionView

- (void)ff_initWithViewModel:(id)viewModel {
    _status = -100;
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.actionButton];
    [self.actionButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(CYTAutoLayoutH(180));
        make.height.equalTo(0);
        make.right.equalTo(-CYTItemMarginH);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

- (NSString *)titleWithStatus:(CYTLogisticsOrderStatus)status {
    NSString *title;
    if (status == CYTLogisticsOrderStatusWaitMatchingBoard || status == CYTLogisticsOrderStatusWaitDriver || status == CYTLogisticsOrderStatusInTransit) {
        title = @"确认收车";
    }else if (status == CYTLogisticsOrderStatusFinishUnComment) {
        title = @"去评价";
    }
    return title;
}

- (BOOL)showWithStatus:(CYTLogisticsOrderStatus)status {
    BOOL show = NO;
    if (status == CYTLogisticsOrderStatusWaitMatchingBoard || status == CYTLogisticsOrderStatusWaitDriver || status == CYTLogisticsOrderStatusInTransit || status == CYTLogisticsOrderStatusFinishUnComment) {
        show = YES;
    }
    show = (status==-100)?NO:show;
    return show;
}

- (NSInteger)indexWithStatus:(CYTLogisticsOrderStatus)status {
    NSInteger index = 0;
    if (status == CYTLogisticsOrderStatusWaitMatchingBoard || status == CYTLogisticsOrderStatusWaitDriver || status == CYTLogisticsOrderStatusInTransit) {
        index = 100;
    }else if (status == CYTLogisticsOrderStatusFinishUnComment) {
        index = 200;
    }
    return index;
}

- (void)setStatus:(CYTLogisticsOrderStatus)status {
    _status = status;
    [self.actionButton setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    BOOL show = [self showWithStatus:self.status];
   
    float height = (show)?CYTAutoLayoutV(58):0;
    float top = (show)?CYTAutoLayoutV(10):0;
    float bot = (show)?CYTAutoLayoutV(-22):0;
    self.actionButton.hidden = !(show);
    [self.actionButton updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
        make.top.equalTo(top);
        make.bottom.equalTo(bot);
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithFontPxSize:28 textColor:[UIColor whiteColor] text:nil];
        _actionButton.backgroundColor = kFFColor_green;
        _actionButton.hidden = YES;
        @weakify(self);
        [[_actionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock([self indexWithStatus:self.status]);
            }
        }];
    }
    return _actionButton;
}

@end
