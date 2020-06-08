//
//  CYTDealerHeadCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHeadCell.h"

@implementation CYTDealerHeadCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.headView];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.headView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTDealerHeadModel *)model {
    _model = model;
    self.headView.model = model;
}

#pragma mark- get
- (CYTDealerHeadCellView *)headView {
    if (!_headView) {
        _headView = [CYTDealerHeadCellView new];
    }
    return _headView;
}

@end
