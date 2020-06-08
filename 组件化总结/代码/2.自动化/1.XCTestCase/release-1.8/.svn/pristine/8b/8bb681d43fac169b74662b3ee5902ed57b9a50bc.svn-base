//
//  CYTDealerAuthInfoCellView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerAuthInfoCellView.h"

@implementation CYTDealerAuthInfoCellView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.idButton];
    [self addSubview:self.businessButton];
    [self addSubview:self.entityButton];
    
    [self.idButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(45));
        make.centerY.equalTo(self);
    }];
    [self.businessButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.idButton.right).offset(CYTAutoLayoutH(50));
        make.centerY.equalTo(self);
    }];
    [self.entityButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessButton.right).offset(CYTAutoLayoutH(50));
        make.centerY.equalTo(self);
    }];
}

- (void)setModel:(CYTDealerHomeAuthInfoModel *)model {
    _model = model;
    self.idButton.enabled = model.isIdCardAuth;
    self.businessButton.enabled = model.isBusinessLicenseAuth;
    self.entityButton.enabled = model.isStoreAuth;
}

#pragma mark- get
- (UIButton *)idButton {
    if (!_idButton) {
        _idButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_idButton setTitle:@"  身份认证" forState:UIControlStateNormal];
        _idButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_idButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        [_idButton setTitleColor:kFFColor_title_L3 forState:UIControlStateDisabled];
        [_idButton setImage:[UIImage imageNamed:@"dealer_auth_id_nor"] forState:UIControlStateNormal];
        [_idButton setImage:[UIImage imageNamed:@"dealer_auth_id_gray"] forState:UIControlStateDisabled];
        _idButton.userInteractionEnabled = NO;
    }
    return _idButton;
}

- (UIButton *)businessButton {
    if (!_businessButton) {
        _businessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_businessButton setTitle:@"  营业执照" forState:UIControlStateNormal];
        _businessButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_businessButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        [_businessButton setTitleColor:kFFColor_title_L3 forState:UIControlStateDisabled];
        [_businessButton setImage:[UIImage imageNamed:@"dealer_auth_bu_nor"] forState:UIControlStateNormal];
        [_businessButton setImage:[UIImage imageNamed:@"dealer_auth_bu_gray"] forState:UIControlStateDisabled];
        _businessButton.userInteractionEnabled = NO;
    }
    return _businessButton;
}

- (UIButton *)entityButton {
    if (!_entityButton) {
        _entityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_entityButton setTitle:@"  实体店" forState:UIControlStateNormal];
        _entityButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_entityButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        [_entityButton setTitleColor:kFFColor_title_L3 forState:UIControlStateDisabled];
        [_entityButton setImage:[UIImage imageNamed:@"dealer_auth_entity_nor"] forState:UIControlStateNormal];
        [_entityButton setImage:[UIImage imageNamed:@"dealer_auth_entity_gray"] forState:UIControlStateDisabled];
        _entityButton.userInteractionEnabled = NO;
    }
    return _entityButton;
}

@end
