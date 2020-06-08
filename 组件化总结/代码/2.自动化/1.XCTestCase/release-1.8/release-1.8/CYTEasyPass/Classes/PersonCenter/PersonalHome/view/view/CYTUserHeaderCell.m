//
//  CYTUserHeaderCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUserHeaderCell.h"
#import "CYTUserHeaderView.h"

@implementation CYTUserHeaderCell
{
    //用户信息
    CYTUserHeaderView *_userHeaderView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self userHeaderCellBasicConfig];
        [self initUserHeaderCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)userHeaderCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initUserHeaderCellComponents{
    //用户信息
    CYTUserHeaderView *userHeaderView = [[CYTUserHeaderView alloc] init];
    [self.contentView addSubview:userHeaderView];
    _userHeaderView = userHeaderView;
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTUserHeaderCell";
    CYTUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTUserHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
/**
 *  V1.6新
 */
- (void)setUserInfoModel:(CYTUserInfoModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    _userHeaderView.userInfoModel = userInfoModel;
}

@end
