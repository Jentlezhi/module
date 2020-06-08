//
//  CYTExchangeCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExchangeCell.h"
#import "CYTGoodsExchangeView.h"
#import "CYTGoodsModel.h"

@interface CYTExchangeCell()
/** 物流抵用券1 */
@property(strong, nonatomic) CYTGoodsExchangeView *goodsExchangeView0;
/** 物流抵用券2 */
@property(strong, nonatomic) CYTGoodsExchangeView *goodsExchangeView1;
@end

@implementation CYTExchangeCell

- (void)initSubComponents{
    [self.contentView addSubview:self.goodsExchangeView0];
    [self.contentView addSubview:self.goodsExchangeView1];
}

- (void)makeSubConstrains{
    [self.goodsExchangeView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.contentView);
        make.width.equalTo((kScreenWidth - 3*CYTMarginH)/2.f);
        make.height.equalTo(CYTAutoLayoutV(160.f));
        make.bottom.equalTo(-CYTItemMarginV);
    }];

    [self.goodsExchangeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsExchangeView0.mas_right).offset(CYTMarginH);
        make.top.width.height.bottom.equalTo(self.goodsExchangeView0);
    }];
}

#pragma mark - 懒加载
- (CYTGoodsExchangeView *)goodsExchangeView0{
    if (!_goodsExchangeView0) {
        _goodsExchangeView0 = CYTGoodsExchangeView.new;
        _goodsExchangeView0.hidden = YES;
        CYTWeakSelf
        _goodsExchangeView0.exchangeCallback = ^(NSString *userBitautoCoin) {
            !weakSelf.exchangeCallback?:weakSelf.exchangeCallback(userBitautoCoin);
        };
        _goodsExchangeView0.clickCallback = ^(CYTGoodsModel *goodsModel) {
            !weakSelf.clickCallback?:weakSelf.clickCallback(goodsModel);
        };
    }
    return _goodsExchangeView0;
}
- (CYTGoodsExchangeView *)goodsExchangeView1{
    if (!_goodsExchangeView1) {
        _goodsExchangeView1 = CYTGoodsExchangeView.new;
        _goodsExchangeView1.hidden = YES;
        CYTWeakSelf
        _goodsExchangeView1.exchangeCallback = ^(NSString *userBitautoCoin) {
            !weakSelf.exchangeCallback?:weakSelf.exchangeCallback(userBitautoCoin);
        };
        _goodsExchangeView1.clickCallback = ^(CYTGoodsModel *goodsModel) {
            !weakSelf.clickCallback?:weakSelf.clickCallback(goodsModel);
        };

    }
    return _goodsExchangeView1;
}

- (void)setGoodsModels:(NSArray *)goodsModels{
    if (![goodsModels isKindOfClass: [NSArray class]]) return;
    _goodsModels = goodsModels;
    self.goodsExchangeView0.hidden = !goodsModels.count;
    self.goodsExchangeView1.hidden = goodsModels.count<2;
    self.goodsExchangeView0.goodsModel = [goodsModels firstObject];
    if (goodsModels.count>=2) {
        self.goodsExchangeView1.goodsModel = [goodsModels lastObject];
    }
}

@end
