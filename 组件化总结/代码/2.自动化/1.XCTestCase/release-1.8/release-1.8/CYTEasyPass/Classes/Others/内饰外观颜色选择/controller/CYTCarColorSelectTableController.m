//
//  CYTCarColorSelectTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarColorSelectTableController.h"
#import "CYTGetColorConst.h"
#import "CYTColorInputViewController.h"

@interface CYTCarColorSelectTableController ()
@property (nonatomic, strong) CYTGetColorBasicCell *lastCell;

@end

@implementation CYTCarColorSelectTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];

    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    [self.ffNavigationView showRightItemWithTitle:@"自定义颜色"];
    self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L2;
    self.ffTitle = (self.inColor)?@"内饰颜色":@"外观颜色";
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tmp = (self.inColor)?self.viewModel.inColorArray:self.viewModel.exColorArray;
    return tmp.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *itemColor = (self.inColor)?self.viewModel.inColorArray[indexPath.row]:self.viewModel.exColorArray[indexPath.row];
    NSString *selectColor = (self.inColor)?self.viewModel.inColorSel:self.viewModel.exColorSel;
    
    CYTGetColorBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTGetColorBasicCell identifier] forIndexPath:indexPath];
    cell.titleLab.text = itemColor;
    
    if (selectColor && [itemColor isEqualToString:selectColor]) {
        cell.titleLab.textColor = kFFColor_green;
    }else {
        cell.titleLab.textColor = kFFColor_title_L1;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //改变颜色
    CYTGetColorBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTGetColorBasicCell identifier] forIndexPath:indexPath];
    cell.titleLab.textColor = kFFColor_green;
    
    if (self.lastCell) {
        self.lastCell.titleLab.textColor = kFFColor_title_L1;
    }
    
    self.lastCell = cell;
    
    NSString *color = (self.inColor)?self.viewModel.inColorArray[indexPath.row]:self.viewModel.exColorArray[indexPath.row];
    if (self.inColor) {
        self.viewModel.inColorSel = color;
    }else {
        self.viewModel.exColorSel = color;
    }
    [self.mainView.tableView reloadData];
    [self selectColorWithModel:color];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    CYTColorInputViewController *input = [CYTColorInputViewController new];
    input.viewModel = self.viewModel;
    input.inColor = self.inColor;
    [self.navigationController pushViewController:input animated:YES];
}

- (void)selectColorWithModel:(NSString *)color {
    if (!self.inColor) {
        //当前是外观选择，点击进入内饰选择
        CYTCarColorSelectTableController *inColorCtr = [CYTCarColorSelectTableController new];
        inColorCtr.viewModel = self.viewModel;
        inColorCtr.inColor = YES;
        
        [self.navigationController pushViewController:inColorCtr animated:YES];
    }else {
        //当前是内饰选择，点击选择颜色，则操作完成
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetColorFinished object:nil];
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
//        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.tableView.estimatedRowHeight = 50;
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTGetColorBasicCell identifier]]];
        _mainView.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    }
    return _mainView;
}

- (CYTGetColorBasicVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTGetColorBasicVM new];
    }
    return _viewModel;
}

@end
