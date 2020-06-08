//
//  CYTCarDealerChartController.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarDealerChartController.h"
#import "CYTCarDealerChartItemTableController.h"

@interface CYTCarDealerChartController ()
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation CYTCarDealerChartController
@synthesize showNavigationView = _showNavigationView;

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _showNavigationView = NO;
    FFExtendViewModel *vm = viewModel;
    self.defaultIndex = vm.ffIndex;
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self getChartControllers];
    
    //自定义segment-------->
    NSArray *titleArray = @[@"好评榜",@"销量榜"];
    FFBasicSegmentView *customSegmentView = [FFBasicSegmentView new];
    self.itemArray = [NSMutableArray array];
    
    for (int i=0; i<titleArray.count; i++) {
        FFBasicSegmentItemView *item = [FFBasicSegmentItemView new];
        item.title = titleArray[i];
        item.titleButton.titleLabel.font = CYTFontWithPixel(34);
        [item.titleButton setTitleColor:kFFColor_title_L3 forState:UIControlStateNormal];
        [self.itemArray addObject:item];
    }
    customSegmentView.showIndicatorLine = YES;
    customSegmentView.indicatorBgColor = [UIColor whiteColor];
    customSegmentView.lineHeight = CYTAutoLayoutV(4);
    customSegmentView.titleNorColor = kFFColor_title_L3;
    customSegmentView.titleSelColor = kFFColor_title_L1;
    customSegmentView.type = FFBasicSegmentTypeAverage;
    customSegmentView.lineBottomOffset = CYTAutoLayoutV(9);
    customSegmentView.customItemArray = self.itemArray;
    self.segmentView = customSegmentView;
    //<--------------------自定义segment完成
    
    self.segmentHeight = kFFNavigationBarHeight;
    self.segmentTopMargin = kFFStatusBarHeight;
    self.segmentLeftRightOffset = 80;
    self.tabControllersArray = [self.listArray copy];
    
    [self.ffContentView addSubview:self.backButton];
    [self.backButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(-CYTAutoLayoutH(10));
        make.top.equalTo(CYTStatusBarHeight);
        make.width.height.equalTo(kFFNavigationBarHeight);
    }];
}

- (void)getChartControllers {
    self.listArray = [NSMutableArray array];
    CYTCarDealerChartItemTableController *goodChart = [CYTCarDealerChartItemTableController new];
    goodChart.title = @"好评榜";
    goodChart.viewModel.type = CarDealerChartTypeGoodComment;
    CYTCarDealerChartItemTableController *salesChart = [CYTCarDealerChartItemTableController new];
    salesChart.title = @"销量榜";
    salesChart.viewModel.type = CarDealerChartTypeSales;
    
    [self.listArray addObject:goodChart];
    [self.listArray addObject:salesChart];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)indexChangeWithIndex:(NSInteger)index {
    FFBasicSegmentItemView *item0 = self.itemArray[0];
    FFBasicSegmentItemView *item1 = self.itemArray[1];
    
    if (index==0) {
        //选中0
        item0.titleButton.titleLabel.font = CYTFontWithPixel(34);
        item1.titleButton.titleLabel.font = CYTFontWithPixel(32);
    }else {
        item0.titleButton.titleLabel.font = CYTFontWithPixel(32);
        item1.titleButton.titleLabel.font = CYTFontWithPixel(34);
    }
    
    CYTCarDealerChartItemTableController *controller = self.listArray[index];
    [controller refreshData];
}

#pragma mark- get
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

@end
