//
//  CYTDealerHomeAuthInfoCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHomeAuthInfoCell.h"

@interface CYTDealerHomeAuthInfoCell ()

@end

@implementation CYTDealerHomeAuthInfoCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.cellView];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.cellView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTDealerHomeAuthInfoModel *)model {
    _model = model;
    self.cellView.model = model;
}

#pragma mark- get
- (CYTDealerAuthInfoCellView *)cellView {
    if (!_cellView) {
        _cellView = [CYTDealerAuthInfoCellView new];
    }
    return _cellView;
}

@end
