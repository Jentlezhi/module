//
//  FFCell_Style_Input.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCell_Style_Input.h"

@implementation FFCell_Style_Input

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.cellView];
    block(views,^{
        self.bottomHeight = 0;
        self.contentView.backgroundColor = [UIColor whiteColor];
    });
}

- (void)updateConstraints {
    [self.cellView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
        make.height.equalTo(self.ffContentView);
    }];
    
    [super updateConstraints];
}

#pragma mark- get
- (FFCellView_Style_input *)cellView {
    if (!_cellView) {
        _cellView = [FFCellView_Style_input new];
        @weakify(self);
        [_cellView setTextBlock:^(NSString *text) {
            @strongify(self);
            if (self.textBlock) {
                self.textBlock(text);
            }
        }];
    }
    return _cellView;
}

@end
