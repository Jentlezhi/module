//
//  CYTCarSearchWithGuidePriceTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSearchWithGuidePriceTableController.h"
#import "CYTUnenableSearchViewWithBorder.h"
#import "CYTStockCarCell.h"

@interface CYTCarSearchWithGuidePriceTableController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) CYTUnenableSearchViewWithBorder *searchView;

@end

@implementation CYTCarSearchWithGuidePriceTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffContentView addSubview:self.backButton];
    [self.ffContentView addSubview:self.searchView];
    [self.ffContentView addSubview:self.mainView];
    
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTStatusBarHeight);
        make.height.equalTo(44);
        make.left.equalTo(CYTAutoLayoutH(30));
    }];
    [self.searchView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton);
        make.left.equalTo(self.backButton.right).offset(0);
        make.right.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(86));
    }];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(CYTViewOriginY);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    self.mainView.dznCustomViewModel.shouldDisplay = NO;
    
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataEmpty = (self.viewModel.listArray.count == 0);
            model.dataHasMore = self.viewModel.isMore;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = NO;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"搜索";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchView.searchView.textField becomeFirstResponder];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTStockCarCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTStockCarCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CYTStockCarModel *model = self.viewModel.listArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTStockCarModel *model = self.viewModel.listArray[indexPath.row];
    model.searchString = self.viewModel.searchString;
    if (self.selectBlock) {
        self.selectBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self keybordWillHide];
}

- (void)mainViewWillLoadMore:(FFMainView *)mainView {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)keybordWillHide {
    //开始搜索
    if (self.searchView.searchView.textField.text.length == 0) {
        return;
    }
    self.viewModel.searchString = self.searchView.searchView.textField.text;
    if (self.viewModel.searchString.length == 0) {
        [self.viewModel.listArray removeAllObjects];
        [self.mainView.tableView reloadData];
        return;
    }
    
    self.viewModel.lastId = 0;
    [self.viewModel.requestCommand execute:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (@available(iOS 11.0, *)) {
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [_mainView registerCellWithIdentifier:@[[CYTStockCarCell identifier]]];
        [CYTTools configForMainView:_mainView ];
        _mainView.dznCustomViewModel.dznOffsetY = -20;
    }
    return _mainView;
}

- (CYTUnenableSearchViewWithBorder *)searchView {
    if (!_searchView) {
        _searchView = [CYTUnenableSearchViewWithBorder new];
        _searchView.searchView.canFillText = YES;
        _searchView.searchView.textField.text = self.viewModel.searchString;
        [_searchView.searchView moveLeft];
        _searchView.searchView.textField.placeholder = @"输入指导价格直接导入选择车型";
        _searchView.searchView.textField.keyboardType = UIKeyboardTypeDecimalPad;
        
        if (@available(iOS 11.0, *)) {
            _searchView.searchView.textField.keyboardType = UIKeyboardTypeDefault;
            _searchView.searchView.textField.returnKeyType = UIReturnKeySearch;
            _searchView.searchView.textField.delegate = self;
        }
    }
    return _searchView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        @weakify(self);
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self ff_leftClicked:nil];
        }];
    }
    return _backButton;
}

- (CYTStockCarSearchVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTStockCarSearchVM new];
    }
    return _viewModel;
}

@end
