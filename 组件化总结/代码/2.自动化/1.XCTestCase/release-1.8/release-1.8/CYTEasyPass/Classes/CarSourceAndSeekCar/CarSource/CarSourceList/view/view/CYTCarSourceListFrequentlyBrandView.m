//
//  CYTCarSourceListFrequentlyBrandView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceListFrequentlyBrandView.h"
#import "UIButton+WebCache.h"

@interface CYTCarSourceListFrequentlyBrandView ()
@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation CYTCarSourceListFrequentlyBrandView

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = kFFColor_bg_nor;
    [self loadBrandItems];
    [self addSubview:self.headView];
    [self addSubview:self.scrollView];
    
    [self.headView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTItemMarginV);
        make.left.right.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(70));
    }];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(130));
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.height.equalTo(self.scrollView);
    }];
}

- (void)ff_bindViewModel {
    @weakify(self);
    [self.viewModel.refreshSubject subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadBrandItems];
            });
        }
    }];
}

- (void)reloadBrandView {
    [self.viewModel updateBrandListWithModel:nil];
    [self loadBrandItems];
}

- (void)loadBrandItems {
    NSArray *subviews = self.contentView.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    self.itemsArray = [NSMutableArray array];
    
    for (int i=0; i<self.viewModel.brandList.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[item rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.brandModelBlock) {
                self.brandModelBlock(self.viewModel.brandList[i]);
            }
        }];
        CYTBrandSelectModel *model = self.viewModel.brandList[i];
        NSString *url = model.logoUrl;
        if ([url containsString:@"http"]) {
            [item sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"img_picture_80x80"]];
        }else {
            [item setImage:[UIImage imageNamed:model.logoUrl] forState:UIControlStateNormal];
        }
        
        [item.imageView setContentMode:UIViewContentModeScaleAspectFit];
        float margin = CYTAutoLayoutH(20);
        [item setImageEdgeInsets:UIEdgeInsetsMake(margin, margin, margin, margin)];
        [self.itemsArray addObject:item];
        [self.contentView addSubview:item];
        float width = 1.0*kScreenWidth/self.viewModel.brandList.count;
        float x = i*width;
        [item makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(x);
            make.top.bottom.equalTo(0);
            make.width.equalTo(width);
            if (i==self.viewModel.brandList.count-1) {
                make.right.equalTo(0);
            }
        }];
    }
}

#pragma mark- get
- (FFSectionHeadView_style0 *)headView {
    if (!_headView) {
        _headView = [FFSectionHeadView_style0 new];
        _headView.ffMoreImageView.hidden = NO;
        _headView.ffServeNameLabel.text = @"常用品牌";
        _headView.ffMoreLabel.text = @"品牌筛选";
        @weakify(self);
        [_headView setFfClickedBlock:^(id x) {
            @strongify(self);
            if (self.brandFilterBlock) {
                self.brandFilterBlock();
            }
        }];
    }
    return _headView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (CYTCarSourceListFrequentlyBrandVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarSourceListFrequentlyBrandVM new];
    }
    return _viewModel;
}

@end
