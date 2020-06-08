//
//  CYTDealerHomeCommentCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHomeCommentCell.h"

@implementation CYTDealerHomeCommentCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.cellView];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.cellView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(CYTDealerCommentListModel *)model {
    _model = model;
    self.cellView.model = model;
}

- (void)setNeedSep:(BOOL)needSep {
    _needSep = needSep;
    self.cellView.needSep = needSep;
}

#pragma mark- get
- (CYTDealerCommentCellView *)cellView {
    if (!_cellView) {
        _cellView = [CYTDealerCommentCellView new];
    }
    return _cellView;
}

@end
