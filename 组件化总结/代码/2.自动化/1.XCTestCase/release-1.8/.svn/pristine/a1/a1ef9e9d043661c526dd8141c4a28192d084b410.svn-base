//
//  CYTCarDealerChartCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarDealerChartCell.h"

@interface CYTCarDealerChartCell ()
@property (nonatomic, strong) NSArray *sortImageArray;
@property (nonatomic, strong) NSArray *sortShadowImageArray;

@end

@implementation CYTCarDealerChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark- flow control

///cell加载子视图
- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    self.sortImageArray = @[@"discover_first_nor",@"discover_second_nor",@"discover_third_nor"];
    self.sortShadowImageArray = @[@"discover_first_shadow",@"discover_second_shadow",@"discover_third_shadow"];
    
    NSArray *views = @[self.bgImageView,self.sortLabel,self.sortImageView,self.headImageView,self.nameLabel,self.assistanceLabel];
    block(views,^{
        self.bottomLeftOffset = CYTAutoLayoutH(100);
        self.bottomRightOffset = -CYTItemMarginH;
        self.bottomHeight = 0.5;
        self.ffTopLineColor = kFFColor_bg_nor;
        [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    });
}

///cell布局
- (void)updateConstraints {
    [self.bgImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.sortLabel updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ffContentView.left).offset(CYTAutoLayoutH(50));
        make.centerY.equalTo(0);
    }];
    [self.sortImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ffContentView.left).offset(CYTAutoLayoutH(50));
        make.centerY.equalTo(0);
        make.width.height.equalTo(CYTAutoLayoutH(80));
    }];
    [self.headImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(CYTAutoLayoutH(100));
        make.width.height.equalTo(CYTAutoLayoutH(88));
    }];
    [self.nameLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.right).offset(CYTItemMarginH);
        make.top.bottom.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(120));
    }];
    [self.assistanceLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.nameLabel.right).offset(CYTItemMarginH);
        make.centerY.equalTo(0);
        make.right.equalTo(-CYTMarginH);
    }];
    
    [super updateConstraints];
}

///自定义cell样式
- (void)setFfCustomizeCellModel:(FFExtendTableViewCellModel *)ffCustomizeCellModel {
    if (ffCustomizeCellModel.ffIndexPath.row==0 || ffCustomizeCellModel.ffIndexPath.row==3) {
        self.topHeight = CYTItemMarginH;
    }else {
        self.topHeight = 0;
    }
    
    //判断是第一、二、三名
    if (ffCustomizeCellModel.ffIndexPath.row==0 || ffCustomizeCellModel.ffIndexPath.row==1 || ffCustomizeCellModel.ffIndexPath.row==2) {
        //使用图片
        self.sortLabel.hidden = YES;
        self.sortImageView.hidden = NO;
    }else {
        //使用数字
        self.sortLabel.hidden = NO;
        self.sortImageView.hidden = YES;
    }
}

#pragma mark- api

#pragma mark- method
- (NSString *)sortImageNameWithModel:(CYTCarDealerChartItemModel *)model {
    if (model.rankingId <=3) {
        //排名前三
        NSString *sortImage;
        if (model.userId == [CYTUserId integerValue]) {
            //我
            sortImage = self.sortShadowImageArray[model.rankingId-1];
        }else {
            sortImage = self.sortImageArray[model.rankingId-1];
        }
        return sortImage;
    }else {
        return @"";
    }
}

#pragma mark- set
///cell赋值
- (void)setFfModel:(id)ffModel {
    self.model = ffModel;
}

- (void)setModel:(CYTCarDealerChartItemModel *)model {
    _model = model;
    
    self.sortLabel.text = [NSString stringWithFormat:@"%ld",model.rankingId];
    NSString *assistant = [NSString stringWithFormat:@"%ld",model.count];
    assistant = (self.type == CarDealerChartTypeSales)?[NSString stringWithFormat:@"%@ 辆",assistant]:[NSString stringWithFormat:@"%@ 条",assistant];
    self.assistanceLabel.text = assistant;
    [self.headImageView.bubbleButton sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"dealer_basic_head"]];
    self.sortImageView.image = [UIImage imageNamed:[self sortImageNameWithModel:model]];
    
    BOOL isMe = ([CYTUserId integerValue]==model.userId);
    self.nameLabel.text = (isMe)?@"我":model.userName;
    self.bgImageView.hidden = !isMe;
    self.sortLabel.textColor = isMe?[UIColor whiteColor]:kFFColor_title_L2;
    self.nameLabel.textColor = isMe?[UIColor whiteColor]:kFFColor_title_L1;
    self.assistanceLabel.textColor = isMe?[UIColor whiteColor]:kFFColor_title_L1;
}

#pragma mark- get
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView ff_imageViewWithImageName:@"discover_chartLine"];
        _bgImageView.contentMode = UIViewContentModeScaleToFill;
        _bgImageView.hidden = YES;
    }
    return _bgImageView;
}

- (UILabel *)sortLabel {
    if (!_sortLabel) {
        _sortLabel = [UILabel labelWithFontPxSize:34 textColor:kFFColor_title_L2];
        _sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortLabel;
}

- (UIImageView *)sortImageView {
    if (!_sortImageView) {
        _sortImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _sortImageView;
}

- (FFBubbleView *)headImageView {
    if (!_headImageView) {
        _headImageView = [FFBubbleView new];
        [_headImageView radius:CYTAutoLayoutH(44) borderWidth:2 borderColor:[UIColor whiteColor]];
        [_headImageView.bubbleButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        _headImageView.bubbleButton.backgroundColor = [UIColor whiteColor];
        _headImageView.userInteractionEnabled = NO;
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _nameLabel;
}

- (UILabel *)assistanceLabel {
    if (!_assistanceLabel) {
        _assistanceLabel = [UILabel labelWithFontPxSize:30 textColor:kFFColor_title_L1];
    }
    return _assistanceLabel;
}

@end
