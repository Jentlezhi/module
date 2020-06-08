//
//  CYTSeekCarNeedPublishCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarNeedPublishCell.h"
#import "CYTSeekCarPublishItemModel.h"

@interface CYTSeekCarNeedPublishCell()

/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 内容 */
@property(strong, nonatomic) UILabel *contentLabel;
/** 次内容 */
@property(strong, nonatomic) UILabel *subContentLabel;
/** 占位 */
@property(strong, nonatomic) UILabel *placeholderLabel;
/** 箭头 */
@property(strong, nonatomic) UIImageView *arrowImageView;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;

@end

@implementation CYTSeekCarNeedPublishCell

- (void)initSubComponents{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.subContentLabel];
    [self.contentView addSubview:self.placeholderLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.dividerLine];
    
    
    //测试数据
//    self.titleLabel.text = @"配置";
//    self.contentLabel.text = @"晒哈还是";
//    self.subContentLabel.text = @"超级厉害";
//    self.placeholderLabel.text = @"请选择";
}

- (void)makeSubConstrains{
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(CYTDividerLineWH);
    }];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    }
    return _contentLabel;
}
- (UILabel *)subContentLabel{
    if (!_subContentLabel) {
        _subContentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _subContentLabel;
}
- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentRight fontPixel:26.f setContentPriority:NO];
    }
    return _placeholderLabel;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    }
    return _arrowImageView;
}

- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}


- (void)setSeekCarPublishItemModel:(CYTSeekCarPublishItemModel *)seekCarPublishItemModel{
    _seekCarPublishItemModel  = seekCarPublishItemModel;
    [self setValueWithSeekCarPublishItemModel:seekCarPublishItemModel];
    [self layoutWithSeekCarPublishItemModel:seekCarPublishItemModel];
}

- (void)setValueWithSeekCarPublishItemModel:(CYTSeekCarPublishItemModel *)seekCarPublishItemModel{
    self.titleLabel.text = seekCarPublishItemModel.title;
    self.contentLabel.text = seekCarPublishItemModel.content;
    self.subContentLabel.text = seekCarPublishItemModel.assistanceString;
    self.placeholderLabel.text = seekCarPublishItemModel.placeholder;
    self.placeholderLabel.hidden = seekCarPublishItemModel.content.length||seekCarPublishItemModel.assistanceString.length;
    self.arrowImageView.hidden = seekCarPublishItemModel.hideArrow;
    self.contentLabel.textColor = seekCarPublishItemModel.contentColor?seekCarPublishItemModel.contentColor:CYTHexColor(@"#333333");
    self.subContentLabel.textColor = seekCarPublishItemModel.subContentColor?seekCarPublishItemModel.subContentColor:CYTHexColor(@"#333333");
}
- (void)layoutWithSeekCarPublishItemModel:(CYTSeekCarPublishItemModel *)seekCarPublishItemModel{
    if (seekCarPublishItemModel.assistanceString.length) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTMarginH);
            make.top.equalTo(CYTMarginV);
        }];
        [self.subContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(CYTAutoLayoutV(10.f));
            make.right.equalTo(self.arrowImageView.mas_left);
            make.bottom.equalTo(-CYTItemMarginH);
        }];
    }else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTMarginH);
            make.top.equalTo(CYTItemMarginH);
            make.bottom.equalTo(-CYTItemMarginH);
        }];
    }
    if (seekCarPublishItemModel.hideArrow) {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(CYTAutoLayoutH(10.f));
            make.right.equalTo(-CYTItemMarginH);
            make.centerY.equalTo(self.titleLabel);
        }];
    }else{
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(CYTAutoLayoutH(10.f));
            make.right.equalTo(self.arrowImageView.mas_left);
            make.centerY.equalTo(self.titleLabel);
        }];
    }
}
@end
