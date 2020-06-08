//
//  CYTContactsContentCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTContactsContentCell.h"
#import "CYTContactsContentView.h"
#import "CYTSetEditDeleteBarView.h"

@interface CYTContactsContentCell()
/** mark */
@property(weak, nonatomic) UILabel *custom;
@end

@implementation CYTContactsContentCell
{
    //分割条
    UIView *_topBar;
    //内容
    CYTContactsContentView *_contactsContentView;
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
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self.contentView addSubview:topBar];
    _topBar = topBar;

    //内容
    CYTContactsContentView *contactsContentView = [[CYTContactsContentView alloc] init];
    //选择模式显示默认标识
    contactsContentView.showDefaultIcon = !containToolBar;
    [self.contentView addSubview:contactsContentView];
    _contactsContentView = contactsContentView;
    
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
    setEditDeleteBarView.hidden = !containToolBar;
}
/**
 *  布局控件
 */
- (void)makeConstrainsWithContainToolBar:(BOOL)containToolBar{
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [_contactsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(155.f));
        if (!containToolBar) {
            make.bottom.equalTo(self.contentView);
        }
    }];
    if (!containToolBar) return;
    [_setEditDeleteBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contactsContentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(80.f));
        make.bottom.equalTo(self.contentView);
    }];
}

+ (instancetype)contactsContentCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath containToolBar:(BOOL)containToolBar{
    static NSString *identifier = @"CYTContactsContentCell";
    CYTContactsContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTContactsContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier containToolBar:containToolBar];
    }
    return cell;
}


- (void)setCarContactsModel:(CYTCarContactsModel *)carContactsModel{
    _carContactsModel = carContactsModel;
    _setEditDeleteBarView.defaultTitle = @"默认联系人";
    _contactsContentView.carContactsModel = carContactsModel;
    _setEditDeleteBarView.carContactsModel = carContactsModel;
}

@end
