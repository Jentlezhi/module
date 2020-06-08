//
//  CYTLogListCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogListCell.h"
#import "CYTLogListModel.h"

@interface CYTLogListCell()

/** 交易时间 */
@property(weak, nonatomic) UILabel *logListCreatetimeLabel;
/** 用户名字 */
@property(weak, nonatomic) UILabel *userNameLabel;
/** 操作类型 */
@property(weak, nonatomic) UILabel *logTitleLabel;

@end

@implementation CYTLogListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self logListCellBasicConfig];
        [self initLogListCellComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)logListCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initLogListCellComponents{
    //交易时间
    UILabel *logListCreatetimeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self.contentView addSubview:logListCreatetimeLabel];
    _logListCreatetimeLabel = logListCreatetimeLabel;

    
    //用户名字
    UILabel *userNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self.contentView addSubview:userNameLabel];
    _userNameLabel = userNameLabel;
    
    //操作类型
    UILabel *logTitleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:NO];
    [self.contentView addSubview:logTitleLabel];
    _logTitleLabel = logTitleLabel;

}

- (void)makeConstrains{
    CGFloat maxWidth = (kScreenWidth-2*CYTMarginH-2*CYTItemMarginH)/3.0;
    [_logListCreatetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(-CYTItemMarginV);
        make.width.equalTo(maxWidth+CYTAutoLayoutH(40.f));
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logListCreatetimeLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_logListCreatetimeLabel);
        make.width.equalTo(maxWidth-CYTAutoLayoutH(20));
    }];
    
    [_logTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(_logListCreatetimeLabel);
        make.width.equalTo(maxWidth-CYTAutoLayoutH(20));
    }];
    
}

+ (instancetype)logListCelllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTLogListCell";
    CYTLogListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (void)setLogListModel:(CYTLogListModel *)logListModel{
    if (!logListModel) return;
    _logListModel = logListModel;
    
    //测试数据
//    logListModel.CreateOn = @"2017-06-22 18:33";
//    logListModel.UserName = @"张三";
//    logListModel.UserDesc = @"卖家";
//    logListModel.LogTitle = @"支付订金";
    [self setValueWithLogListModel:logListModel];
}

- (void)setValueWithLogListModel:(CYTLogListModel *)logListModel{
    _logListCreatetimeLabel.text = logListModel.operationTime;
    _userNameLabel.text = logListModel.userDesc;
    _logTitleLabel.text = logListModel.logDesc;
}


@end
