//
//  CYTAddressChooseHeaderView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressChooseHeaderView.h"

#define kItemWidth  (CYTAutoLayoutH(110))
#define kItemHeight (CYTAutoLayoutV(50))

@interface CYTAddressChooseHeaderView ()
@property (nonatomic, strong) NSArray *itemTitleArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation CYTAddressChooseHeaderView

- (void)ff_initWithViewModel:(id)viewModel {
    self.backgroundColor = kFFColor_bg_nor;
    self.itemTitleArray = @[@"全国",@"东区",@"南区",@"西区",@"北区"];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.areaHeader];
    [self addSubview:self.areaView];
    [self addSubview:self.cityHeader];
    
    [self.areaHeader makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(100));
    }];
    [self.areaView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.areaHeader.bottom);
        make.bottom.equalTo(self.cityHeader.top);
        make.height.equalTo(CYTAutoLayoutV(100));
    }];
    [self.cityHeader makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(100));
    }];
}

- (void)setNeedArea:(BOOL)needArea {
    _needArea = needArea;
    
    if (!needArea) {
        self.areaHeader.hidden = YES;
        self.areaView.hidden = YES;
        [self.areaHeader updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
        [self.areaView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }else {
        self.areaHeader.hidden = NO;
        self.areaView.hidden = NO;
        [self.areaHeader updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(CYTAutoLayoutV(100));
        }];
        [self.areaView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(CYTAutoLayoutV(100));
        }];
    }
    
    [self setNeedsUpdateConstraints];
    [self layoutIfNeeded];
}

- (void)setIndex:(NSInteger)index {
    for (int i=0; i<self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        [button setTitleColor:kFFColor_title_L2 forState:UIControlStateNormal];
        if (index == [self getAreaIdWithIndex:i]) {
            [button setTitleColor:kFFColor_green forState:UIControlStateNormal];
        }
    }
}

- (NSInteger)getAreaIdWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return 0;
        case 1:
            return 3;
        case 2:
            return 2;
        case 3:
            return 4;
        case 4:
            return 1;
        default:
            break;
    }
    return 0;
}

#pragma mark- get
- (UIView *)areaView {
    if (!_areaView) {
        _areaView = [UIView new];
        _areaView.backgroundColor = [UIColor whiteColor];
        _buttonArray = [NSMutableArray array];
        
        float space = (kScreenWidth-2*CYTAutoLayoutH(30)-5*kItemWidth)/4.0;
        UIView *lastView;
        for (int i=0; i<self.itemTitleArray.count; i++) {
            UIButton *itemButton = [UIButton buttonWithFontPxSize:28 textColor:kFFColor_title_L2 text:self.itemTitleArray[i]];
            itemButton.tag = i;
            @weakify(self);
            [[itemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
                @strongify(self);
                if (self.areaBlock) {
                    NSInteger areaId = [self getAreaIdWithIndex:button.tag];
                    self.areaBlock(button.tag,areaId);
                }
            }];
            
            [itemButton radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
            itemButton.backgroundColor = kFFColor_bg_nor;
            [self.areaView addSubview:itemButton];
            [itemButton makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_areaView);
                make.height.equalTo(kItemHeight);
                make.width.equalTo(kItemWidth);
                if (lastView) {
                    make.left.equalTo(lastView.right).offset(space);
                }else {
                    make.left.equalTo(CYTAutoLayoutH(30));
                }
            }];
            lastView = itemButton;
            [self.buttonArray addObject:itemButton];
        }
    }
    return _areaView;
}

- (FFSectionHeadView_style0 *)areaHeader {
    if (!_areaHeader) {
        _areaHeader = [FFSectionHeadView_style0 new];
        _areaHeader.topOffset = CYTItemMarginV;
        _areaHeader.ffServeNameLabel.text = @"选择大区";
        _areaHeader.ffMoreLabel.text = @"查看区域划分";
        _areaHeader.ffMoreLabel.textColor = kFFColor_title_L2;
        @weakify(self);
        [_areaHeader setFfClickedBlock:^(id view) {
            @strongify(self);
            if (self.reaviewBlock) {
                self.reaviewBlock();
            }
        }];
    }
    return _areaHeader;
}

- (FFSectionHeadView_style0 *)cityHeader {
    if (!_cityHeader) {
        _cityHeader = [FFSectionHeadView_style0 new];
        _cityHeader.ffMoreImageView.hidden = YES;
        _cityHeader.topOffset = CYTItemMarginV;
        _cityHeader.ffServeNameLabel.text = @"选择省市";
        _cityHeader.ffMoreLabel.text = @"";
    }
    return _cityHeader;
}

@end
