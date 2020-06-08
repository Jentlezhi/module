//
//  CYTSettingTableViewCell.m
//  CYTEasyPass
//
//  Created by bita on 15/9/7.
//  Copyright (c) 2015年 EasyPass. All rights reserved.
//

#import "CYTSettingTableViewCell.h"
#import "CYTSettingItemModel.h"

@interface CYTSettingTableViewCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *indicator;
@property (nonatomic,strong) UIImageView *picUser;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation CYTSettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self initSettingTableViewCellComponents];

    }
    return self;
}

- (void)initSettingTableViewCellComponents{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = CYTFontWithPixel(30.f);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor = CYTHexColor(@"#333333");
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = CYTFontWithPixel(28.f);
    self.contentLabel.textAlignment = NSTextAlignmentRight;
    self.contentLabel.textColor = CYTHexColor(@"#999999");
    self.contentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentLabel];

    
    self.indicator = [[UIImageView alloc] init];
    self.indicator.backgroundColor = [UIColor clearColor];
    self.indicator.contentMode = UIViewContentModeScaleToFill;
    self.indicator.image = [UIImage imageNamed:@"ic_enter_hl"];
    [self.contentView addSubview:self.indicator];
    
    
    self.picUser = [[UIImageView alloc] init];
    self.picUser.contentMode = UIViewContentModeScaleAspectFill;
    self.picUser.backgroundColor = [UIColor clearColor];
    self.picUser.layer.cornerRadius = CYTAutoLayoutV(100)*0.5;
    self.picUser.layer.masksToBounds = YES;
    [self.contentView addSubview:self.picUser];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self.contentView addSubview:self.lineView];
}

- (void)makeConstraintsWithModel:(CYTSettingItemModel *)settingItemModel{
    
    //分割线
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    //箭头
    [self.indicator remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.offset(-CYTMarginH);
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
    }];
    //子标题
    CGFloat contentLabelH = self.contentLabel.font.pointSize+2;
    if (settingItemModel.content.length) {
        if (settingItemModel.showIndicator) {
            [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.indicator.mas_left);
                make.centerY.equalTo(self.contentView);;
                make.left.equalTo(self.titleLabel.mas_right).offset(CYTMarginH);
                make.height.equalTo(contentLabelH);
            }];
        }else{
            [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-CYTMarginH);
                make.centerY.equalTo(self.contentView);;
                make.left.equalTo(self.titleLabel.mas_right).offset(CYTMarginH);
                make.height.equalTo(contentLabelH);
            }];
        }
    }
    
    //头像
    [self.picUser remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.indicator.mas_left).offset(-CYTAutoLayoutV(5));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(100), CYTAutoLayoutV(100)));
    }];

    
    //标题
    CGFloat titleLabelH = self.titleLabel.font.pointSize+2;
    if (settingItemModel.onlyTitle) {
        if ([settingItemModel.title isEqualToString:@"退出登录"]) {
            self.titleLabel.font = CYTFontWithPixel(36.f);
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabelH = self.titleLabel.font.pointSize+2;
            [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.contentView);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(titleLabelH);
            }];

        }else{
            [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.offset(CYTMarginH);
                make.right.equalTo(self.indicator.mas_left).offset(-CYTMarginH);
                make.height.equalTo(titleLabelH);
            }];
        }
    }else{
        if (settingItemModel.content.length) {
            [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.offset(CYTMarginH);
                make.right.equalTo(self.contentLabel.mas_left).offset(-CYTMarginH);
                make.height.equalTo(titleLabelH);
            }];

        }else{
            [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.offset(CYTMarginH);
                make.right.equalTo(self.picUser.mas_left).offset(-CYTMarginH);
                make.height.equalTo(titleLabelH);
            }];

        }
    }

}

- (void)setSettingItemModel:(CYTSettingItemModel *)settingItemModel{
    _settingItemModel = settingItemModel;
    //赋值
    self.titleLabel.text = settingItemModel.title;
    self.contentLabel.text = settingItemModel.content;
    if ([settingItemModel.content isEqualToString:@"去认证"] || [settingItemModel.content isEqualToString:@"请修改"] || [settingItemModel.content isEqualToString:@"未认证"]) {
        self.contentLabel.textColor = CYTHexColor(@"#f43244");
    }else{
        self.contentLabel.textColor = CYTHexColor(@"#999999");
    }
    if (settingItemModel.showHeader) {
        [self.picUser sd_setImageWithURL:[NSURL URLWithString:settingItemModel.picUrl] placeholderImage:kPlaceholderHeaderImage];
        
    }else{
        self.picUser.hidden = YES;
    }
    //隐藏箭头和分割线
    self.indicator.hidden = !settingItemModel.showIndicator;
    self.lineView.hidden = settingItemModel.hiddeDividerLine;
    //布局子控件
    [self makeConstraintsWithModel:settingItemModel];
}


@end
