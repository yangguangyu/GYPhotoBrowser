//
//  GYPhotoBrowserVC.m
//  GYPhotoBrowser
//
//  Created by yangguangyu on 17/2/19.
//  Copyright © 2017年 yangguangyu. All rights reserved.
//

#import "GYPhotoBrowserVC.h"
#import "UIView+YGYAdd.h"
#import "UtilsMacro.h"
#import "UIImageView+WebCache.h"
#import "GYCollectionViewCell.h"

@interface GYPhotoBrowserVC () <UICollectionViewDelegate,UICollectionViewDataSource,GYCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, strong) UIButton *saveButton;

//@property (nonatomic, strong) NSArray *<#name#>;


@end

@implementation GYPhotoBrowserVC


- (instancetype)initWithImageURLs:(NSArray *)imageURLs index:(NSUInteger)index{
    
    if (self = [super init]) {
        _imageUrls = imageURLs;
        _index = index;
        if (_index>=_imageUrls.count) {
            _index = _imageUrls.count-1;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片数组
    //显示图片 - 图片可以缩放（scrollView）- 原始的大小
    
    //1.创建collectionview
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
//    _collectionView.bounces = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[GYCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
    
    _indexLabel = [[UILabel alloc] init];
    _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",_index+1,_imageUrls.count];
    _indexLabel.textColor = GrayColor(50);
    _indexLabel.backgroundColor = [UIColor redColor];
    _indexLabel.font = Font(14);
    _indexLabel.numberOfLines = 0;
    _indexLabel.userInteractionEnabled = YES;
    _indexLabel.textAlignment = NSTextAlignmentCenter;

    [_indexLabel sizeToFit];
    [self.view addSubview:_indexLabel];
    
    //滚动到index位置
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:0 animated:NO];
    
    UIButton *saveButton = [[UIButton alloc] init];
    self.saveButton = saveButton;
    saveButton.backgroundColor = [UIColor redColor];
    [saveButton sizeToFit];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
}

- (void)saveButtonClick {
    //保存到相册
    GYCollectionViewCell *cell = [_collectionView visibleCells][0];
    UIImageWriteToSavedPhotosAlbum(cell.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        NSLog(@"图片保存成功");
    }else {
        NSLog(@"图片保存失败");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _indexLabel.frame = CGRectMake(0, 40, _indexLabel.width+20, _indexLabel.height+6);
    _indexLabel.centerX = self.view.centerX;
    _indexLabel.layer.cornerRadius = _indexLabel.height*0.5;
    _indexLabel.layer.masksToBounds = YES;
    
    _saveButton.frame = CGRectMake(50, self.view.height-100, _saveButton.width+20, _saveButton.height+6);
    _saveButton.layer.cornerRadius = _saveButton.height*0.5;
    _saveButton.layer.masksToBounds = YES;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = self.view.size;
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _layout;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.imageUrl = _imageUrls[indexPath.item];
    return cell;
}

//这里加了没用，scrollView好像可以拦截点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:self completion:nil];
}


- (void)CollectionViewCell:(GYCollectionViewCell *)cell didTapImageView:(UIImageView *)imageView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //切换到下一张时，需要把之前的scale恢复
    for (int i = 0; i < _collectionView.subviews.count; ++i) {
        if ([_collectionView.subviews[i] isKindOfClass:[GYCollectionViewCell class]]) {
            GYCollectionViewCell *cell = _collectionView.subviews[i];
            cell.scrollView.zoomScale = 1;
        }
    }
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    _indexLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,_imageUrls.count];//从1计数

    
}

@end
