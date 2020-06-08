//
//  CYTScrollMessageCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTScrollMessageCell.h"
#import "CYTStoreAuthModel.h"

@interface CYTScrollMessageCell()
/** 商家类型 */
@property(strong, nonatomic) UIButton *typeLabel;
/** 消息内容 */
@property(strong, nonatomic) UILabel *messageLabel;

@end

@implementation CYTScrollMessageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self scrollMessageBasicConfig];
        [self initScrollMessageComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)scrollMessageBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initScrollMessageComponents{
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.messageLabel];
    
    //测试数据
//    [self.typeLabel setTitle:@"4S" forState:UIControlStateNormal];
//    self.messageLabel.text = @"消息：有人下单啦，赶紧发货！";
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
    }];
}
#pragma mark - 懒加载

- (UIButton *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [UIButton tagButtonWithTextColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#3EC0FD")];
    }
    return _typeLabel;
}
- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _messageLabel;
}

- (void)setStoreAuthModel:(CYTStoreAuthModel *)storeAuthModel{
    _storeAuthModel = storeAuthModel;
    [self setValueWithStoreAuthModel:storeAuthModel];
    [self layoutWithStoreAuthModel:storeAuthModel];
}


- (void)setValueWithStoreAuthModel:(CYTStoreAuthModel *)storeAuthModel{
    [self.typeLabel setTitle:storeAuthModel.businessModel forState:UIControlStateNormal];
    NSString *userName = storeAuthModel.userName.length?storeAuthModel.userName:@"";
    NSString *companyName = storeAuthModel.companyName.length?storeAuthModel.companyName:@"";
    NSString *info = [NSString stringWithFormat:@"%@ %@",userName,companyName];
    self.messageLabel.text = info;
}
- (void)layoutWithStoreAuthModel:(CYTStoreAuthModel *)storeAuthModel{
    NSInteger fontNum = storeAuthModel.businessModel.length;
    CGFloat margin = CYTAutoLayoutH(40.f) + fontNum*CYTAutoLayoutH(5);
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(margin);
        make.right.equalTo(self.contentView);
    }];
}

@end
