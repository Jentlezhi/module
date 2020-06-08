//
//  CYTTestViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTTestViewController.h"
#import "FFTestController.h"
#import "CYTLogisticsNeedWriteVM.h"
#import "CYTLogisticsNeedWriteTableController.h"
#import "CYTSendCarSupernatant.h"
#import "CYTPriceInputView.h"

@interface CYTTestViewController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation CYTTestViewController

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    self.listArray = [NSMutableArray array];
    
    FFExtendModel *model0 = [FFExtendModel new];
    model0.ffIndex = 0;
    model0.ffDescription = @"xxx";
    
    FFExtendModel *model1 = [FFExtendModel new];
    model1.ffIndex =1;
    model1.ffDescription = @"cellModel+dzn扩展";

    [self.listArray addObject:model0];
    [self.listArray addObject:model1];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.ffContentView);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"demo";
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = YES;
            model.dataHasMore = NO;
            model.netEffective = YES;
            return model;
        }];
        
    });
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier] forIndexPath:indexPath];
    FFExtendModel *model = self.listArray[indexPath.row];
    cell.textLabel.text = model.ffDescription;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FFExtendModel *model = self.listArray[indexPath.row];
    if (model.ffIndex == 0) {
        
    }
    
    if (model.ffIndex == 1) {
        [self.navigationController pushViewController:[FFTestController new] animated:YES];
    }

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

@end
