//
//  CarFilterConditionTableView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterConditionTableView.h"
#import "CarFilterConditionSubbrandModel.h"
#import "CarFilterConditionSubbrand_seriesModel.h"
#import "CarFilterConditionView.h"

@interface CarFilterConditionTableView()
@property (nonatomic, strong) UIView *lineForLeftTabel;
@property (nonatomic, assign) BOOL needScrollRightTabel;
@property (nonatomic, assign) BOOL selectValid;

@end

@implementation CarFilterConditionTableView

- (void)ff_initWithViewModel:(id)viewModel {
    self.selectValid = YES;
    self.viewModel = viewModel;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)ff_addSubViewAndConstraints {
    if (self.viewModel.type != CarFilterConditionTableCar) {
        //single
        [self addSubview:self.leftTable];
        [self.leftTable makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }else {
        //double
        //添加阴影
        [self.leftTable addSubview:self.lineForLeftTabel];
        [self.lineForLeftTabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.right.equalTo(0);
            make.width.equalTo(0.5);
        }];
        
        [self addSubview:self.leftTable];
        [self addSubview:self.rightTable];
        [self.leftTable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.width.equalTo(self).multipliedBy(26/75.0);
        }];
        [self.rightTable makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(self.leftTable.right);
        }];
    }
}

- (void)loadData {
    self.leftTable.hidden = YES;
    self.rightTable.hidden = YES;
    
    if (self.viewModel.type == CarFilterConditionTableCar) {
        //处理车款table数据
        [self loadData_carTable];
    }else {
        //处理其他table
        [self.leftTable.tableView reloadData];
        [self tableViewUpdateHeight];
        //偏移量处理
        NSIndexPath *leftIndexPath = [self.viewModel tableOffsetWithTableIndex:0];
        [self.leftTable.tableView beginUpdates];
        [self.leftTable.tableView scrollToRowAtIndexPath:leftIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self.leftTable.tableView endUpdates];
    }
    
    //延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.leftTable.hidden = NO;
        self.rightTable.hidden = NO;
    });
}

- (void)loadData_carTable {
    if (self.viewModel.invalid) {
        [self.leftTable.tableView reloadData];
        [self tableViewUpdateHeight];
        //单车系
        [self.leftTable remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.width.equalTo(kScreenWidth);
        }];
        self.lineForLeftTabel.hidden = YES;
        return;
    }
    
    self.needScrollRightTabel = YES;
    if (self.viewModel.isSingleSeries) {
        //单车系
        [self.leftTable remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.width.equalTo(0);
        }];
        self.lineForLeftTabel.hidden = YES;
        
        //默认有“全部”
        if (self.viewModel.rightListArray.count>=2) {
            [self.rightTable.tableView reloadData];
            [self tableViewUpdateHeight];
            [self loadData_carScroll];
        }else {
            //请求车系数据
            CarFilterConditionSubbrand_seriesModel *seriesModel = [self.viewModel seriesModelWithIndex:[NSIndexPath indexPathForRow:0 inSection:1]];
            [self.viewModel selectSeries:seriesModel];
            self.viewModel.selectSeriesModel = self.viewModel.inSelectSeriesModel;
        }
    }else {
        [self.leftTable.tableView reloadData];
        [self tableViewUpdateHeight];
        BOOL needRequest = NO;
        if (!self.viewModel.inSelectSeriesModel) {
            needRequest = YES;
        }else {
            if (self.viewModel.inSelectSeriesModel.modelId != self.viewModel.selectSeriesModel.modelId) {
                needRequest = YES;
            }
        }
        
        if (needRequest) {
            //请求对应车系数据
            [self.viewModel selectSeries:self.viewModel.selectSeriesModel];
            self.viewModel.inSelectSeriesModel = self.viewModel.selectSeriesModel;
        }else {
            [self.rightTable.tableView reloadData];
            [self tableViewUpdateHeight];
            [self loadData_carScroll];
        }
        
        //将左侧table滚动到正确位置
        NSIndexPath *leftIndexPath = [self.viewModel tableOffsetWithTableIndex:0];
        [self.leftTable.tableView scrollToRowAtIndexPath:leftIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

///车款滚动到正确位置
- (void)loadData_carScroll {
    //当table布局完成才能调用改方法，否则会出错。
    self.leftTable.userInteractionEnabled = NO;
    self.rightTable.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.needScrollRightTabel) {
            self.needScrollRightTabel = NO;
            NSIndexPath *rightIndex = [self.viewModel tableOffsetWithTableIndex:1];
            CYTLog(@"----------nono1111");
            self.selectValid = NO;
            [self.rightTable.tableView scrollToRowAtIndexPath:rightIndex atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }else {
            //不需要滚动到指定indexpath
            CYTLog(@"----------nono22222");
            self.selectValid = NO;
            [self.rightTable.tableView setContentOffset:CGPointMake(0, 0)];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CYTLog(@"----------yesyes0000");
            self.selectValid = YES;
        });
        
        self.leftTable.userInteractionEnabled = YES;
        self.rightTable.userInteractionEnabled = YES;
    });
}

- (void)ff_bindViewModel {
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.conditionCarCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        
        [self.leftTable.tableView reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.rightTable autoReloadWithInterval:0 andMainViewModelBlock:^FFMainViewModel *{
                FFMainViewModel *model = [FFMainViewModel new];
                model.dataEmpty = self.viewModel.rightListArray.count==0;
                model.dataHasMore = NO;
                model.netEffective = responseModel.resultEffective;
                return model;
            }];
            
            [self tableViewUpdateHeight];
            [self loadData_carScroll];
        });
    }];
    
    [self.viewModel.reloadRightTableSubject subscribeNext:^(id x) {
        @strongify(self);
        if ([x integerValue]==1) {
            [self.leftTable.tableView reloadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.rightTable.tableView reloadData];
                [self tableViewUpdateHeight];
            });
        }
    }];
}

- (void)tableViewUpdateHeight {
    //如果是单车系，则设置筛选视图高度
    [self.viewModel.conditionViewRef updateSingleSeriesHeight:[self.viewModel heightOfCarList]];
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberWithTableIndex:tableView.tag];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberWithSection:section andTableIndex:tableView.tag];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.viewModel sectionHeightWithTableIndex:tableView.tag andSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = kFFColor_bg_nor;
    UILabel *label = [UILabel labelWithFontPxSize:24 textColor:kFFColor_title_L3];
    [header addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.bottom.right.equalTo(0);
    }];
    label.text = [self.viewModel sectionTitleWithTableIndex:tableView.tag andSection:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarFilterConditionTabelCell_text *cell = [tableView dequeueReusableCellWithIdentifier:[CarFilterConditionTabelCell_text identifier] forIndexPath:indexPath];
    cell.contentLabel.text = [self.viewModel titleWithIndexPath:indexPath andTableIndex:tableView.tag];
    cell.type = self.viewModel.type;
    //高亮选中的cell
    id theModel = [self.viewModel getModelWithIndexPath:indexPath andTableIndex:tableView.tag];
    cell.contentLabel.textColor = ([self.viewModel selectedModelWithModel:theModel])?kFFColor_green:kFFColor_title_L1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.selectValid) {
        return;
    }
    
    if (self.viewModel.invalid) {
        //数据无效
        [self.viewModel.conditionViewRef closeConditionView];
    }else {
        
        //点击车系如果是选中的那个，需要滚动车型
        if (self.viewModel.type == CarFilterConditionTableCar && tableView.tag == 0) {
            NSIndexPath *theIndex = [self.viewModel tableOffsetWithTableIndex:0];
            if ([theIndex isEqual:indexPath]) {
                self.needScrollRightTabel = YES;
            }
        }
        //保存数据
        [self.viewModel saveFilterConditionWithTableIndex:tableView.tag andIndexPath:indexPath];
    }
    
    //保存偏移量
    [self.viewModel saveTableOffsetWithTableIndex:tableView.tag andOffset:indexPath];
}

- (void)mainViewWillReload:(FFMainView *)mainView {
    //none
}

#pragma mark- scroll
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag==1) {
        self.selectValid = NO;
        CYTLog(@"----------nono3333");
    }
}

//手指操作，松开手指的同时view停止滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CYTLog(@"scrollViewDidEndDragging");
    if (!decelerate) {
        //不动了
        if (scrollView.tag==1) {
            self.selectValid = YES;
            CYTLog(@"-----------yesyes");
        }
    }
}

//手动操作，松开手指后自动停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CYTLog(@"scrollViewDidEndDecelerating");
    if (scrollView.tag==1) {
        self.selectValid = YES;
        CYTLog(@"-----------yesyes");
    }
}

//调用系统方法造成的滚动的停止，并且是有动画的时候
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CYTLog(@"scrollViewDidEndScrollingAnimation");
    if (scrollView.tag==1) {
        self.selectValid = YES;
        CYTLog(@"-----------yesyes");
    }
}

#pragma mark- get
- (FFMainView *)leftTable {
    if (!_leftTable) {
        _leftTable = [FFMainView new];
        _leftTable.tableView.tag = 0;
        _leftTable.delegate = self;
        [CYTTools configForMainView:_leftTable ];
        _leftTable.tableView.estimatedRowHeight = 34;
        _leftTable.mjrefreshSupport = MJRefreshSupportNone;
        [_leftTable registerCellWithIdentifier:@[[CarFilterConditionTabelCell_text identifier]]];
    }
    return _leftTable;
}

- (FFMainView *)rightTable {
    if (!_rightTable) {
        _rightTable = [FFMainView new];
        _rightTable.tableView.tag = 1;
        _rightTable.delegate = self;
        [CYTTools configForMainView:_rightTable ];
        _rightTable.tableView.estimatedRowHeight = 34;
        _rightTable.mjrefreshSupport = MJRefreshSupportNone;
        [_rightTable registerCellWithIdentifier:@[[CarFilterConditionTabelCell_text identifier]]];
    }
    return _rightTable;
}

- (UIView *)lineForLeftTabel {
    if (!_lineForLeftTabel) {
        _lineForLeftTabel = [UIView new];
        _lineForLeftTabel.backgroundColor = kFFColor_line;
        _lineForLeftTabel.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:1].CGColor;
        _lineForLeftTabel.layer.shadowOpacity = 0.9;
    }
    return _lineForLeftTabel;
}

@end
