//
//  CYTLogisticsHomeTableController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsHomeTableController.h"
#import "LogisticsHomeHeadView.h"
#import "LogisticsHomeCell.h"
#import "CYTLogisticsNeedWriteTableController.h"
#import "CYTLogisticsNeedList.h"
#import "CYTLogisticsOrderList.h"
#import "CYTCardView.h"

@interface CYTLogisticsHomeTableController ()
@property (nonatomic, strong) LogisticsHomeHeadView *headView;
@property (nonatomic, strong) FFToolView_type0 *rightView;

@end

@implementation CYTLogisticsHomeTableController
@synthesize showNavigationView = _showNavigationView;
@synthesize mainView = _mainView;
 

#pragma mark- flow control
- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self.ffNavigationView addSubview:self.rightView];
    [self.rightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kFFStatusBarHeight+5);
        make.bottom.equalTo(-5);
        make.right.equalTo(-CYTItemMarginH);
    }];
    
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        [self.mainView autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
            FFMainViewModel *model = [FFMainViewModel new];
            model.dataHasMore = NO;
            model.dataEmpty = self.viewModel.listArray.count==0;
            model.netEffective = responseModel.resultEffective;
            return model;
        }];
    }];
    
    [self.viewModel.bannerCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        self.headView.bannerView.imageURLStringsGroup = [self.viewModel.bannerList copy];
    }];
}

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = YES;
    self.viewModel = viewModel;
}

#pragma mark- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"物流服务";
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    [self.mainView autoRefreshWithInterval:0 andPullRefresh:YES];
}

#pragma mark- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogisticsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[LogisticsHomeCell identifier] forIndexPath:indexPath];
    cell.model = self.viewModel.listArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (self.viewModel.listArray.count>0)?CYTAutoLayoutV(90):0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FFSectionHeadView_style0 *header = [FFSectionHeadView_style0 new];
    header.hLineOffset = CYTMarginH;
    header.ffMoreImageView.hidden = YES;
    header.ffServeNameLabel.text = @"车销通 - 优势线路";
    header.ffMoreLabel.text = @"";
    header.topOffset = CYTItemMarginV;
    header.leftOffset = CYTAutoLayoutH(30);
    return (self.viewModel.listArray.count>0)?header:nil;
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    [self.viewModel.bannerCommand execute:nil];
    [self.viewModel.requestCommand execute:nil];
}

- (void)mainViewWillRefresh:(FFMainView *)mainView {
    [self.viewModel.bannerCommand execute:nil];
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- method
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    [super ff_leftClicked:backView];
}

- (void)bannerClicked:(NSInteger)index {
    NSDictionary *dic = self.viewModel.oriBannerList[index];
    NSString *url = dic[@"pageLinkUrl"];
    //如果连接存在则跳转
    if (url.length > 0) {
        CYTH5WithInteractiveCtr *h5 = [[CYTH5WithInteractiveCtr alloc] init];
        h5.requestURL = url;
        [self.navigationController pushViewController:h5 animated:YES];
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        FFMainViewConfigViewModel *configVM = [FFMainViewConfigViewModel new];
        configVM.style = UITableViewStyleGrouped;
        _mainView = [[FFMainView alloc] initWithViewModel:configVM];
        _mainView.mjrefreshSupport = MJRefreshSupportRefresh;
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        [_mainView registerCellWithIdentifier:@[[LogisticsHomeCell identifier]]];
        _mainView.tableView.tableHeaderView = self.headView;
        
        _mainView.dznCustomView.reloadView.topSpace = 10;
        _mainView.dznCustomView.reloadView.betSpace1 = 15;
        _mainView.dznCustomView.reloadView.betSpace3 = 30;
        _mainView.dznCustomViewModel.dznOffsetY = CYTAutoLayoutV(360);
        
        UIView *footerView = [UIView new];
        footerView.size = CGSizeMake(kScreenWidth, CYTItemMarginV);
        _mainView.tableView.tableFooterView = footerView;
    }
    return _mainView;
}

- (LogisticsHomeHeadView *)headView {
    if (!_headView) {
        _headView = [[LogisticsHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(590))];
        _headView.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        [_headView setBannerBlock:^(NSInteger index) {
            @strongify(self);
            [self bannerClicked:index];
        }];
        [_headView setClickedBlock:^(NSInteger index) {
            @strongify(self);
            if (index == 100) {
                //publish
                [self.navigationController pushViewController:[CYTLogisticsNeedWriteTableController new] animated:YES];
            }else if (index == 200) {
                //need
                [self.navigationController pushViewController:[CYTLogisticsNeedList new] animated:YES];
            }else if (index == 300) {
                //order
                [self.navigationController pushViewController:[CYTLogisticsOrderList new] animated:YES];
            }
        }];
    }
    return _headView;
}

- (LogisticsHomeVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [LogisticsHomeVM new];
    }
    return _viewModel;
}

- (FFToolView_type0 *)rightView {
    if (!_rightView) {
        _rightView = [FFToolView_type0 new];
        _rightView.titleLabel.text = @"客服";
        _rightView.titleLabel.font = CYTFontWithPixel(20);
        _rightView.imageView.image = [UIImage imageNamed:@"logistics_home_server"];
        
        [_rightView setClickedBlock:^(id x) {
            //显示美女提示
            CYTCardView *carView = [CYTCardView showCardViewWithType:CYTCardViewTypeLogisticsServe];
            carView.operationBtnClick = ^(BOOL neverShowAgain){
                //美女框点击ok
                [CYTPhoneCallHandler makeLogisticsServicePhone];
            };
        }];
    }
    return _rightView;
}

@end
