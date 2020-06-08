//
//  CYTAddressListCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressListCell.h"
#import "CYTAddressListContentView.h"
#import "CYTSetEditDeleteBarView.h"
#import "CYTAddressModel.h"

@interface CYTAddressListCell()
/** mark */
@property(weak, nonatomic) UILabel *custom;

/** 是否可编辑 */
@property(assign, nonatomic,getter=isEditAble) BOOL editAble;

@end

@implementation CYTAddressListCell
{
    //分割条
    UIView *_topBar;
    //选中标识
    UIImageView *_selectedIocn;
    //内容
    CYTAddressListContentView *_addressListContentView;
    //工具条
    CYTSetEditDeleteBarView *_setEditDeleteBarView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containToolBar:(BOOL)containToolBar{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self contactsContentBasicConfig];
        [self initContactsContentComponentsWithContainToolBar:containToolBar];
        [self makeConstrainsWithContainToolBar:containToolBar];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)contactsContentBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initContactsContentComponentsWithContainToolBar:(BOOL)containToolBar{
    //是否可编辑
    self.editAble = containToolBar;
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = CYTHexColor(@"#f2f2f2");
    [self.contentView addSubview:topBar];
    _topBar = topBar;
    
    //选中标识
    UIImageView *selectedIocn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selected"]];
    selectedIocn.hidden = YES;
    [self.contentView addSubview:selectedIocn];
    _selectedIocn = selectedIocn;

    //内容
    CYTAddressListContentView *addressListContentView = [[CYTAddressListContentView alloc] init];
    addressListContentView.showDefaultIcon = !containToolBar;
    [self.contentView addSubview:addressListContentView];
    _addressListContentView = addressListContentView;
    //工具条
    CYTSetEditDeleteBarView *setEditDeleteBarView = [[CYTSetEditDeleteBarView alloc] init];
    setEditDeleteBarView.setDefault = ^{
        !self.defaultSetBlock?:self.defaultSetBlock();
    };
    setEditDeleteBarView.editOperation = ^{
        !self.editBlock?:self.editBlock();
    };
    setEditDeleteBarView.deleteOperation = ^{
        !self.deleteBlock?:self.deleteBlock();
    };
    [self.contentView addSubview:setEditDeleteBarView];
    _setEditDeleteBarView = setEditDeleteBarView;
    
    //选择模式下隐藏工具条
    _setEditDeleteBarView.hidden = !containToolBar;
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithContainToolBar:(BOOL)containToolBar{
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [_addressListContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom);
        make.left.right.equalTo(self.contentView);
        if (!containToolBar) {
            make.bottom.equalTo(self.contentView);
        }
    }];

    if (!containToolBar) return;
    [_setEditDeleteBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressListContentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(80.f));
        make.bottom.equalTo(self.contentView);
    }];
}

+ (instancetype)addressListCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath containToolBar:(BOOL)containToolBar{
    static NSString *identifier = @"CYTAddressListCell";
    CYTAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTAddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier containToolBar:containToolBar];
    }
    return cell;
}

- (void)setAddressModel:(CYTAddressModel *)addressModel{
    _addressModel = addressModel;
    _setEditDeleteBarView.defaultTitle = @"默认地址";
    _addressListContentView.addressModel = addressModel;
    _setEditDeleteBarView.addressModel = addressModel;
    [self relayoutUIWithAddressModel:addressModel];
}
/**
 * 重新布局
 */
- (void)relayoutUIWithAddressModel:(CYTAddressModel *)addressModel{
    if (addressModel.hasSelected) {
        _selectedIocn.hidden = NO;
        [_selectedIocn remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(CYTMarginH);
            make.width.height.equalTo(CYTAutoLayoutV(40.f));
        }];
        
        [_addressListContentView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topBar.mas_bottom);
            make.left.equalTo(_selectedIocn.mas_left).offset(CYTMarginH);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }else{
        _selectedIocn.hidden = YES;
        [_addressListContentView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topBar.mas_bottom);
            make.left.right.equalTo(self.contentView);
            if (!self.isEditAble) {
                make.bottom.equalTo(self.contentView);
            }
        }];
    }
    

}


@end
