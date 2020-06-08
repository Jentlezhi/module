//
//  CYTCarListInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarListInfoCell.h"
#import "CYTCarSourceListModel.h"
#import "CYTSeekCarListModel.h"
#import "CYTPersonalInfoView.h"

@implementation CYTCarListInfoCell
{
    //车款信息
    CYTCarListInfoView *_carListInfoView;
    //个人信息条
    CYTPersonalInfoView *_personalInfoView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style type:(CYTCarListInfoType)carListInfoType reuseIdentifier:(NSString *)reuseIdentifier hideTopBar:(BOOL)hide{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self carListInfoCellBasicConfig];
        [self initCarListInfoCellComponentsWithType:carListInfoType hideTopBar:hide];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)carListInfoCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initCarListInfoCellComponentsWithType:(CYTCarListInfoType)carListInfoType hideTopBar:(BOOL)hide{
    //车款信息
    CYTCarListInfoView *carListInfoView = [CYTCarListInfoView carListInfoWithType:carListInfoType hideTopBar:hide];
    [self.contentView addSubview:carListInfoView];
    _carListInfoView = carListInfoView;
    
    //个人信息条
    CYTPersonalInfoView *personalInfoView = [[CYTPersonalInfoView alloc] init];
    [self addSubview:personalInfoView];
    _personalInfoView = personalInfoView;
}

/**
 *  布局控件
 */
- (void)makeConstrains{
    CGFloat personalInfoViewH = CYTAutoLayoutV(80.f);
    [_carListInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(-personalInfoViewH);
    }];
    [_personalInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_carListInfoView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(personalInfoViewH);
    }];
}

+ (instancetype)cellWithType:(CYTCarListInfoType)carListInfoType forTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath hideTopBar:(BOOL)hide{
    static NSString *identifier = @"CYTCarListInfoCell";
    CYTCarListInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCarListInfoCell alloc] initWithStyle:UITableViewCellStyleDefault type:carListInfoType reuseIdentifier:identifier hideTopBar:hide];
    }
    return cell;
}

#pragma make - 赋值
/**
 *  车源
 */
- (void)setCarSourceListModel:(CYTCarSourceListModel *)carSourceListModel{
    _carSourceListModel = carSourceListModel;
    if (carSourceListModel.myContect && [carSourceListModel.carSourceInfo.carSourceStatus integerValue] == 0) {
        self.contentView.backgroundColor = [CYTHexColor(@"#000000") colorWithAlphaComponent:0.06f];
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    _carListInfoView.carSourceListModel = carSourceListModel;
    _personalInfoView.dealer = carSourceListModel.dealer;
}
/**
 *  寻车
 */
- (void)setSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    _seekCarListModel = seekCarListModel;
    if (seekCarListModel.myContect && [seekCarListModel.seekCarInfo.seekCarStatus integerValue] == 0) {
        self.contentView.backgroundColor = [CYTHexColor(@"#000000") colorWithAlphaComponent:0.06f];
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    _carListInfoView.seekCarListModel = seekCarListModel;
    _personalInfoView.dealer = seekCarListModel.dealer;
}


@end
