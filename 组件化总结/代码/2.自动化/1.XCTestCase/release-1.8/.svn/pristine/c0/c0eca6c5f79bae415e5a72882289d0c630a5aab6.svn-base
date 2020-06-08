//
//  CYTCarSourceImageShowViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceImageShowViewController.h"
#import "CYTAddImageView.h"
#import "CYTPhontoPreviewViewController.h"

@interface CYTCarSourceImageShowViewController ()
@property (nonatomic, strong) CYTAddImageView *addImageView;

@end

@implementation CYTCarSourceImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)loadUI {
    [self createNavBarWithBackButtonAndTitle:@"图片详情"];
    [self.view addSubview:self.addImageView];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.top.equalTo(64+CYTAutoLayoutV(30));
    }];
}

#pragma mark- get
- (CYTAddImageView *)addImageView {
    if (!_addImageView) {
        CYTAddImageModel *model = [CYTAddImageModel new];
        model.imageMaxNum = 9;
        model.type = AddImageTypeShow;
        model.perLineNum = 3;
        model.imageModelArray = self.imageArray.mutableCopy;
        _addImageView = [[CYTAddImageView alloc] initWithModel:model];
        
        @weakify(self);
        [_addImageView setImageViewClickBack:^(NSMutableArray *images, NSInteger index) {
            @strongify(self);
            CYTPhontoPreviewViewController *photoPreviewVC = [[CYTPhontoPreviewViewController alloc] init];
            photoPreviewVC.images = images;
            photoPreviewVC.index = index;
            [self.navigationController pushViewController:photoPreviewVC animated:YES];
        }];
    }
    return _addImageView;
}

@end
