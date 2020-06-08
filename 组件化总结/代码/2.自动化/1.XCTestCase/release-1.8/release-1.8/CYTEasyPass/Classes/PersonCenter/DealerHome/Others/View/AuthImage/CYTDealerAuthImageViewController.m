//
//  CYTDealerAuthImageViewController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerAuthImageViewController.h"
#import "CYTDealerAuthImageCell.h"
#import "CYTDealerAuthFooterView.h"
#import "CYTCommonNetErrorView.h"
#import "CYTPhotoBrowseViewController.h"
#import "CYTAlbumModel.h"

@interface CYTDealerAuthImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CYTDealerAuthImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    [self loadData];
    self.view.backgroundColor = kFFColor_bg_nor;
    [self createNavBarWithBackButtonAndTitle:@"认证信息"];
    self.hiddenNavigationBarLine = YES;
}

- (void)loadUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(CYTViewOriginY+CYTItemMarginV);
    }];
}

- (void)bindViewModel {
    @weakify(self);
    
    //设置网络异常样式
    CYTCommonNetErrorView *reloadView = [[CYTCommonNetErrorView alloc] init];
    reloadView.bottomSpace = 0;
    reloadView.topSpace = 0;
    reloadView.contentText = @"Sorry 网络出现问题了";
    reloadView.contentSubText = @"- 请稍后再试吧 -";
    reloadView.contentImage = @"dzn_netError_2";
    self.dznCustomView.reloadView = reloadView;
    
    self.dznCustomView.emptyView.dznLabel.text = @"- 暂时没有您要的数据 -";
    
    
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue]==0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.dznCustomViewModel.requestAgainSubject subscribeNext:^(id x) {
        @strongify(self);
        [self loadData];
    }];
    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);

        self.dznCustomViewModel.shouldDisplay = YES;
        self.dznCustomView.type = (responseModel.resultEffective)?DZNViewTypeEmpty:DZNViewTypeReload;

        [self loadUI];
        [self.collectionView reloadData];
    }];
}

- (void)loadData {
    [self.viewModel.requestCommand execute:nil];
}

#pragma mark- delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYTDealerAuthImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CYTDealerAuthImageCell" forIndexPath:indexPath];
    CYTDealerAuthImageModel *model = self.viewModel.listArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.thumbnailUrl];
    CYTSetSDWebImageHeader;
    [cell.imageView sd_setImageWithURL:url placeholderImage:kPlaceholderImage];

    return cell;
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CYTDealerAuthFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CYTDealerAuthFooterView" forIndexPath:indexPath];
    footerView.numberLabel.text = [NSString stringWithFormat:@"共%ld张",self.viewModel.listArray.count];
    return footerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    float height = (self.viewModel.listArray.count >0)?(CYTAutoLayoutV(80)):0.1;
    return CGSizeMake(kScreenWidth, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __block NSMutableArray *photoArray = [NSMutableArray array];
    
    [self.viewModel.listArray enumerateObjectsUsingBlock:^(CYTDealerAuthImageModel * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *cellImageView = ((CYTDealerAuthImageCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]]).imageView;
        
        CYTAlbumModel *albumModel = [CYTAlbumModel new];
        albumModel.prviewFrame = [cellImageView convertRect:cellImageView.bounds toView:nil];
        albumModel.prviewImage = cellImageView.image;
        albumModel.imageURL = item.imageUrl;
        [photoArray addObject:albumModel];
    }];
    
    
    CYTPhotoBrowseViewController *photoBrowseViewController = [[CYTPhotoBrowseViewController alloc] init];
    photoBrowseViewController.showAnimation = YES;
    photoBrowseViewController.albumModels = photoArray;
    photoBrowseViewController.photoIndex = indexPath.item;
    [photoBrowseViewController showPhotoBrowseViewWithAnimation];
}

#pragma mark - DZNEmptyDataSetDelegate & DZNEmptyDataSetSource
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return self.dznCustomView;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return self.dznCustomViewModel.shouldDisplay;
}

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.dznCustomViewModel.dznOffsetY;
}

#pragma mark- get
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(CYTAutoLayoutH(30), CYTAutoLayoutH(30), 0, CYTAutoLayoutH(30));
        float itemSpace = CYTAutoLayoutH(15);
        float itemWidth = (kScreenWidth-2*CYTAutoLayoutH(30)-2*itemSpace)/3;
        layout.itemSize = CGSizeMake(itemWidth,itemWidth);

        //纵向距离
        layout.minimumLineSpacing = itemSpace;
        //横向距离
        layout.minimumInteritemSpacing = 1;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CYTDealerAuthImageCell class] forCellWithReuseIdentifier:@"CYTDealerAuthImageCell"];
        [_collectionView registerClass:[CYTDealerAuthFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CYTDealerAuthFooterView"];
        
    }
    return _collectionView;
}

#pragma mark- get
- (FFDZNCustomView *)dznCustomView {
    if (!_dznCustomView) {
        _dznCustomView = [[FFDZNCustomView alloc] initWithViewModel:self.dznCustomViewModel];
        _dznCustomView.type = DZNViewTypeEmpty;
        
    }
    return _dznCustomView;
}

- (FFDZNCustomViewModel *)dznCustomViewModel {
    if (!_dznCustomViewModel) {
        _dznCustomViewModel = [[FFDZNCustomViewModel alloc] init];
    }
    return _dznCustomViewModel;
}

- (CYTDealerAuthImageVM *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTDealerAuthImageVM new];
    }
    return _viewModel;
}

- (void)dealloc {
    [self.viewModel.request cancelCurrentTask];
}

@end
