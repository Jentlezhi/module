//
//  CYTAddressCityChooseCommonVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressCityChooseCommonVC.h"
#import "CYTAddressChooseCell.h"
#import "CYTAddressConst.h"
#import "CYTAddressCountyChooseCommonVC.h"

@interface CYTAddressCityChooseCommonVC ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, strong) CYTAddressCountyChooseCommonVC *contentController;

@end

@implementation CYTAddressCityChooseCommonVC

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ffNavigationView.contentView.leftView.imageName = @"cash_getCash_cancel";
    [self.ffNavigationView showLeftItem:YES];
    
    self.ffTitle = self.viewModel.addressModel.selectProvinceModel.name;
    self.ffNavigationView.bgImageView.backgroundColor = kTranslucenceColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    if (self.wilDismissBlock) {
        self.wilDismissBlock();
    }
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.addressModel.selectProvinceModel.citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CYTAddressChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTAddressChooseCell identifier] forIndexPath:indexPath];
    CYTAddressDataItemModel *cityModel = [self.viewModel cityModelWithProvinceModel:self.viewModel.addressModel.selectProvinceModel andIndex:indexPath.row];
    cell.titleLab.text = cityModel.name;
    if (self.viewModel.addressModel.oriCityId == cityModel.idCode && self.viewModel.addressModel.oriCityId != 0) {
        cell.titleLab.textColor = kFFColor_green;
    }else {
        cell.titleLab.textColor = kFFColor_title_L1;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTAddressDataItemModel *cityModel = [self.viewModel cityModelWithProvinceModel:self.viewModel.addressModel.selectProvinceModel andIndex:indexPath.row];
    if (self.viewModel.addressModel.oriCityId == cityModel.idCode && self.viewModel.addressModel.oriCityId != 0) {
        //相同
    }else {
        //不同
        self.viewModel.addressModel.oriCountyId = -1;
    }
    
    self.viewModel.addressModel.selectCityModel = [self.viewModel cityModelWithProvinceModel:self.viewModel.addressModel.selectProvinceModel andIndex:indexPath.row];
    self.viewModel.addressModel.oriCityId = self.viewModel.addressModel.selectCityModel.idCode;
    [self.mainView.tableView reloadData];
    
    if (self.viewModel.type == AddressChooseTypeCity) {
        //发出通知进行数据处理
        [[NSNotificationCenter defaultCenter] postNotificationName:kCommonChooseAddressFinished object:nil];
    }else {
        //区县进入下级页面
        //判断如果区县有数据
        if (self.viewModel.addressModel.selectCityModel.citys.count>0) {
            [self showContentView];
        }else {
            //如果没有区县则直接返回城市
            self.viewModel.addressModel.selectCountyModel = nil;
            self.viewModel.addressModel.oriCountyId = -1;
            [[NSNotificationCenter defaultCenter] postNotificationName:kCommonChooseAddressFinished object:nil];
        }
    }
}

#pragma mark- county
- (void)showContentView {
    self.contentController.viewModel = self.viewModel;
    [self addChildViewController:self.contentController];
    [self.view addSubview:self.contentController.view];
    
    [self.contentController.view remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.equalTo(self.view);
        make.left.equalTo(self.view.right);
    }];
    [self.view layoutIfNeeded];
    
    [self.contentController.view remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    [UIView animateWithDuration:kAnimationDurationInterval animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTAddressChooseCell identifier]]];
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (CYTAddressCountyChooseCommonVC *)contentController {
    if (!_contentController) {
        _contentController = [CYTAddressCountyChooseCommonVC new];
        
        @weakify(self);
        [_contentController setBackBlock:^{
            @strongify(self);
            [self.contentController.view remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.width.height.equalTo(self.view);
                make.left.equalTo(self.view.right);
            }];
            [self.contentController removeFromParentViewController];
            
            [UIView animateWithDuration:kAnimationDurationInterval animations:^{
                [self.view layoutIfNeeded];
            }completion:^(BOOL finished) {
                [self.contentController.view removeFromSuperview];
                [self.contentController removeFromParentViewController];
                self.contentController = nil;
            }];
            
        }];
    }
    return _contentController;
}

@end
