//
//  FFTestController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFTestController.h"
#import "CYTCell1.h"
#import "CYTCell2.h"

@interface FFTestController ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;

@end

@implementation FFTestController


- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    
    [self.ffDZNControl setRequestAgainBlock:^{
        CYTLog(@"2222222222");
    }];
    [CYTTools configForDZNSupernatant:self.ffDZNControl];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)viewDidLoad { 
    [super viewDidLoad];
    self.ffTitle = @"cellModel";
    self.showNavigationView = YES;
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier] forIndexPath:indexPath];
    FFExtendModel *model = self.viewModel.listArray[indexPath.row];
    cell.textLabel.text = model.ffDescription;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets insets = UIEdgeInsetsMake(44, 0, 0, 0);
    [self showResultViewWithType:indexPath.row andInsets:insets];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideResultView];
        
    });
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[UITableViewCell identifier]]];
        [CYTTools configForMainView:_mainView ];
    }
    return _mainView;
}

- (FFCellModelDemoVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [FFCellModelDemoVM new];
    }
    return _viewModel;
}

@end
