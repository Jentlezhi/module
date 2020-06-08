//
//  CYTDealerHomeCarFriendsCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerHomeCarFriendsCell.h"

@interface CYTDealerHomeCarFriendsCell()
@property (nonatomic, assign) BOOL showImage;

@end

@implementation CYTDealerHomeCarFriendsCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.thumImageView,self.contentLab,self.numLab];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.thumImageView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ffContentView).offset(CYTItemMarginV);
        make.left.equalTo(CYTAutoLayoutH(30));
        make.width.height.equalTo(CYTAutoLayoutH(140));
        make.bottom.lessThanOrEqualTo(-CYTItemMarginV);
    }];
    [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thumImageView);
        make.left.equalTo(CYTAutoLayoutH(190));
        make.right.lessThanOrEqualTo(-CYTItemMarginH);
        make.bottom.lessThanOrEqualTo(-CYTAutoLayoutV(25));
    }];
    [self.numLab updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.thumImageView).offset(-CYTAutoLayoutV(10));
        make.left.equalTo(self.thumImageView.right).offset(CYTItemMarginH);
    }];
    
    if (self.showImage) {
        //有图片
        [self.thumImageView updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(CYTAutoLayoutH(140));
        }];
        [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTAutoLayoutH(190));
        }];
        self.contentLab.numberOfLines = 2;
    }else {
        //没有图片
        [self.thumImageView updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(0);
        }];
        [self.contentLab updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTAutoLayoutH(20));
        }];
        self.contentLab.numberOfLines = 3;
    }
    
    [super updateConstraints];
}

- (void)setModel:(CYTDealerHomeCarFriendsModel *)model {
    _model = model;
    
    self.contentLab.text = model.content;
    self.thumImageView.hidden = !(model.imageCount.integerValue >0);
    self.numLab.hidden = !(model.imageCount.integerValue >0);
    self.showImage = (model.imageCount.integerValue>0);
    if (self.showImage) {
        NSString *url = (model.imageUrls.count>0)?model.imageUrls[0]:nil;
        [self.thumImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:kPlaceholderImage];
        self.numLab.text = [NSString stringWithFormat:@"%@张",self.model.imageCount];
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark- get
- (UIImageView *)thumImageView {
    if (!_thumImageView) {
        _thumImageView = [UIImageView ff_imageViewWithImageName:nil];
        _thumImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_thumImageView radius:1 borderWidth:0.5 borderColor:[UIColor clearColor]];
    }
    return _thumImageView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
        _contentLab.numberOfLines = 2;
    }
    return _contentLab;
}

- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L3];
    }
    return _numLab;
}

@end
