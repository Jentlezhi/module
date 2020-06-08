//
//  CYTLogisticInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticTipCell.h"

@interface CYTLogisticTipCell()

/** 图标 */
@property(strong, nonatomic) UIImageView *iconImageView;
/** 箭头 */
@property(strong, nonatomic) UIImageView *arrowImageView;
/** 物流 */
@property(strong, nonatomic) UILabel *logisticLabel;
/** 分割条 */
@property(strong, nonatomic) UIView *topBar;;

@end

@implementation CYTLogisticTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self logisticInfoBasicConfig];
        [self initLogisticInfoComponents];
        [self makeConstrains];
    }
    return self;
}
#pragma mark - 懒加载

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView ff_imageViewWithImageName:@"btn_manage_dl"];
    }
    return _iconImageView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    }
    return _arrowImageView;
}
- (UILabel *)logisticLabel{
    if (!_logisticLabel) {
        _logisticLabel = [UILabel labelWithText:@"物流" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    }
    return _logisticLabel;
}

- (UIView *)topBar{
    if (!_topBar) {
        _topBar = [[UIView alloc] init];
        _topBar.backgroundColor = kFFColor_bg_nor;
    }
    return _topBar;
}

/**
 *  基本配置
 */
- (void)logisticInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CYTWeakSelf
    [self.contentView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.logisticClick?:weakSelf.logisticClick();
    }];
}
/**
 *  初始化子控件
 */
- (void)initLogisticInfoComponents{
    //分割条
    [self.contentView addSubview:self.topBar];
    //图标
    [self.contentView addSubview:self.iconImageView];
    //箭头
    [self.contentView addSubview:self.arrowImageView];
    //订单状态
    [self.contentView addSubview:self.logisticLabel];
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    CGFloat margin = CYTAutoLayoutV(15.f);
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(60.f));
        make.top.equalTo(self.topBar.mas_bottom).offset(margin);
        make.left.equalTo(CYTItemMarginH);
        make.bottom.equalTo(-margin).priorityMedium();
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(self.iconImageView);
        make.right.equalTo(-CYTItemMarginH);
    }];

    [self.logisticLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.left.equalTo(self.iconImageView.mas_right).offset(CYTAutoLayoutH(10));
        make.right.equalTo(self.arrowImageView).offset(-CYTItemMarginH);
    }];
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTLogisticTipCell";
    CYTLogisticTipCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTLogisticTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
