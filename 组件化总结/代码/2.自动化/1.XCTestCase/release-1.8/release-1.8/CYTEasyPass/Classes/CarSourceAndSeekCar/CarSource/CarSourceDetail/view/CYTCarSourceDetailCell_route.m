//
//  CYTCarSourceDetailCell_route.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_route.h"

@interface CYTCarSourceDetailCell_route ()

@end

@implementation CYTCarSourceDetailCell_route

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
    NSArray *views = @[self.cellView];
    block(views,^{
        self.bottomHeight = 0;
    });
}

///cell布局
- (void)updateConstraints {
    [self.cellView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(150));
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
- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

- (void)setModel:(CarSourceDetailItemModel *)model {
    _model = model;
    self.cellView.model = model;
}

#pragma mark- get
- (CYTCarSourceDetailCell_route_view *)cellView {
    if (!_cellView) {
        _cellView = [CYTCarSourceDetailCell_route_view new];
    }
    return _cellView;
}


@end
