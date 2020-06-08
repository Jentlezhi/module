//
//  LogisticsHomeHeadItem.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "LogisticsHomeHeadItem.h"

@implementation LogisticsHomeHeadItem

- (void)ff_initWithViewModel:(id)viewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    @weakify(self);
    [[tapGes rac_gestureSignal]subscribeNext:^(id x) {
        @strongify(self);
        if (self.clickedBlock) {
            self.clickedBlock(self);
        }
    }];
    [self addGestureRecognizer:tapGes];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _imageView;
}

@end
