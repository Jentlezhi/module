//___FILEHEADER___

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___
@synthesize showNavigationView = _showNavigationView;
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

#pragma mark- method

#pragma mark- get
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
