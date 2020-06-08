//
//  CYTSetEditDeleteBarView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSetEditDeleteBarView.h"
#import "CYTAddressModel.h"

#import "CYTCarContactsModel.h"

#define kSelectImageName        @"selected"
#define kUnSelectImageName      @"unselected"

@interface CYTSetEditDeleteBarView()

/** 默认标识 */
@property(strong, nonatomic) UIImageView *setDefaultIcon;

/** 默认文字 */
@property(strong, nonatomic) UILabel *titleLabel;



@end

@implementation CYTSetEditDeleteBarView
{
    //默认联系人
    UIView *_defaultContactView;
    //编辑
    UIView *_editView;
    //删除
    UIView *_deleteView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setEditDeleteBarBasicConfig];
        [self initSetEditDeleteBarComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)setEditDeleteBarBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initSetEditDeleteBarComponents{
    //默认联系人
    CYTWeakSelf
    UIView *defaultContactView = [self itemWithIconImageName:kUnSelectImageName tile:nil clickBack:^{
        if (_carContactsModel.isDefault) return;
        !weakSelf.setDefault?:weakSelf.setDefault();
    }iconBack:^(UIImageView *icon) {
        _setDefaultIcon = icon;
    } titleLabelBack:^(UILabel *titleLabel) {
        _titleLabel = titleLabel;
    }];
    [self addSubview:defaultContactView];
    _defaultContactView = defaultContactView;
    
    //编辑
    UIView *editView = [self itemWithIconImageName:@"ic_edit_hl" tile:@"编辑" clickBack:^{
        !weakSelf.editOperation?:weakSelf.editOperation();
    }iconBack:nil titleLabelBack:nil];
    [self addSubview:editView];
    _editView = editView;
    //删除
    UIView *deleteView = [self itemWithIconImageName:@"ic_amputate_hl" tile:@"删除" clickBack:^{
        !weakSelf.deleteOperation?:weakSelf.deleteOperation();
    }iconBack:nil titleLabelBack:nil];
    [self addSubview:deleteView];
    _deleteView = deleteView;
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
    [_defaultContactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(CYTAutoLayoutH(30));
        make.width.equalTo(16*4+CYTAutoLayoutH(12)+CYTAutoLayoutH(30));
        make.height.equalTo(CYTAutoLayoutV(80));
    }];
    
    [_deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-CYTAutoLayoutH(30));
        make.centerY.equalTo(self);
        make.width.equalTo(16*2+CYTAutoLayoutH(12)+CYTAutoLayoutH(30));
        make.height.equalTo(_defaultContactView);
    }];

    [_editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_deleteView.mas_left).offset(-CYTAutoLayoutH(20));
        make.width.equalTo(_deleteView);
        make.height.equalTo(_defaultContactView);
    }];
}

- (UIView *)itemWithIconImageName:(NSString *)iconName tile:(NSString *)title clickBack:(void(^)())clickBlock iconBack:(void(^)(UIImageView *icon))icon titleLabelBack:(void(^)(UILabel *titleLabel))titleLabelBlock{
    UIView *itemView = [[UIView alloc] init];
    itemView.backgroundColor = [UIColor clearColor];
    //标识
    UIImageView *selectIcon = [[UIImageView alloc] init];
    !icon?:icon(selectIcon);
    selectIcon.image = [UIImage imageNamed:iconName];
    [itemView addSubview:selectIcon];
    [selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(itemView);
        make.width.height.equalTo(CYTAutoLayoutV(40));
    }];
    //文字
    UILabel *defaultLabel = [[UILabel alloc] init];
    !titleLabelBlock?:titleLabelBlock(defaultLabel);
    defaultLabel.text = title;
    defaultLabel.textAlignment = NSTextAlignmentLeft;
    defaultLabel.font = CYTFontWithPixel(24);
    defaultLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [itemView addSubview:defaultLabel];
    CGFloat defaultLabelH = defaultLabel.font.pointSize + 2;
    NSUInteger textLength = title.length == 0 ? 5:title.length;
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectIcon);
        make.left.equalTo(selectIcon.mas_right).offset(CYTAutoLayoutH(12));
        make.size.equalTo(CGSizeMake(defaultLabelH*textLength, defaultLabelH));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        !clickBlock?:clickBlock();
    }];
    [itemView addGestureRecognizer:tap];
    return itemView;
}

- (void)setCarContactsModel:(CYTCarContactsModel *)carContactsModel{
    _carContactsModel = carContactsModel;
    NSString *currentSelectIcon = [NSString string];
    currentSelectIcon = carContactsModel.isDefault?kSelectImageName:kUnSelectImageName;
    _setDefaultIcon.image = [UIImage imageNamed:currentSelectIcon];
}

- (void)setAddressModel:(CYTAddressModel *)addressModel{
    _addressModel = addressModel;
    NSString *currentSelectIcon = [NSString string];
    currentSelectIcon = addressModel.isDefault?kSelectImageName:kUnSelectImageName;
    _setDefaultIcon.image = [UIImage imageNamed:currentSelectIcon];
}

- (void)setDefaultTitle:(NSString *)defaultTitle{
    _defaultTitle = defaultTitle;
    _titleLabel.text = defaultTitle;
}

@end
