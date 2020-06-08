//
//  Pcms
//
//  Created by xujunquan on 16/10/20.
//  Copyright © 2016年 cig. All rights reserved.
//

#import "FFDZNEmptyView.h"

@implementation FFDZNEmptyView

- (void)ff_addSubViewAndConstraints {
    [self radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
    
    [self addSubview:self.dznImageView];
    [self addSubview:self.dznLabel];
    
    //设置图片压缩优先级低，则图片被压缩显示，不会造成label无法显示的状况,重要方法
//    [self.imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.dznImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
    }];
    
    [self.dznLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.dznImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self);
    }];
}

@end
