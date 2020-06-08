//
//  CYTHomeToolBarCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTHomeToolBarCell.h"
#import "CYTFunctionModel.h"

@interface CYTHomeToolBarCell()
/** 图片 */
@property(strong, nonatomic) UIImageView *icon;
/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;

@end

@implementation CYTHomeToolBarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self homeToolBarBasicConfig];
        [self initHomeToolBarComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)homeToolBarBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initHomeToolBarComponents{
    //添加图标
    [self.contentView addSubview:self.icon];
    //添加标题
    [self.contentView addSubview:self.titleLabel];

}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(16.f));
        make.centerX.equalTo(self.contentView);
        make.width.height.equalTo(CYTAutoLayoutV(80.f));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(CYTAutoLayoutV(12.f));
        make.centerX.equalTo(self.icon);
        make.left.equalTo(CYTAutoLayoutH(10.f));
        make.right.equalTo(-CYTAutoLayoutH(10.f));
    }];
}
#pragma mark - 懒加载

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentCenter fontPixel:26.f setContentPriority:NO];
    }
    return _titleLabel;
}

- (void)setIndexFunctionModel:(CYTFunctionModel *)indexFunctionModel{
    _indexFunctionModel = indexFunctionModel;
    [self.icon setImage:[UIImage imageNamed:indexFunctionModel.imageUrl]];
    if (indexFunctionModel.btnText.length) {
        self.titleLabel.text = indexFunctionModel.btnText;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
    }else{
        self.titleLabel.text = @"     ";
        self.titleLabel.backgroundColor = CYTLightGrayColor;
    }
}

@end
