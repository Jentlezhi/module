//
//  CYTNoDataView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTNoDataView.h"

@interface CYTNoDataView()


@end

@implementation CYTNoDataView
{
    //文字提示
    UILabel *_tipLabel;
    NSString *_imageName;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self noDataViewBasicConfig];
        [self initNoDataViewComponents];
        [self makeConstrains];
    }
    return  self;
}

/**
 *  基本配置
 */
- (void)noDataViewBasicConfig{
    self.backgroundColor = CYTLightGrayColor;
    self.userInteractionEnabled = YES;
}

/**
 *  初始化子控件
 */
- (void)initNoDataViewComponents{
    //无数据图标
    UIImageView *noDataIcon = [[UIImageView alloc] init];
    [self addSubview:noDataIcon];
    _noDataImageView = noDataIcon;
    //文字提示
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = CYTHexColor(@"#B6B6B6");
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = CYTFontWithPixel(28.f);
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noDataImageView.mas_bottom).offset(CYTAutoLayoutV(35.f));
        make.centerX.equalTo(self);
        make.left.right.equalTo(self);
    }];
}

- (void)setContent:(NSString *)content{
    _content = content;
    _tipLabel.text = content;
}

- (NSString *)imageName{
    if (_imageName) {
        return @"bg_information_hl";
    }
    return _imageName;
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.noDataImageView.image = [UIImage imageNamed:imageName];
}

- (void)setHomeLayout:(BOOL)homeLayout{
    _homeLayout = homeLayout;
    if (homeLayout) {
        _tipLabel.font = CYTFontWithPixel(24.f);
        [_noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(70.f));
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(160*0.8f), CYTAutoLayoutV(140*0.8f)));
            make.centerX.equalTo(self);
        }];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_noDataImageView.mas_bottom).offset(CYTAutoLayoutV(35.f));
            make.centerX.equalTo(self);
            make.left.right.equalTo(self);
        }];
    }
}

@end
