//
//  CYTVehicleToolsListView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTVehicleToolsListView.h"
#import "CYTVehicleToolsModel.h"

@interface CYTVehicleToolsListView()

/** 标识 */
@property(strong, nonatomic) UIImageView *identifierIcon;
/** 内容 */
@property(strong, nonatomic) UILabel *contentLabel;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLineLabel;
/** 分割条 */
@property(strong, nonatomic) UIView *topBar;

@end

@implementation CYTVehicleToolsListView

- (instancetype)initWithType:(CYTVehicleToolsListType)listType{
    if (self = [self init]) {
        [self vehicleToolsHeaderViewBasicConfig];
        [self initVehicleToolsHeaderViewComponentsWithType:listType];
        [self makeConstrainsWithType:listType];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)vehicleToolsHeaderViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initVehicleToolsHeaderViewComponentsWithType:(CYTVehicleToolsListType)listType{
    CYTWeakSelf
    if (listType == CYTVehicleToolsViewTypeHeaderView) {
        [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            !weakSelf.sectionHeaderClick?:weakSelf.sectionHeaderClick();
        }];
        [self addSubview:self.topBar];
    }
    [self addSubview:self.identifierIcon];
    [self addSubview:self.contentLabel];
    [self addSubview:self.dividerLineLabel];
}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithType:(CYTVehicleToolsListType)listType{
    if (listType == CYTVehicleToolsViewTypeHeaderView){
        [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(CYTAutoLayoutV(20));
        }];
        
        [self.identifierIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTMarginH);
            make.centerY.equalTo(self).offset(CYTItemMarginV*0.5f);
            make.width.height.equalTo(CYTAutoLayoutV(40.f));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.identifierIcon.mas_right).offset(CYTAutoLayoutH(10.f));
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(CYTAutoLayoutV(40.f));
            make.bottom.equalTo(-CYTItemMarginV);
        }];
        
    }else{
        [self.identifierIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTMarginH);
            make.centerY.equalTo(self);
            make.width.height.equalTo(CYTAutoLayoutV(40.f));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.identifierIcon.mas_right).offset(CYTAutoLayoutH(10.f));
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(CYTItemMarginV);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }
    
    [self.dividerLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - 懒加载

- (UIImageView *)identifierIcon{
    if (!_identifierIcon) {
        _identifierIcon = [[UIImageView alloc] init];
    }
    return _identifierIcon;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:NO];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
- (UILabel *)dividerLineLabel{
    if (!_dividerLineLabel) {
        _dividerLineLabel = [UILabel dividerLineLabel];
    }
    return _dividerLineLabel;
}

- (UIView *)topBar{
    if (!_topBar) {
        _topBar = [[UIView alloc] init];
        _topBar.backgroundColor = kFFColor_bg_nor;
    }
    return _topBar;
}

- (void)setVehicleToolsModel:(CYTVehicleToolsModel *)vehicleToolsModel{
    _vehicleToolsModel = vehicleToolsModel;
    self.contentLabel.text = vehicleToolsModel.name;
    self.dividerLineLabel.hidden = vehicleToolsModel.hideDividerLine;
    self.contentLabel.textColor = vehicleToolsModel.selected ? CYTHexColor(@"#333333"):CYTHexColor(@"#B6B6B6");
    NSString *imaegName = [NSString string];
    if (vehicleToolsModel.addItem) {
        imaegName = vehicleToolsModel.imageName;
    }else{
        imaegName = vehicleToolsModel.selected ? @"selected":@"unselected";
    }
    self.identifierIcon.image = [UIImage imageNamed:imaegName];
}


@end
