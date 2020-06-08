//
//  CYTShakeViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTShakeViewController.h"

@interface CYTShakeViewController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation CYTShakeViewController

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];

    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    
    self.listArray = [NSMutableArray array];
    
    [self.listArray addObject:@"开发环境:code=0"];
    [self.listArray addObject:@"测试环境:code=1"];
    [self.listArray addObject:@"灰度环境:code=3"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"运行环境";
    [self.ffNavigationView showLeftItem:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.supernatantView show];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier] forIndexPath:indexPath];
    cell.textLabel.text = self.listArray[indexPath.row];
    NSInteger index = ([CYTURLManager shareManager].urlType);
    UIColor *textColor = kFFColor_title_L2;
    if ((index==0 && indexPath.row==0) || (index==1 && indexPath.row==1) || (index==3 && indexPath.row==2)) {
        textColor = CYTGreenNormalColor;
    }
    cell.textLabel.textColor = textColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTURLType type = 0;
    if (indexPath.row == 0) {
        type = CYTURLTypeDev;
    }else if (indexPath.row == 1) {
        type = CYTURLTypeTest;
    }else if (indexPath.row == 2) {
        type = CYTURLTypeProductionWNS;
    }
    
    //清除h5换粗
    [CYTH5ViewController cleanCacheAndCookie];
    //更改url
    [[CYTURLManager shareManager] changeURLType:type];
    //跳转到首页
    [kAppdelegate goHomeView];
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[UITableViewCell identifier]]];
    }
    return _mainView;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel labelWithFontPxSize:22 textColor:kFFColor_title_gray];
        _descriptionLabel.text = @"";
    }
    return _descriptionLabel;
}

@end
