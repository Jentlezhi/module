//
//  CYTBrandSelect_Series.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelect_Series.h"
#import "CYTBrandSelect_seriesCell.h"
#import "CYTBrandSelectSubbrandModel.h"
#import "CYTBrandSelectSeriesModel.h"

@interface CYTBrandSelect_Series ()<UITableViewDelegate,UITableViewDataSource,FFMainViewDelegate>
@property (nonatomic, strong) FFMainView *mainView;
///lastSelectCell
@property (nonatomic, strong) CYTBrandSelect_seriesCell *lastSelectCell;

@end

@implementation CYTBrandSelect_Series

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.showNavigationView = NO;
}

- (void)showView {
    //很重要，不要优化此处代码。处理UITableViewWrapperView偏移问题。
    _mainView = nil;
    [self.ffContentView addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.mainView.tableView reloadData];
}

#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.seriesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CYTBrandSelectSubbrandModel *model = self.seriesArray[section];
    return model.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CYTAutoLayoutV(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = kFFColor_bg_nor;
    UILabel *title = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L3];
    CYTBrandSelectSubbrandModel *model = self.seriesArray[section];
    title.text = model.makeName;
    [header addSubview:title];
    [title makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.centerY.equalTo(header);
    }];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYTBrandSelect_seriesCell *cell = [tableView dequeueReusableCellWithIdentifier:[CYTBrandSelect_seriesCell identifier] forIndexPath:indexPath];
    CYTBrandSelectSubbrandModel *model = self.seriesArray[indexPath.section];
    CYTBrandSelectSeriesModel *seriesModel = model.models[indexPath.row];
    cell.contentLabel.text = seriesModel.serialName;
    cell.highlightedCell = ([seriesModel isEqual:self.brandResultModel.seriesModel]);
    if ([seriesModel isEqual:self.brandResultModel.seriesModel]) {
        self.lastSelectCell = cell;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //改变高亮
    if (self.lastSelectCell) {
        self.lastSelectCell.highlightedCell = NO;
    }
    CYTBrandSelect_seriesCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.highlightedCell = YES;
    self.lastSelectCell = cell;
    
    if (self.clickedBlock) {
        self.clickedBlock(indexPath);
    }
}

#pragma mark- get
- (FFMainView *)mainView {
    if (!_mainView) {
        _mainView = [FFMainView new];
        _mainView.delegate = self;
        [CYTTools configForMainView:_mainView ];
        _mainView.mjrefreshSupport = MJRefreshSupportNone;
        [_mainView registerCellWithIdentifier:@[[CYTBrandSelect_seriesCell identifier]]];
    }
    return _mainView;
}

@end
