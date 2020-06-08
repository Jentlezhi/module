//
//  CYTAddressCountyChooseCommonVC.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressCountyChooseCommonVC.h"
#import "CYTAddressChooseCell.h"
#import "CYTAddressConst.h"

@interface CYTAddressCountyChooseCommonVC ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation CYTAddressCountyChooseCommonVC

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
    self.ffTitle = self.viewModel.addressModel.selectCityModel.name;
    self.ffNavigationView.bgImageView.backgroundColor = kTranslucenceColor;
}

- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    if (self.backBlock) {
        self.backBlock();
    }
}

#pragma mark- delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.addressModel.selectCityModel.citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTAddressChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTAddressChooseCell identifier] forIndexPath:indexPath];
    
    CYTAddressDataItemModel *countyModel = [self.viewModel countyModelWithCityModel:self.viewModel.addressModel.selectCityModel andIndex:indexPath.row];
    cell.titleLab.text = countyModel.name;
    
    if ((self.viewModel.addressModel.oriCountyId == countyModel.idCode) && self.viewModel.addressModel.oriCountyId != 0) {
        cell.titleLab.textColor = kFFColor_green;
    }else {
        cell.titleLab.textColor = kFFColor_title_L1;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.viewModel.addressModel.selectCountyModel = [self.viewModel countyModelWithCityModel:self.viewModel.addressModel.selectCityModel andIndex:indexPath.row];
    self.viewModel.addressModel.oriCountyId = self.viewModel.addressModel.selectCountyModel.idCode;
    [self.mainView.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kCommonChooseAddressFinished object:nil];
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

@end
