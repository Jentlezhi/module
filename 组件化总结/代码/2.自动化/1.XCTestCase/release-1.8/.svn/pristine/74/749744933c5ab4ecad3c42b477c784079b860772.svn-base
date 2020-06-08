//
//  CYTCarPublishSucceedController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarPublishSucceedController.h"
#import "CYTShareView2.h"
#import "CYTSeekCarNeedPublishViewController.h"
#import "CYTCarSourcePublishViewController.h"
#import "CYTShareManager.h"
#import "CYTMyYicheCoinViewController.h"

@interface CYTCarPublishSucceedController ()
@property (nonatomic, strong) CYTShareView2 *shareView;

@end

@implementation CYTCarPublishSucceedController
@synthesize showNavigationView = _showNavigationView;

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.succeedImageView];
    [self.ffContentView addSubview:self.succeedLabel];
    [self.ffContentView addSubview:self.shareView];
    
    [self.succeedImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(CYTAutoLayoutV(120));
    }];
    [self.succeedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.succeedImageView.bottom).offset(CYTAutoLayoutV(50));
    }];
    [self.shareView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(-CYTAutoLayoutV(122));
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    self.ffTitle = @"发布成功";
    self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L2;
    [self.ffNavigationView showRightItemWithTitle:@"继续发布"];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    if ([self.ffobj integerValue] == 1) {
        [FFCommonCode navigation:self.navigationController popControllerWithClassName:NSStringFromClass([CYTMyYicheCoinViewController class])];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    if (self.publishType == CYTPublishTypeSeekCarPublish) {
        CYTSeekCarNeedPublishViewController *seekCarNeedPublish = [CYTSeekCarNeedPublishViewController new];
        seekCarNeedPublish.ffobj = self.ffobj;
        [self.navigationController pushViewController:seekCarNeedPublish animated:YES];
    }else{
        CYTCarSourcePublishViewController *carSourcePublish = [CYTCarSourcePublishViewController new];
        carSourcePublish.ffobj = self.ffobj;
        [self.navigationController pushViewController:carSourcePublish animated:YES];
    }
}

#pragma mark- get
- (UIImageView *)succeedImageView {
    if (!_succeedImageView) {
        _succeedImageView = [UIImageView new];
        _succeedImageView.contentMode = UIViewContentModeScaleAspectFit;
        _succeedImageView.image = [UIImage imageNamed:@"carSource_publish_success"];
    }
    return _succeedImageView;
}

- (UILabel *)succeedLabel {
    if (!_succeedLabel) {
        _succeedLabel = [UILabel labelWithFontPxSize:40 textColor:UIColorFromRGB(0x656565)];
    }
    return _succeedLabel;
}

- (CYTShareView2 *)shareView {
    if (!_shareView) {
        _shareView = [CYTShareView2 new];
        @weakify(self);
        [_shareView setClickBlock:^(NSInteger tag) {
            @strongify(self);
            //需要区分是寻车还是车源
            CYTShareRequestModel *model = [CYTShareRequestModel new];
            model.plant = tag;
            model.type = (self.publishType == CYTPublishTypeCarsourcePublish)?ShareTypeId_carSource:ShareTypeId_seekCar;
            model.idCode = self.idCode;
            kAppdelegate.wxShareType = model.type;
            kAppdelegate.wxShareBusinessId = model.idCode;
            [CYTShareManager shareWithRequestModel:model];
            
            
            if (tag == 0) {
                //好友
                if (self.publishType == CYTPublishTypeCarsourcePublish) {
                    //车源
                    [MobClick event:@"FX_WXHY_CYFB"];
                }else {
                    //寻车
                    [MobClick event:@"FX_WXHY_XCFB"];
                }
            }else {
                //朋友圈
                if (self.publishType == CYTPublishTypeCarsourcePublish) {
                    //车源
                    [MobClick event:@"FX_WXPYQ_CYFB"];
                }else {
                    //寻车
                    [MobClick event:@"FX_WXPYQ_XCFB"];
                }
            }
        }];
    }
    return _shareView;
}

- (void)setPublishType:(CYTPublishType)publishType{
    _publishType = publishType;
    NSString *successMsg = publishType == CYTPublishTypeSeekCarPublish?@"寻车发布成功":@"车源发布成功";
    self.succeedLabel.text = successMsg;
}
@end
