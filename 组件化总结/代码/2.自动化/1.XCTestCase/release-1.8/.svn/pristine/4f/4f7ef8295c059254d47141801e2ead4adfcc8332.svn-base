//
//  CYTPersonalInfoView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalInfoView.h"
#import "CYTStarView.h"
#import "CYTDealer.h"

@implementation CYTPersonalInfoView
{
    //分割线
    UILabel *_lineLabel;
    //头像
    UIImageView *_headerImageView;
    //姓名
    UILabel *_nameLabel;
    //商家类型
    UIButton *_typeLabel;
    //认证情况
    UIButton *_authenLabel;
    //评价
    CYTStarView *_starView;
    //创建时间
    UILabel *_createTimeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self personalInfoBasicConfig];
        [self initPersonalInfoComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)personalInfoBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initPersonalInfoComponents{
    //分割线
    UILabel *lineLabel = [UILabel dividerLineLabel];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;

    //头像
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:headerImageView];
    _headerImageView = headerImageView;
    
    //姓名
    UILabel *nameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft font:CYTFontWithPixel(26.f) setContentPriority:NO];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    //商家类型
    UIButton *typeLabel = [UIButton tagButtonWithTextColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#3EC0FD")];
    [self addSubview:typeLabel];
    _typeLabel = typeLabel;
    
    //认证情况
    UIButton *authenLabel = [UIButton tagButtonWithText:@"实" textColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#F43244")];
    [self addSubview:authenLabel];
    _authenLabel = authenLabel;
    
    //评价
    CYTStarView *starView = [[CYTStarView alloc] init];
    starView.starTotalNum = 5;
    [self addSubview:starView];
    _starView = starView;
    
    //创建时间
    UILabel *createTimeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight font:CYTFontWithPixel(24.f) setContentPriority:YES];
    [self addSubview:createTimeLabel];
    _createTimeLabel = createTimeLabel;
    
    //测试数据
//    _headerImageView.image = [UIImage imageWithColor:CYTGreenNormalColor];
//    _nameLabel.text = @"赵四";
//    [_typeLabel setTitle:@"资" forState:UIControlStateNormal];
//    _starView.starValue = 1.5;
//    _createTimeLabel.text = @"15:23";
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTItemMarginH);
        make.right.equalTo(self).offset(-CYTItemMarginH);
        make.top.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTItemMarginH);
        make.width.height.equalTo(CYTAutoLayoutV(50.f));
        _headerImageView.layer.cornerRadius = CYTAutoLayoutV(50.f)*0.5f;
        _headerImageView.layer.masksToBounds = YES;
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(CYTAutoLayoutH(10.f));
        make.centerY.equalTo(self);
        make.width.mas_lessThanOrEqualTo(CYTAutoLayoutH(150));
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_nameLabel.mas_right).offset(CYTAutoLayoutH(10));
    }];
    
    [_authenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_typeLabel.mas_right).offset(CYTAutoLayoutH(10));
    }];

    extern CGFloat starWidth;
    extern CGFloat starHeight;
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_authenLabel.mas_right).offset(CYTAutoLayoutH(10));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*_starView.starTotalNum, CYTAutoLayoutV(starHeight)));
    }];

    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTItemMarginH);
    }];

}

- (void)setDealer:(CYTDealer *)dealer{
    _dealer = dealer;
    [self setValueWithDealer:dealer];
    [self layoutWithDealer:dealer];
}

- (void)setValueWithDealer:(CYTDealer *)dealer{
//    dealer.isStoreAuth = YES;
    //头像
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:dealer.avatar] placeholderImage:kPlaceholderHeaderImage];
    //昵称
    NSString *userName = dealer.userName.length?dealer.userName:@"";
    _nameLabel.text = userName;
    //商家类型
    NSString *businessModel = dealer.businessModel.length?dealer.businessModel:@"";
    [_typeLabel setTitle:businessModel forState:UIControlStateNormal];
    //评价星级
    _starView.starValue = dealer.starScore;
    //创建时间
    _createTimeLabel.text = dealer.publishTime;

}

- (void)layoutWithDealer:(CYTDealer *)dealer{
    //布局商家类型
    [_typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_nameLabel.mas_right).offset(CYTAutoLayoutH(10));
    }];
    //布局实店认证情况
    if (dealer.isStoreAuth) {
        _authenLabel.hidden = NO;
        extern CGFloat starWidth;
        extern CGFloat starHeight;
        [_starView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_authenLabel.mas_right).offset(CYTAutoLayoutH(10));
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*_starView.starTotalNum, CYTAutoLayoutV(starHeight)));
        }];
    }else{
        _authenLabel.hidden = YES;
        extern CGFloat starWidth;
        extern CGFloat starHeight;
        [_starView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_typeLabel.mas_right).offset(CYTAutoLayoutH(10));
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*_starView.starTotalNum, CYTAutoLayoutV(starHeight)));
        }];
    }
}

@end
