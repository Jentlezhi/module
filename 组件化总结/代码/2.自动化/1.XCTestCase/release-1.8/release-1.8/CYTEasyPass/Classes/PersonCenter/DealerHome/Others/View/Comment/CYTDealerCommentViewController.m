//
//  CYTDealerCommentViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentViewController.h"
#import "FFBasicSegmentItemView_oval.h"
#import "CYTDealerCommentCountModel.h"
#import "CYTDealerCommentPublishView.h"

@interface CYTDealerCommentViewController ()
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *ctrArray;
///评论页面
@property (nonatomic, strong) CYTDealerCommentPublishView *commentPublishView;

@end

@implementation CYTDealerCommentViewController

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    NSArray *titleArray = @[@"全部",@"好评",@"中评",@"差评"];

    //自定义segment-------->
    FFBasicSegmentView *customSegmentView = [FFBasicSegmentView new];
    self.itemArray = [NSMutableArray array];
    
    for (int i=0; i<titleArray.count; i++) {
        FFBasicSegmentItemView_oval *item = [FFBasicSegmentItemView_oval new];
        item.title = titleArray[i];
        item.labelHeight = CYTAutoLayoutV(46);
        item.labelLeftMargin = CYTAutoLayoutH(15);
        item.labelRightMargin = CYTAutoLayoutH(15);
        item.titleButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.itemArray addObject:item];
    }
    
    customSegmentView.showIndicatorLine = NO;
    customSegmentView.itemMinWidth = CYTAutoLayoutH(130);
    customSegmentView.itemContentInsect = UIEdgeInsetsMake(0, 10, 0, 10);
    customSegmentView.customItemArray = self.itemArray;
    self.segmentView = customSegmentView;
    //<--------------------自定义segment完成
    
    self.ctrArray = [NSMutableArray array];
    for (int i=0; i<titleArray.count; i++) {
        CYTDealerCommentItemVC *itemCtr = [CYTDealerCommentItemVC new];
        itemCtr.viewModel.userId = self.userId;
        itemCtr.viewModel.evalType = i;
        [self.ctrArray addObject:itemCtr];
    }
    
    self.segmentLeftRightOffset = CYTAutoLayoutH(5);
    self.segmentHeight = CYTAutoLayoutV(98);
    self.tabControllersArray = self.ctrArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"服务评价";
    self.view.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCommentCountWithNoti:) name:kDealerCommentCountChangedKey object:nil];
    self.ffNavigationView.contentView.rightView.title = @"发布评价";
    if (![self.userId isEqualToString:CYTUserId]) {
        //别人可以评价
        [self.ffNavigationView showRightItem:YES];
        self.ffNavigationView.contentView.rightView.font = CYTFontWithPixel(28);
        self.ffNavigationView.contentView.rightView.titleColor = kFFColor_title_L1;
        self.ffNavigationView.contentView.rightView.contentInsect = UIEdgeInsetsMake(0, -10, 0, 10);
    }
}

//有评价功能 1）禁止自动滚动 2）不使用toolbar------>>>>
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
//<<<<---------------------------------------------

- (void)ff_rightClicked:(FFNavigationItemView *)backView {
    [self.commentPublishView showNow];
}

- (void)changeCommentCountWithNoti:(NSNotification *)noti {
    if (!noti.object) {
        return;
    }
    
    CYTDealerCommentCountModel *countModel = noti.object;
    NSArray *countArray = @[countModel.goodCount,countModel.middleCount,countModel.badCount];
    
    NSArray *titleArray = @[@"好评",@"中评",@"差评"];
    for (int i=1; i<self.itemArray.count; i++) {
        FFBasicSegmentItemView_oval *item = self.itemArray[i];
        NSString *title = titleArray[i-1];
        title = [NSString stringWithFormat:@"%@(%@)",title,countArray[i-1]];
        item.title = title;
    }
}

///index change
- (void)indexChangeWithIndex:(NSInteger)index {
    for (FFBasicSegmentItemView_oval *item in self.itemArray) {
        item.titleButton.backgroundColor = [UIColorFromRGB(0x2CB63E) colorWithAlphaComponent:0.1];
        item.titleColor = UIColorFromRGB(0x9BA49D);
    }
    
    if (index>=0 && index<self.itemArray.count) {
        FFBasicSegmentItemView_oval *item = self.itemArray[index];
        item.titleButton.backgroundColor = kFFColor_green;
        item.titleColor = [UIColor whiteColor];
        
        CYTDealerCommentItemVC *ctr = self.ctrArray[index];
        [ctr loadData];
    }
}

- (CYTDealerCommentPublishView *)commentPublishView {
    if (!_commentPublishView) {
        
        CYTDealerCommentPublishModel *model = [CYTDealerCommentPublishModel new];
        //被评论认用户Id
        model.beEvalUserId = self.userId;
        //评价类型1=电话、2=订单
        model.sourceType = @"1";
        //评价来源1=车源详情 2=寻车详情 3=个人主页 4=买家订单 5=卖家订单 6=车商圈 7评价页面
        model.sourceId = @"7";
        
        CYTDealerCommentPublishVM *vm = [[CYTDealerCommentPublishVM alloc] initWithModel:model];
        [vm.hudSubject subscribeNext:^(id x) {
            if ([x integerValue] == 0) {
                [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
            }else {
                [CYTLoadingView hideLoadingView];
            }
        }];
        
        @weakify(self);
        [vm.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
            @strongify(self);
            //如果成功则设置nil
            if (responseModel.resultEffective) {
                _commentPublishView = nil;
                //刷新列表，所有都刷新
                for (int i=0; i<self.ctrArray.count; i++) {
                    CYTDealerCommentItemVC *ctr = self.ctrArray[i];
                    [ctr refreshData];
                    if (self.refreshBlock) {
                        self.refreshBlock();
                    }
                }
            }
            if (responseModel.resultEffective) {
                [CYTToast successToastWithMessage:responseModel.resultMessage];
            }else{
                [CYTToast errorToastWithMessage:responseModel.resultMessage];
            }
            
        }];
        _commentPublishView = [[CYTDealerCommentPublishView alloc] initWithViewModel:vm];
        _commentPublishView.title = @"发布评价";
    }
    return _commentPublishView;
}


@end
