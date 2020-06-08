//
//  CYTCarSourceDetailCell_flow.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_flow.h"
#import "CarSourceDetailItemModel.h"

@interface CYTCarSourceDetailCell_flow ()

@end

@implementation CYTCarSourceDetailCell_flow

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- flow control
///cell加载子视图
- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flowImageView];
    block(views,^{
        self.bottomHeight = 0;
    });
}

///cell布局
- (void)updateConstraints {
    [self.flowImageView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(250));
    }];
    
    [super updateConstraints];
}

///自定义cell样式
- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
///cell赋值
- (void)setFfModel:(CarSourceDetailItemModel *)ffModel {
    self.model = ffModel.flowModel;
}

- (void)setModel:(CarSourceDetailDescModel *)model {
    _model = model;
    [self.flowImageView sd_setImageWithURL:[NSURL URLWithString:model.graphUrl] placeholderImage:[UIImage imageNamed:@"home_banner_placeholder"]];
}

#pragma mark- get
- (UIImageView *)flowImageView {
    if (!_flowImageView) {
        _flowImageView = [UIImageView ff_imageViewWithImageName:nil];
        _flowImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _flowImageView;
}


@end
