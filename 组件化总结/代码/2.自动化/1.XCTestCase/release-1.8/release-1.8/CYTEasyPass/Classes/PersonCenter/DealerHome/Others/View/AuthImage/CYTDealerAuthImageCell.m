//
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerAuthImageCell.h"

@implementation CYTDealerAuthImageCell

- (void)ff_addSubViewAndConstraints {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark- get
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView ff_imageViewWithImageName:nil];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

@end
