//
//  CYTOrderExtendListCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  CYTCarConfirmListCell

#import "CYTCarConfirmListCell.h"
#import "CYTConfirmSendCarModel.h"


@interface CYTCarConfirmListCell()

/** 箭头 */
@property(weak, nonatomic) UIImageView *arrowImageView;
/** 标题 */
@property(weak, nonatomic) UILabel *titleLabel;
/** 内容 */
@property(weak, nonatomic) UILabel *contentLabel;
/** 占位符 */
@property(weak, nonatomic) UILabel *placeholderLabel;
/** 输入框 */
@property(weak, nonatomic) UITextField *inputTF;
/** 分割线 */
@property(weak, nonatomic) UILabel *lineLabel;

@end

@implementation CYTCarConfirmListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self carConfirmListBasicConfig];
        [self initCarConfirmListComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)carConfirmListBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initCarConfirmListComponents{
    //标题
    UILabel *titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //内容
    UILabel *contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    
    //占位符
    UILabel *placeholderLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    [self.contentView addSubview:placeholderLabel];
    _placeholderLabel = placeholderLabel;
    
    //箭头
    UIImageView *arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    [self.contentView addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    //输入框
    UITextField *inputTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#666666") fontPixel:26.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeWhileEditing placeholder:nil];
    [inputTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    inputTF.hidden = YES;
    [self.contentView addSubview:inputTF];
    _inputTF = inputTF;
    
    //分割线
    UILabel *lineLabel = [UILabel dividerLineLabel];
    [self.contentView addSubview:lineLabel];
    _lineLabel = lineLabel;
    
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTMarginH);
        make.left.equalTo(CYTMarginH);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(_titleLabel);
    }];
    
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_titleLabel.mas_right).offset(CYTItemMarginH);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)textChanged:(UITextField *)textField{
    _confirmSendCarModel.inputContent = textField.text;
}

+ (instancetype)celllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTCarConfirmListCell";
    CYTCarConfirmListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCarConfirmListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setConfirmSendCarModel:(CYTConfirmSendCarModel *)confirmSendCarModel{
    _confirmSendCarModel = confirmSendCarModel;
    [self setValueWithConfirmSendCarModel:confirmSendCarModel];
    [self layoutWithConfirmSendCarModel:confirmSendCarModel];
}

- (void)setValueWithConfirmSendCarModel:(CYTConfirmSendCarModel *)confirmSendCarModel{
    self.titleLabel.text = confirmSendCarModel.title;
    self.contentLabel.text = confirmSendCarModel.content;
    self.placeholderLabel.text = confirmSendCarModel.placeHolder;
    self.inputTF.placeholder = confirmSendCarModel.placeHolder;
    self.inputTF.keyboardType = confirmSendCarModel.keyboardType;
    
    //最大字数限制
    NSInteger maxInputWord  = confirmSendCarModel.maxInputWord;
    if (confirmSendCarModel.showTextField) {
        [self.inputTF.rac_textSignal subscribeNext:^(NSString *inputString) {
            if (inputString.length > maxInputWord) {
                self.inputTF.text = [inputString substringToIndex:maxInputWord];
                _confirmSendCarModel.inputContent = self.inputTF.text;
            }
        }];
    }
}

- (void)layoutWithConfirmSendCarModel:(CYTConfirmSendCarModel *)confirmSendCarModel{
    BOOL hasContent = confirmSendCarModel.content.length;
    self.placeholderLabel.hidden = hasContent || confirmSendCarModel.showTextField;
    self.arrowImageView.hidden = !confirmSendCarModel.showArrow;
    self.lineLabel.hidden = !confirmSendCarModel.showDividerLine;
    self.inputTF.hidden = !confirmSendCarModel.showTextField;
    self.contentLabel.hidden = confirmSendCarModel.showTextField;
    if (confirmSendCarModel.showArrow) {
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.mas_left);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(CYTItemMarginH);
            make.top.equalTo(self.titleLabel).offset(0.5f);
            make.bottom.equalTo(-CYTMarginV);
        }];
        [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.mas_left);
            make.top.equalTo(self.titleLabel).offset(0.5f);
            make.bottom.equalTo(-CYTMarginV);
        }];
    }else{
        if (!confirmSendCarModel.showTextField) {
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-CYTMarginH);
                make.left.greaterThanOrEqualTo(_titleLabel.mas_right).offset(CYTItemMarginH);
                make.top.equalTo(self.titleLabel).offset(0.5f);
                make.bottom.equalTo(-CYTMarginV);
            }];
            [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-CYTMarginH);
                make.top.equalTo(self.titleLabel).offset(0.5f);
                make.bottom.equalTo(-CYTMarginV);
            }];
        }

    }
    
    
}

@end
