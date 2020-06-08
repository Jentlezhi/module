//
//  CYTAlbumsListViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAlbumsListViewController.h"
#import "CYTImageListCell.h"
#import "CYTImagePickerViewController.h"
#import "CYTAssetModel.h"
#import "CYTImageAssetManager.h"
#import "CYTIndicatorView.h"

@interface CYTAlbumsListViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;

@end

@implementation CYTAlbumsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self albumsListBasicConfig];
    [self initAlbumsListComponents];
    [self configMainTableView];
    [self loadAlbumsList];
    
}
#pragma mark - 基本配置
/**
 *  基本配置
 */
- (void)albumsListBasicConfig{
    [self createNavBarWithTitle:@"照片" andShowBackButton:NO showRightButtonWithTitle:@"取消"];
}
/**
 *  初始化子控件
 */
- (void)initAlbumsListComponents{
    
}
/**
 *  配置表格
 */
- (void)configMainTableView{
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
}

- (void)rightButtonClick:(UIButton *)rightButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.dataSource.count) {
        [self loadAlbumsList];
    }
}

/**
 *  加载图片
 */
- (void)loadAlbumsList{
    CYTWeakSelf
    [CYTIndicatorView showIndicatorViewWithType:CYTIndicatorViewTypeNotEditable];
    [self.imageAssetManager fetchAllAssetModelsWithAssetType:CYTAssetTypeAll completion:^(NSArray<CYTAssetModel *> *assetModels) {
        [CYTIndicatorView hideIndicatorView];
        weakSelf.dataSource = [assetModels copy];
        [weakSelf.mainTableView reloadData];
    }];
}

#pragma mark - 懒加载

- (CYTImageAssetManager *)imageAssetManager{
    if (!_imageAssetManager) {
        _imageAssetManager = [CYTImageAssetManager sharedAssetManager];
        _imageAssetManager.filterEmptyAlbum = YES;
    }
    return _imageAssetManager;
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTImageListCell *cell = [CYTImageListCell cellForTableView:tableView indexPath:indexPath];
    cell.assetModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CYTAutoLayoutV(180.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTImagePickerViewController *imagePickerViewController = [[CYTImagePickerViewController alloc] init];
    imagePickerViewController.assetModel = self.dataSource[indexPath.row];
    imagePickerViewController.selectedMaxNum = self.selectedMaxNum;
    CYTWeakSelf
    imagePickerViewController.completeAction = ^(NSArray<CYTAlbumModel *> *albumModels) {
        !weakSelf.completeAction?:weakSelf.completeAction(albumModels);
    };
    [self.navigationController pushViewController:imagePickerViewController animated:YES];
}

@end
