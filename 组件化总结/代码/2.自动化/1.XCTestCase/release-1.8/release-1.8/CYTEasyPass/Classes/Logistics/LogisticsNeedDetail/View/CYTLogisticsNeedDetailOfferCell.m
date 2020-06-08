//
//  CYTLogisticsNeedDetailOfferCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedDetailOfferCell.h"

#define kCompanyHeight  (18)

@implementation CYTLogisticsNeedDetailOfferCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.priceLab,self.subTitleLab,self.needTimeLab,self.transportComLab,self.starView,self.remarkLab,self.orderButton];
    block(views,^{
        self.bottomLeftOffset = CYTMarginH;
        self.bottomRightOffset = (-CYTMarginH);
        self.backgroundColor = [UIColor whiteColor];
    });
}

- (void)updateConstraints {
    [self.priceLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.subTitleLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab);
        make.top.equalTo(self.priceLab.bottom);
        make.right.lessThanOrEqualTo(self.orderButton.left).offset(10);
    }];
    [self.needTimeLab updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab);
        make.top.equalTo(self.subTitleLab.bottom).offset(CYTAutoLayoutV(20));
        
    }];
    [self.transportComLab updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.needTimeLab);
        make.left.equalTo(self.needTimeLab.right).offset(5);
        make.height.equalTo(kCompanyHeight);
    }];
    [self.remarkLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab);
        make.right.lessThanOrEqualTo(-CYTMarginH);
        make.top.equalTo(self.needTimeLab.bottom).offset(CYTItemMarginV);
        make.bottom.equalTo(-CYTAutoLayoutV(30));
    }];
    
    extern CGFloat starWidth;
    extern CGFloat starHeight;
    [self.starView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.transportComLab);
        make.left.equalTo(self.transportComLab.right).offset(CYTAutoLayoutH(10));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*5, CYTAutoLayoutV(starHeight)));
    }];
    [self.orderButton updateConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(150), CYTAutoLayoutV(50)));
        make.centerY.equalTo(self).offset(-5);
        make.right.equalTo((-CYTMarginH));
    }];
    
    [super updateConstraints];
}

- (void)handlePirce {
    NSString *price = [NSString stringWithFormat:@"%g",self.model.totalPrice];
    NSString *priceTotal = [NSString stringWithFormat:@"￥ %@ 元",price];
    NSRange range = [priceTotal rangeOfString:price];
    self.priceLab.text = priceTotal;
    [self.priceLab updateWithRange:range font:[UIFont boldSystemFontOfSize:18] color:CYTRedColor];
}

- (void)setState:(CYTLogisticsNeedStatus)state {
    _state = state;
    
    if (state == CYTLogisticsNeedStatusFinished || state == CYTLogisticsNeedStatusExpired || state == CYTLogisticsNeedStatusCancel) {
        [_orderButton radius:1 borderWidth:0.5 borderColor:kFFColor_title_L3];
        [_orderButton setTitleColor:kFFColor_title_L3 forState:UIControlStateNormal];
        _orderButton.enabled = NO;
    }else {
        [_orderButton radius:1 borderWidth:0.5 borderColor:kFFColor_green];
        [_orderButton setTitleColor:kFFColor_green forState:UIControlStateNormal];
        _orderButton.enabled = YES;
    }
}

- (void)setModel:(CYTLogisticsNeedDetailOfferModel *)model {
    _model = model;
    
    [self handlePirce];
    NSString *getCarTime = [NSString stringWithFormat:@"预计提车时间 付款后%g小时内",model.estimateStartTime];
    self.subTitleLab.text = getCarTime;
    NSString *needTime = [NSString stringWithFormat:@"预计运输时长 %g天",model.estimateTransportPeriod];
    self.needTimeLab.text = needTime;
    self.transportComLab.text = [NSString stringWithFormat:@"  %@  ",model.logisticsCompanyName];
    self.starView.starValue = [model.companyLevel floatValue];
    NSString *remarkFlag = @"物流公司备注：";
    remarkFlag = [NSString stringWithFormat:@"%@%@",remarkFlag,model.remarks];
    self.remarkLab.text = remarkFlag;
}

#pragma mark- get
- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab  = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
    }
    return _priceLab;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab  = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _subTitleLab;
}

- (UILabel *)needTimeLab {
    if (!_needTimeLab) {
        _needTimeLab  = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
    }
    return _needTimeLab;
}

- (UILabel *)transportComLab {
    if (!_transportComLab) {
        _transportComLab  = [UILabel labelWithFontPxSize:22 textColor:kFFColor_title_L1];
        [_transportComLab radius:9 borderWidth:0.5 borderColor:CYTBtnDisableColor];
    }
    return _transportComLab;
}

- (CYTStarView *)starView {
    if (!_starView) {
        _starView = [CYTStarView new];
        _starView.starTotalNum = 5;
    }
    return _starView;
}

- (UILabel *)remarkLab {
    if (!_remarkLab) {
        _remarkLab = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L2];
        _remarkLab.numberOfLines = 2;
    }
    return _remarkLab;
}

- (UIButton *)orderButton {
    if (!_orderButton) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_orderButton setTitleColor:kFFColor_green forState:UIControlStateNormal];
        [_orderButton radius:1 borderWidth:0.5 borderColor:kFFColor_green];
        _orderButton.titleLabel.font = CYTFontWithPixel(28);
        
        @weakify(self);
        [[_orderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(self.model);
            }
        }];
    }
    return _orderButton;
}

@end
