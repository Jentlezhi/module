//___FILEHEADER___

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
@synthesize ffDZNControl = _ffDZNControl;

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
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
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFExtendTableViewCellModel *ccModel = [FFExtendTableViewCellModel new];
    ccModel.ffIndexPath = indexPath;
    ccModel.ffIdentifier = @"xxxx";
    FFExtendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ccModel.ffIdentifier forIndexPath:ccModel.ffIndexPath];
    cell.ffCustomizeCellModel = ccModel;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)mainViewWillRefresh:(FFMainView *)mainView {
//
//}
//
//- (void)mainViewWillLoadMore:(FFMainView *)mainView {
//
//}
//
//- (void)mainViewWillReload:(FFMainView *)mainView {
//
//}

#pragma mark- method

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
//        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
//        _mainView.dznCustomViewModel.shouldDisplay = NO;
//        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[]];
    }
    return _mainView;
}

//- (<#name#>* )viewModel {
//    if (!_viewModel) {
//        _viewModel = [<#name#> new];
//    }
//    return _viewModel;
//}

- (FFDZNControl *)ffDZNControl {
    if (!_ffDZNControl) {
        _ffDZNControl = [FFDZNControl new];
//        [CYTTools configForDZNControl:_ffDZNControl];
        @weakify(self);
        [_ffDZNControl setRequestAgainBlock:^{
            @strongify(self);
            CYTLog(@"requestAgain");
        }];
    }
    return _ffDZNControl;
}

@end
