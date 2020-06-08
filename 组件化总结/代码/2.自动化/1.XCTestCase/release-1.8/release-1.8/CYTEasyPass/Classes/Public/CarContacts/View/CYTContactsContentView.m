//
//  CYTContactsContentView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTContactsContentView.h"
#import "CYTCarContactsModel.h"

@interface CYTContactsContentView()


@end

@implementation CYTContactsContentView
{
    //姓名
    UILabel *_nameLabel;
    //电话
    UILabel *_phoneNumLabel;
    //证件类型
    UILabel *_creTypeLabel;
    //证件号码
    UILabel *_creNumLabel;
    //分割线
    UILabel *_lineLabel;
    UILabel *_defaultIcon;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self contactsContentBasicConfig];
        [self initContactsContentComponents];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)contactsContentBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initContactsContentComponents{
    //姓名
    UILabel *nameLabel = [self itemLabelWithTextAlignment:NSTextAlignmentLeft];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
//    nameLabel.text = @"张嘉译";
    //默认标识
    UILabel *defaultIcon = [UILabel labelWithText:@"默认" textColor:CYTGreenNormalColor fontPixel:24.f cornerRadius:2.f borderWidth:1.0f];
    defaultIcon.hidden = YES;
    [self addSubview:defaultIcon];
    _defaultIcon = defaultIcon;
    //电话
    UILabel *phoneNumLabel = [self itemLabelWithTextAlignment:NSTextAlignmentRight];
    [self addSubview:phoneNumLabel];
    _phoneNumLabel = phoneNumLabel;
//    phoneNumLabel.text = @"13121782105";
    
    //证件类型
    UILabel *creTypeLabel = [self itemLabelWithTextAlignment:NSTextAlignmentLeft];
    [self addSubview:creTypeLabel];
    _creTypeLabel = creTypeLabel;
//    creTypeLabel.text = @"身份证";
    
    //电话
    UILabel *creNumLabel = [self itemLabelWithTextAlignment:NSTextAlignmentRight];
    [self addSubview:creNumLabel];
    _creNumLabel = creNumLabel;
//    creNumLabel.text = @"412821199008241517";
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;

}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithSelectStyle:(BOOL)selectStyle{
    CGFloat contentLabelH = (_phoneNumLabel.font.pointSize+2);
    [_phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTAutoLayoutV(30));
        make.right.equalTo(self).offset(-CYTAutoLayoutV(30));
        make.size.equalTo(CGSizeMake(contentLabelH*11, contentLabelH));
    }];
    if (selectStyle) {
        NSString *nameAutoLayoutStr = [NSString stringWithFormat:@"%@ ",_carContactsModel.name];
        CGFloat nameW = [nameAutoLayoutStr sizeWithFont:_nameLabel.font maxSize:CGSizeMake(CGFLOAT_MAX, _nameLabel.font.pointSize)].width;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(CYTAutoLayoutH(30));
            make.top.equalTo(self).offset(CYTAutoLayoutV(30));
            make.height.equalTo(_nameLabel.font.pointSize);
            make.width.equalTo(nameW);
        }];
    }else{
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(CYTAutoLayoutH(30));
            make.right.equalTo(_phoneNumLabel).offset(-CYTAutoLayoutH(30));
            make.top.equalTo(self).offset(CYTAutoLayoutV(30));
            make.height.equalTo(_nameLabel.font.pointSize);
        }];
    }

    
    [_creNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneNumLabel.mas_bottom).offset(CYTAutoLayoutV(30));
        make.right.equalTo(_phoneNumLabel);
    }];

    [_creTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(CYTAutoLayoutV(30));
        make.right.equalTo(_creNumLabel.mas_left).offset(-CYTAutoLayoutH(20));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTAutoLayoutV(30));
        make.right.equalTo(self).offset(-CYTAutoLayoutV(30));
        make.bottom.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
    CGFloat iconH = _defaultIcon.font.pointSize+4;
    [_defaultIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).offset(CYTAutoLayoutH(10.f));
        make.width.equalTo(CGSizeMake(iconH*2, iconH));
    }];
}

- (UILabel *)itemLabelWithTextAlignment:(NSTextAlignment)TextAlignment{
    UILabel *itemLabel = [[UILabel alloc] init];
    itemLabel.textAlignment = TextAlignment;
    itemLabel.font = CYTFontWithPixel(30);
    itemLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    return itemLabel;
}

- (void)setCarContactsModel:(CYTCarContactsModel *)carContactsModel{
    _carContactsModel = carContactsModel;
    _nameLabel.text = carContactsModel.name;
    _phoneNumLabel.text = carContactsModel.phone;
    _creTypeLabel.text = carContactsModel.cerTypeName;
    _creNumLabel.text = carContactsModel.cerNumber;
    //文字布局
    [self makeConstrainsWithSelectStyle:self.showDefaultIcon];
    //默认标识
    if (self.showDefaultIcon) {
        _defaultIcon.hidden = !carContactsModel.isDefault;
    }
}

@end
