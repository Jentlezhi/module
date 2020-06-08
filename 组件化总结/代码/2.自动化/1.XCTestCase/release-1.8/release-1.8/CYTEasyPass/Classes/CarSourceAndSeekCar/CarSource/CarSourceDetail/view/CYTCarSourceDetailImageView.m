//
//  CYTCarSourceDetailImageView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailImageView.h"
#import "UIButton+WebCache.h"

@interface CYTCarSourceDetailImageView()
@property (nonatomic, assign) NSInteger number;

@end

@implementation CYTCarSourceDetailImageView

- (void)setUrlArray:(NSArray *)urlArray {
    _urlArray = urlArray;
    
    //展示图片数量
    self.number = (urlArray.count<4)?urlArray.count:3;
    [self loadImageView];
}

- (void)loadImageView {
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
    UIView *lastView;
    for (int i=0; i<self.number; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
        [self addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(CYTAutoLayoutH(120));
            make.top.bottom.equalTo(0);
            if (lastView) {
                make.left.equalTo(lastView.right).offset(CYTAutoLayoutH(10));
            }else{
                make.left.equalTo(0);
            }
        }];
        
        NSDictionary *dic = self.urlArray[i];
        NSURL *url = [NSURL URLWithString:[dic valueForKey:@"thumbnailUrl"]];
        [button sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"carSource_carDefault"]];
        lastView = button;
    }
    
    [lastView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}

- (void)buttonClicked:(UIButton *)button {
    if (self.selectBlock) {
        self.selectBlock(button.tag);
    }
}


@end
