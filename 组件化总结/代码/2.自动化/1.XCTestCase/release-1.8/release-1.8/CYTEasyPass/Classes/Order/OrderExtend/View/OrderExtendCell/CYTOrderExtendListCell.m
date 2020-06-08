//
//  CYTOrderExtendListCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderExtendListCell.h"
#import "CYTOrderExtendItemModel.h"


#define marginWH CYTAutoLayoutH(20)

NSString *const kInputReasonKey = @"kInputReasonKey";

@interface CYTOrderExtendListCell()

/** 选中标识 */
@property(strong, nonatomic) UIImageView *identifierIcon;
/** 内容 */
@property(strong, nonatomic) UILabel *contentLabel;
/** 分割线 */
@property(strong, nonatomic) UILabel *lineLabel;
/** 输入框 */
@property(weak, nonatomic) UITextField *inputTF;

@end

@implementation CYTOrderExtendListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cancelReasonCellBasicConfig];
        [self initCancelReasonCellComponents];
        [self makeConstraints];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)cancelReasonCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - 懒加载

-  (UIImageView *)identifierIcon{
    if (!_identifierIcon) {
        _identifierIcon = [UIImageView ff_imageViewWithImageName:@"unselected"];
    }
    return _identifierIcon;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [UILabel dividerLineLabel];
    }
    return _lineLabel;
}

- (UITextField *)inputTF{
    if (!_inputTF) {
        _inputTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#333333") fontPixel:28.f textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeNever placeholder:@"请输入其他情况 ..."];
        [_inputTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _inputTF.hidden = YES;
    }
    return _inputTF;
}

/**
 *  初始化子控件
 */
- (void)initCancelReasonCellComponents{
    //标识
    [self.contentView addSubview:self.identifierIcon];
    //内容
    [self.contentView addSubview:self.contentLabel];
    //分割线
    [self.contentView addSubview:self.lineLabel];
    //输入框
    [self.contentView addSubview:self.inputTF];
}

- (void)makeConstraints{
    CGFloat marginV = CYTAutoLayoutV(25.f);
    [self.identifierIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(marginV);
        make.left.equalTo(CYTMarginH);
        make.width.height.equalTo(CYTAutoLayoutV(40.f));
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(self.contentLabel.mas_bottom).offset(CYTMarginV);
    }];
}

+ (instancetype)celllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTOrderExtendListCell";
    CYTOrderExtendListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTOrderExtendListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)textChanged:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderExtendInputKey object:textField.text];
    self.orderExtendItemModel.inputContent = textField.text;
}

- (void)setOrderExtendItemModel:(CYTOrderExtendItemModel *)orderExtendItemModel{
    _orderExtendItemModel = orderExtendItemModel;
    [self setValueWithOrderExtendItemModel:orderExtendItemModel];
    [self layoutWithOrderExtendItemModel:orderExtendItemModel];
}

- (void)setValueWithOrderExtendItemModel:(CYTOrderExtendItemModel *)orderExtendItemModel{
    _contentLabel.text = orderExtendItemModel.content;
    _contentLabel.textColor = orderExtendItemModel.customHasSelect?CYTHexColor(@"#333333"):CYTHexColor(@"#B6B6B6");
    _identifierIcon.image = [UIImage imageNamed:orderExtendItemModel.customHasSelect ? @"selected" : @"unselected"];
}

- (void)layoutWithOrderExtendItemModel:(CYTOrderExtendItemModel *)orderExtendItemModel{
    self.lineLabel.hidden = orderExtendItemModel.customLast&&!orderExtendItemModel.customHasSelect;
    if (orderExtendItemModel.customLast && orderExtendItemModel.customHasSelect) {
        self.inputTF.hidden = NO;
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.identifierIcon);
            make.left.equalTo(self.identifierIcon.mas_right).offset(CYTItemMarginH);
            make.right.equalTo(-CYTMarginH);
        }];

        [self.inputTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel);
            make.right.equalTo(-CYTMarginH);
            make.top.equalTo(self.lineLabel.mas_bottom).offset(CYTMarginV).priorityMedium();
            make.bottom.equalTo(-CYTMarginV);
        }];
    }else{
        self.inputTF.hidden = YES;
        orderExtendItemModel.inputContent = nil;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.identifierIcon);
            make.left.equalTo(self.identifierIcon.mas_right).offset(CYTItemMarginH);
            make.right.equalTo(-CYTMarginH);
            make.bottom.equalTo(-CYTMarginV);
        }];
    }
}


@end
