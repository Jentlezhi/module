//
//  CYTCompleteUserInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCompleteUserInfoCell.h"
#import "CYTCompleteInfoItemModel.h"

@implementation CYTCompleteUserInfoCell
{
    //标题
    UILabel *_titleLabel;
    //内容
    UILabel *_contentLabel;
    //头像
    UIImageView *_headerImageView;
    //箭头
    UIImageView *_arrowImageView;
    //输入框
    UITextField *_inputTF;
    //分割线
    UILabel *_lineLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self completeUserInfoBasicConfig];
        [self initCompleteUserInfoComponents];
        [self makeConstrains];
        [self handelTextField];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)completeUserInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
/**
 *  初始化子控件
 */
- (void)initCompleteUserInfoComponents{
    //标题
    UILabel *titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //内容
    UILabel *contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    
    //头像
    UIImageView *headerImageView = [UIImageView imageViewWithImage:kPlaceholderHeaderImage];
    [self.contentView addSubview:headerImageView];
    _headerImageView = headerImageView;
    
    //箭头
    UIImageView *arrowImageView = [UIImageView imageViewWithImageName:@"arrow_right"];
    [self.contentView addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    //输入框
    UITextField *inputTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#666666") fontPixel:28.f textAlignment:NSTextAlignmentRight keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeWhileEditing placeholder:nil];
    [inputTF setValue:CYTHexColor(@"#B6B6B6") forKeyPath:@"_placeholderLabel.textColor"];
    inputTF.hidden = YES;
    [self.contentView addSubview:inputTF];
    [inputTF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    _inputTF = inputTF;
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self.contentView addSubview:lineLabel];
    _lineLabel = lineLabel;

    
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTMarginV);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.left.greaterThanOrEqualTo(_titleLabel.mas_right).offset(CYTItemMarginH);
        make.top.equalTo(_titleLabel);
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(-CYTMarginH);
    }];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(70.f));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(_arrowImageView.mas_left).offset(-CYTItemMarginH);
        _headerImageView.layer.cornerRadius = CYTAutoLayoutV(70.f)*0.5f;
        _headerImageView.layer.masksToBounds = YES;
    }];
    
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTAutoLayoutV(60.f));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(CYTDividerLineWH);
    }];

}

- (void)textChanged:(UITextField *)textField{
    _completeInfoItemModel.customInput = textField.text;
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    CYTCompleteUserInfoCell *cell = [[CYTCompleteUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void)setCompleteInfoItemModel:(CYTCompleteInfoItemModel *)completeInfoItemModel{
    if (!completeInfoItemModel.title) return;
    _completeInfoItemModel = completeInfoItemModel;
    //标题
    _titleLabel.text = completeInfoItemModel.title;
    //内容
    NSString *content = completeInfoItemModel.content;
    if (content.length) {
        _contentLabel.text = content;
        _contentLabel.textColor = CYTHexColor(@"#666666");
    }else{
        _contentLabel.text = completeInfoItemModel.placeHolder;
        _contentLabel.textColor = CYTHexColor(@"#B6B6B6");
    }
    
    //输入框
    _inputTF.placeholder = completeInfoItemModel.placeHolder;
    
    //头像
    if (completeInfoItemModel.showHeader && completeInfoItemModel.headerImage) {
        _headerImageView.image = completeInfoItemModel.headerImage;
    }
    
    
    [self layoutViewsWithModel:completeInfoItemModel];
}
/**
 *  重新布局子控件
 */
- (void)layoutViewsWithModel:(CYTCompleteInfoItemModel *)completeInfoItemModel{
    //内容
    _contentLabel.hidden = completeInfoItemModel.showTextField;
    
    if (completeInfoItemModel.showIndicator) {
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(_titleLabel.mas_right).offset(CYTItemMarginH);
            make.top.equalTo(_titleLabel);
            make.right.equalTo(_arrowImageView.mas_left).offset(-CYTItemMarginH);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }
    
    //头像
    _headerImageView.hidden = !completeInfoItemModel.showHeader;
    
    //箭头
    _arrowImageView.hidden = !completeInfoItemModel.showIndicator;
    
    //输入框
    _inputTF.hidden = !completeInfoItemModel.showTextField;
    
    //分割线
    _lineLabel.hidden = completeInfoItemModel.hiddeDividerLine;
}
/**
 *  处理输入框
 */
- (void)handelTextField{
    //限制输入位数
    [_inputTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTNameLengthMax) {
            _inputTF.text = [inputString substringToIndex:CYTNameLengthMax];
        }
    }];
}

@end
