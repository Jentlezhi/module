//
//  CYTPhontoPreviewViewController.m
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhontoPreviewViewController.h"
#import "CYTPhotoCollectionViewCell.h"
#import "CYTImageFileModel.h"

static NSString *const identifier = @"CYTPhotoCollectionViewCell";

@interface CYTPhontoPreviewViewController()<UICollectionViewDataSource,UICollectionViewDelegate>
/** 表格 */
@property(strong, nonatomic) UICollectionView *photoCollectionView;
/** 当前item位置 */
@property(strong, nonatomic) NSIndexPath *currentIndexPath;

@end

@implementation CYTPhontoPreviewViewController

- (UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        layout.minimumLineSpacing = 0;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_photoCollectionView registerClass:[CYTPhotoCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.pagingEnabled = YES;
        _photoCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _photoCollectionView;
}

- (NSIndexPath *)currentIndexPath{
    if (!_currentIndexPath) {
        _currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    return _currentIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self phontoPreviewBasicConfig];
    [self initPhontoPreviewComponents];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.hiddeNnavigationBar) {
        [self showNavigationBarWithAnimation:NO];
    }
    
}

/**
 *  基本配置
 */
- (void)phontoPreviewBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"图片预览"];
    self.interactivePopGestureEnable = YES;
    
    //跳转到点击图片位置
    [self.view layoutIfNeeded];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    [self.photoCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //图片索引修改
    [self scrollViewDidEndDecelerating:self.photoCollectionView];
}

///是否可以编辑
- (BOOL)canEditImage {
    BOOL canEdit = NO;
    
    if (!self.images || self.images.count == 0) {
        //如果数组是空的则不可编辑
    }else {
        if ([self.images[0] isKindOfClass:[CYTImageFileModel class]]) {
            //数据模型
            canEdit = self.canEdit;
        }else {
            //其他
            if (self.netImage) {
                canEdit = NO;
            }else {
                canEdit = YES;
            }
        }
    }
    return canEdit;
}

/**
 *  初始化子控件
 */
- (void)initPhontoPreviewComponents{
    
    if ([self canEditImage]) {
        //添加删除按钮
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"ic_garbageic_hl"] forState:UIControlStateNormal];
        [self.navigationBar addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.navigationBar).offset(-CYTAutoLayoutH(40));
            make.centerY.equalTo(self.navigationBar);
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(44), CYTAutoLayoutV(44)));
            
        }];
        
        [[deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [CYTAlertView alertViewWithTitle:@"提示" message:@"确定要删除该图片吗？" confirmAction:^{
                //删除
                if (self.images.count>self.currentIndexPath.row) {
                    if ([self.images[self.currentIndexPath.item] isKindOfClass:[CYTImageFileModel class]]) {
                        CYTImageFileModel *imageModel = self.images[self.currentIndexPath.item];
                        
                        //先发送外部通知
                        //因为外部需要先获取图片index
                        [[NSNotificationCenter defaultCenter] postNotificationName:CYTDeletePhontoKey object:@(self.currentIndexPath.item)];
                        //addImageView通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:CYTDeletePhotoAddImageViewKey object:@(self.currentIndexPath.item)];
                        
                        [self.images removeObject:imageModel];
                    }else {
                        UIImage *deleteImage = self.images[self.currentIndexPath.item];
                        
                        //先发送外部通知
                        //因为外部需要先获取图片index
                        [[NSNotificationCenter defaultCenter] postNotificationName:CYTDeletePhontoKey object:deleteImage];
                        
                        //addImageView通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:CYTDeletePhotoAddImageViewKey object:deleteImage];
                        
                        [self.images removeObject:deleteImage];
                    }
                    
                    [self.photoCollectionView reloadData];
                    //图片索引修改
                    [self scrollViewDidEndDecelerating:self.photoCollectionView];
                    if (self.images.count == 0) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }

            } cancelAction:nil];

        }];
    }
    
    //布局控件
    [self.view insertSubview:self.photoCollectionView belowSubview:self.navigationZone];
    [self.photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CYTPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //如果是传递数据模型过来
    if ([self.images[indexPath.item] isKindOfClass:[CYTImageFileModel class]]) {
        CYTImageFileModel *model = self.images[indexPath.item];
        if (model.url.length>0) {
            //使用url
            cell.itemImageURL = model.url;
        }else {
            //使用image
            cell.itemImage = model.imageData;
        }
        
    }else {
    //如果是传递image/url过来
        if (self.netImage) {
            cell.itemImageURL = self.images[indexPath.item];
        }else{
            cell.itemImage = self.images[indexPath.item];
        }
    }
    
    CYTWeakSelf
    cell.cellClickBack = ^{
        [weakSelf showOrHiddenNavigationBarWithAnimation:YES];
    };
    self.currentIndexPath = indexPath;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint itemInView = [self.view convertPoint:self.photoCollectionView.center toView:self.photoCollectionView];
    self.currentIndexPath = [self.photoCollectionView indexPathForItemAtPoint:itemInView];
    NSUInteger currentIndex = (int)(scrollView.contentOffset.x/kScreenWidth + 0.5) + 1;
    //设置图片索引
    if (self.images.count<=1) {
        self.navTitle = @"图片浏览";
    }else if (currentIndex>self.images.count){
        NSString *photoIndex = [NSString stringWithFormat:@"%ld/%lu",self.images.count,(unsigned long)self.images.count];
        self.navTitle = photoIndex;
    }else{
        NSString *photoIndex = [NSString stringWithFormat:@"%ld/%lu",self.currentIndexPath.item+1,(unsigned long)self.images.count];
        self.navTitle = photoIndex;
    }
}

@end
