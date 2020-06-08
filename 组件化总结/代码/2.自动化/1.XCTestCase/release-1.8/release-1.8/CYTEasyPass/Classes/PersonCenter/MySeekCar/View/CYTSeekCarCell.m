//
//  CYTSeekCarCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarCell.h"
#import "CYTFindCarCommonCellView.h"
#import "UIButton+FFCommon.h"
#import "CYTSeekCarListModel.h"

@interface CYTSeekCarCell()

/** 通用view */
@property(weak, nonatomic) CYTFindCarCommonCellView *findCarCommonCellView;

/** 下架停售 */
@property(weak, nonatomic) UIButton *soldOutBtn;
@property(weak, nonatomic) UIButton *shareButton;
@property(weak, nonatomic) UIButton *refreshButton;
@property(weak, nonatomic) UIButton *editButton;

@end

@implementation CYTSeekCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self seekCarCellBasicConfig];
        [self initSeekCarCellComponents];
        [self makeConstrains];
    }
    return self;
}

/**
 *  基本配置
 */
- (void)seekCarCellBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initSeekCarCellComponents{
    //车源通用view
    CYTFindCarCommonCellView *findCarCommonCellView = [[CYTFindCarCommonCellView alloc] init];
    findCarCommonCellView.lineView.hidden = YES;
    [self.contentView addSubview:findCarCommonCellView];
    _findCarCommonCellView = findCarCommonCellView;
    
    //下架停售/重新发布
    UIButton *soldOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    soldOutBtn.titleLabel.font = CYTFontWithPixel(24.f);
    [soldOutBtn setTitleColor:CYTHexColor(@"#333333") forState:UIControlStateNormal];
    soldOutBtn.layer.cornerRadius = 2.f;
    soldOutBtn.layer.borderColor = CYTHexColor(@"#dbdbdb").CGColor;
    soldOutBtn.layer.borderWidth = 1.f;
    [self.contentView addSubview:soldOutBtn];
    _soldOutBtn = soldOutBtn;
    
    [[soldOutBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.soldOutOrRepublishClickBack?:self.soldOutOrRepublishClickBack();
    }];
    [soldOutBtn enlargeWithTop:10 left:0 bottom:10 right:0];
    
    //分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.titleLabel.font = CYTFontWithPixel(24.f);
    [shareButton setTitleColor:CYTHexColor(@"#333333") forState:UIControlStateNormal];
    shareButton.layer.cornerRadius = 2.f;
    shareButton.layer.borderColor = CYTHexColor(@"#dbdbdb").CGColor;
    shareButton.layer.borderWidth = 1.f;
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.contentView addSubview:shareButton];
    _shareButton = shareButton;
    
    [[shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.shareBlock) {
            self.shareBlock(self.seekCarListModel);
        }
    }];
    [shareButton enlargeWithTop:10 left:0 bottom:10 right:0];
    
    //刷新
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.titleLabel.font = CYTFontWithPixel(24.f);
    [refreshButton setTitleColor:CYTHexColor(@"#333333") forState:UIControlStateNormal];
    refreshButton.layer.cornerRadius = 2.f;
    refreshButton.layer.borderColor = CYTHexColor(@"#dbdbdb").CGColor;
    refreshButton.layer.borderWidth = 1.f;
    [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [self.contentView addSubview:refreshButton];
    _refreshButton = refreshButton;
    
    [[refreshButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.refreshBlock?:self.refreshBlock(self.seekCarListModel);
    }];
    [refreshButton enlargeWithTop:10 left:0 bottom:10 right:0];
    
    //编辑
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.titleLabel.font = CYTFontWithPixel(24.f);
    [editButton setTitleColor:CYTHexColor(@"#333333") forState:UIControlStateNormal];
    editButton.layer.cornerRadius = 2.f;
    editButton.layer.borderColor = CYTHexColor(@"#dbdbdb").CGColor;
    editButton.layer.borderWidth = 1.f;
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.contentView addSubview:editButton];
    _editButton = editButton;
    
    [[editButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.editBlock?:self.editBlock(self.seekCarListModel);
    }];
    [editButton enlargeWithTop:10 left:0 bottom:10 right:0];
}
/**
 *  布局控件
 */
- (void)makeConstrains{
    [_findCarCommonCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
    }];
    
    [_soldOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(140.f), CYTAutoLayoutV(40.f)));
        make.top.equalTo(_findCarCommonCellView.mas_bottom);
        make.right.equalTo(self.contentView).offset(-CYTAutoLayoutH(20.f));
        make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(20.f));
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(140.f), CYTAutoLayoutV(40.f)));
        make.top.equalTo(_findCarCommonCellView.mas_bottom);
        make.right.equalTo(self.refreshButton.left).offset(CYTAutoLayoutH(-10));
        make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(20.f));
    }];
    [_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(140.f), CYTAutoLayoutV(40.f)));
        make.top.equalTo(_findCarCommonCellView.mas_bottom);
        make.right.equalTo(self.editButton.left).offset(CYTAutoLayoutH(-10));
        make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(20.f));
    }];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(140.f), CYTAutoLayoutV(40.f)));
        make.top.equalTo(_findCarCommonCellView.mas_bottom);
        make.right.equalTo(self.soldOutBtn.left).offset(CYTAutoLayoutH(-10));
        make.bottom.equalTo(self.contentView).offset(-CYTAutoLayoutV(20.f));
    }];
}

+ (instancetype)seekCarCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTSeekCarCell";
    CYTSeekCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTSeekCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setSeekCarListModel:(CYTSeekCarListModel *)seekCarListModel{
    _seekCarListModel = seekCarListModel;
    _findCarCommonCellView.seekCarListModel = seekCarListModel;
}

- (void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    [_soldOutBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark- method
- (void)setOnSale:(BOOL)onSale {
    _onSale = onSale;
    
    self.shareButton.hidden = !onSale;
    self.refreshButton.hidden = !onSale;
    self.editButton.hidden = !onSale;
}

@end
