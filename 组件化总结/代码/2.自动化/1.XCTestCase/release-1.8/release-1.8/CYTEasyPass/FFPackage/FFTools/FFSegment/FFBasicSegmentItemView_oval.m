//
//  FFBasicSegmentItemView_oval.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSegmentItemView_oval.h"

@implementation FFBasicSegmentItemView_oval

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    
    _labelHeight = 20;
    _labelLeftMargin = 5;
    _labelRightMargin = 5;
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.titleButton];
    
    [self.titleButton radius:self.labelHeight/2.0 borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.titleButton makeConstraints:^(MASConstraintMaker *make) {

        make.height.equalTo(self.labelHeight);
        make.center.equalTo(self);
        make.top.greaterThanOrEqualTo(0);
        make.bottom.lessThanOrEqualTo(0);
        make.left.equalTo(self.labelLeftMargin);
        make.right.equalTo(-self.labelRightMargin);
    }];
}

- (void)setLabelHeight:(float)labelHeight {
    _labelHeight = labelHeight;
    [self layoutLabel];
}

- (void)setLabelLeftMargin:(float)labelLeftMargin {
    _labelLeftMargin = labelLeftMargin;
    [self layoutLabel];
}

- (void)setLabelRightMargin:(float)labelRightMargin {
    _labelRightMargin = labelRightMargin;
    [self layoutLabel];
}

- (void)layoutLabel {
    [self.titleButton radius:self.labelHeight/2.0 borderWidth:0.5 borderColor:[UIColor clearColor]];
    [self.titleButton remakeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(self.labelHeight);
        make.center.equalTo(self);
        make.top.greaterThanOrEqualTo(0);
        make.bottom.lessThanOrEqualTo(0);
        make.left.equalTo(self.labelLeftMargin);
        make.right.equalTo(-self.labelRightMargin);
    }];
}

@end
