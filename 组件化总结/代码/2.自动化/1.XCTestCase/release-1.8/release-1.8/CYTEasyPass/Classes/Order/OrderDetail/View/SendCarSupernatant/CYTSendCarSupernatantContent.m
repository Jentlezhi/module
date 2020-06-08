//
//  CYTSendCarSupernatantContent.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSendCarSupernatantContent.h"

@implementation CYTSendCarSupernatantContent

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView ff_imageViewWithImageName:@"order_sendCar_fc"];
    }
    return _imageView;
}

@end
