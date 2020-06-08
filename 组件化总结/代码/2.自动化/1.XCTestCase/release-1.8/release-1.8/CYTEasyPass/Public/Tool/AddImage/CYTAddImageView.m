//
//  CYTAddImageView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddImageView.h"
#import "CYTImageFileModel.h"

@interface CYTAddImageView()

/** 添加按钮 */
@property (weak, nonatomic) UIButton *addImgeBtn;
/** 图片 */
@property (strong, nonatomic) NSMutableArray *imageViwes;
/** 图片资源 */
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *imageModelArray;
///删除数组
@property (nonatomic, strong) NSMutableArray *deleteModelArray;
@property (nonatomic, strong) NSMutableArray *deleteIndexArray;

///数据模型
@property (nonatomic, strong) CYTAddImageModel *model;

///当前是否为编辑模式
@property (nonatomic, assign) BOOL editing;


@end

@implementation CYTAddImageView

- (NSMutableArray *)imageViwes{
    if (!_imageViwes) {
        _imageViwes = [NSMutableArray array];
    }
    return _imageViwes;
}

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithModel:nil];
}

- (instancetype)initWithModel:(CYTAddImageModel *)model {
    if (self = [super initWithFrame:CGRectZero]) {
        _model = model;
        _editing = NO;
        _deleteModelArray = [NSMutableArray array];
        _deleteIndexArray = [NSMutableArray array];
        [self addImageBasicConfig];
        [self initAddImageComponents];
        [self initImageComponents];
    }
    return  self;
}


/**
 *  基本配置
 */
- (void)addImageBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:CYTDeletePhotoAddImageViewKey object:nil] subscribeNext:^(NSNotification *note) {
        @strongify(self);
        [self handleImageDeleteNotification:note];
    }];
}

///加载图片
- (void)initImageComponents {
    for (int i=0; i<self.model.imageModelArray.count; i++) {
        CYTImageFileModel *model = self.model.imageModelArray[i];
        self.selectImageModel = model;
    }
}

/**
 *  初始化子控件
 */
- (void)initAddImageComponents{
    //添加按钮
    UIButton *addImgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addImgeBtn setBackgroundImage:[UIImage imageNamed:@"bg_add_dl"] forState:UIControlStateNormal];
    [self addSubview:addImgeBtn];
    _addImgeBtn = addImgeBtn;
    [[addImgeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.addBtnClickBack?:self.addBtnClickBack();
    }];
    [addImgeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.size.equalTo(CGSizeMake(self.model.imageWH, self.model.imageWH));
    }];
}

- (float)imageWH {
    return self.model.imageWH;
}

#pragma mark- 处理图片删除情况
- (void)handleImageDeleteNotification:(NSNotification *)note {
    if ([note.object isKindOfClass:[NSNumber class]]) {
        //model
        NSInteger index = [note.object integerValue];
        
        if (self.images.count>index) {
            [self.images removeObjectAtIndex:index];
        }
        
        if (index<self.imageViwes.count) {
            UIImageView *imgView = self.imageViwes[index];
            [self.imageViwes removeObjectAtIndex:index];
            [imgView removeFromSuperview];
        }
    }else {
        //image
        NSMutableArray *tempImageViews = [NSMutableArray array];
        UIImage *deleteImage = note.object;
        [self.images removeObject:deleteImage];
        //删除图片
        [self.imageViwes enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
            if ([imageView.image isEqual:deleteImage] ) {
                [tempImageViews addObject:imageView];
                [imageView removeFromSuperview];
            }
        }];
        
        [self.imageViwes removeObjectsInArray:tempImageViews];
    }
    
    //重新布局所有视图
    [self layoutAllViews];
}

- (void)layoutAllViews {
    if (self.images.count < self.model.imageMaxNum) {
        _addImgeBtn.hidden = NO;
    }
    
    //布局所有 imageview
    for (int i=0; i<self.imageViwes.count; i++) {
        UIImageView *imageView = self.imageViwes[i];
        [self layoutView:imageView withIndex:i isAddButton:NO];
    }
    
    //布局addButton
    [self layoutView:self.addImgeBtn withIndex:self.imageViwes.count isAddButton:YES];
}

#pragma mark- 新增图片
- (void)setSelectImage:(UIImage *)selectImage{
    _selectImage = selectImage;
    
    //添加图片资源
    if (!selectImage) {
        return;
    };
    if (self.images.count>=self.model.imageMaxNum) {
        return;
    }
    [self.images addObject:selectImage];
    
    //addButton显示隐藏
    if (self.images.count >= self.model.imageMaxNum) {
        _addImgeBtn.hidden = YES;
    }

    [self layoutImageViewsWithModel:nil orImageData:selectImage];
}

- (void)setSelectImageModel:(CYTImageFileModel *)selectImageModel {
    _selectImageModel = selectImageModel;
    
    //添加图片资源
    if (!selectImageModel) {
        return;
    }
    if (self.images.count>=self.model.imageMaxNum) {
        return;
    }
    [self.images addObject:selectImageModel];
    
    //addButton显示隐藏
    if (self.images.count >= self.model.imageMaxNum) {
        _addImgeBtn.hidden = YES;
    }
    if (self.model.type == AddImageTypeShow) {
        _addImgeBtn.hidden = YES;
    }
    
    [self layoutImageViewsWithModel:selectImageModel orImageData:nil];
}

#pragma mark- getImageView
- (UIImageView *)getImageViewWithModel:(CYTImageFileModel *)fileModel orImageData:(UIImage *)imageData {
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectButton setImage:[UIImage imageNamed:@"carSource_publish_imageNor"] forState:UIControlStateNormal];
    selectButton.userInteractionEnabled = NO;
    selectButton.alpha = 0;
    selectButton.exState = 0;
    [imageView addSubview:selectButton];
    [selectButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutH(40));
        make.right.equalTo(-CYTAutoLayoutH(10));
        make.bottom.equalTo(-CYTAutoLayoutH(10));
    }];
    
    if (fileModel) {
        //使用数据模型
        if (fileModel.imageData) {
            //存在
            imageView.image = fileModel.imageData;
        }else {
            //使用url
            NSString *urlString = fileModel.thumbnailUrl;
            if (urlString.length==0) {
                urlString = (fileModel.url)?fileModel.url:@"";
            }
            [imageView sd_setImageWithURL:[NSURL URLWithString:fileModel.url] placeholderImage:[UIImage imageNamed:@"carSource_carDefault"]];
        }
    }else {
        //使用uiimage
        imageView.image = imageData;
    }
    
    //图片添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSInteger index = [self.imageViwes indexOfObject:imageView];
        
        if (self.editing) {
            //获取selectbutton
            NSArray *subViews = imageView.subviews;
            UIButton *button = (subViews.count>0)?subViews[0]:nil;
            if (button) {
                button.exState = !button.exState;
                if (button.exState) {
                    [self.deleteModelArray addObject:self.images[index]];
                    [self.deleteIndexArray addObject:@(index)];
                    [button setImage:[UIImage imageNamed:@"carSource_publish_imageSel"] forState:UIControlStateNormal];
                }else {
                    [self.deleteModelArray removeObject:self.images[index]];
                    [self.deleteIndexArray removeObject:@(index)];
                    [button setImage:[UIImage imageNamed:@"carSource_publish_imageNor"] forState:UIControlStateNormal];
                }
            }
            
            //回调数据
            if (self.deleteBlock) {
                self.deleteBlock(self.deleteIndexArray);
            }
        }else {
            !self.imageViewClickBack?:self.imageViewClickBack(self.images.mutableCopy,index);
        }
    }];
    [imageView addGestureRecognizer:tap];
    
    return imageView;
}

#pragma mark- editMode
- (void)deleteActionAffirm {
    //删除数据重新布局
    for (CYTImageFileModel *model in self.deleteModelArray) {
        if ([self.images containsObject:model]) {
            NSInteger index = [self.images indexOfObject:model];
            
            if (index<self.imageViwes.count) {
                UIImageView *imgView = self.imageViwes[index];
                [self.imageViwes removeObjectAtIndex:index];
                [imgView removeFromSuperview];
            }
            [self.images removeObject:model];
        }
    }
    
    
    [self.deleteIndexArray removeAllObjects];
    [self.deleteModelArray removeAllObjects];
    [self layoutAllViews];
    [self.superview layoutIfNeeded];
}

- (void)editMode:(BOOL)editing withAnimate:(BOOL)animate {
    self.editing = editing;
    
    //1、显示隐藏addbutton
    float alp = (editing)?0:1;
    float height = [self getAddButtonHeight];
    
    [self.addImgeBtn updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
    [UIView animateWithDuration:kAnimationDurationInterval animations:^{
        self.addImgeBtn.alpha = alp;
        [self.superview layoutIfNeeded];
        
    }];
    
    //2、显示选中标志,默认都是非选中
    for (UIImageView *imageView in self.imageViwes) {
        NSArray *subViews = imageView.subviews;
        UIImageView *selectImageView = (subViews.count>0)?subViews[0]:nil;
        if (selectImageView) {
            [UIView animateWithDuration:kAnimationDurationInterval animations:^{
                selectImageView.alpha = 1.0-alp;
            }];
        }
    }
    
    //数据处理
    self.deleteModelArray = [NSMutableArray array];
    self.deleteIndexArray = [NSMutableArray array];
    
}

- (void)cleanSelect {
    for (UIImageView *imageView in self.imageViwes) {
        NSArray *subViews = imageView.subviews;
        UIButton *button = (subViews.count>0)?subViews[0]:nil;
        if (button) {
            button.exState = 0;
            [button setImage:[UIImage imageNamed:@"carSource_publish_imageNor"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark- 布局
- (void)layoutImageViewsWithModel:(CYTImageFileModel *)fileModel orImageData:(UIImage *)imageData{
    //获取新增加的imageView
    UIImageView *imageView = [self getImageViewWithModel:fileModel orImageData:imageData];
    [self addSubview:imageView];
    [self.imageViwes addObject:imageView];
    
    //布局imageView；
    [self layoutView:imageView withIndex:self.imageViwes.count-1 isAddButton:NO];
    
    //布局addButton；
    [self layoutView:self.addImgeBtn withIndex:self.imageViwes.count isAddButton:YES];
}

- (void)layoutView:(UIView *)theView withIndex:(NSInteger)index isAddButton:(BOOL)isAddButton {
    
    //根据index计算行、列
    NSInteger hang = index/self.model.perLineNum;
    NSInteger lie = index%self.model.perLineNum;
    
    //根据行、列计算 横纵坐标
    float viewX = (imageMargin + self.model.imageWH)*lie;
    float viewY = (imageMargin + self.model.imageWH)*hang;
    
    //区分是不是addButton并对view进行布局约束
    [theView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewX);
        make.top.equalTo(viewY);
        if (isAddButton) {
            make.bottom.equalTo(0);
            make.width.equalTo(self.model.imageWH);
            make.height.equalTo([self getAddButtonHeight]);
        }else{
            make.width.height.equalTo(self.model.imageWH);
        }
    }];
}

- (float)getAddButtonHeight {
    
    //对于后期使用数据模型的情况有效,兼容以前的情况，因为以前的使用不会传递type参数，那么默认就是0--》edit模式
    if (self.model.type == AddImageTypeShow || self.editing) {
        //show
        NSInteger imageHang = (self.imageViwes.count-1)/self.model.perLineNum;
        NSInteger addButtonHang = self.imageViwes.count/self.model.perLineNum;
        if (imageHang == addButtonHang) {
            return self.model.imageWH;
        }else {
            return 0;
        }
    }else {
        //edit
        if (self.imageViwes.count == self.model.imageMaxNum) {
            //是最大值
            //判断和最后一个图片是不是在同一行
            if (self.imageViwes.count == 0) {
                return self.model.imageWH;
            }else {
                NSInteger imageHang = (self.imageViwes.count-1)/self.model.perLineNum;
                NSInteger addButtonHang = self.imageViwes.count/self.model.perLineNum;
                if (imageHang == addButtonHang) {
                    return self.model.imageWH;
                }else {
                    return 0;
                }
            }
        }else {
            //没有到达最大值
            return self.model.imageWH;
        }
    }
}


@end
