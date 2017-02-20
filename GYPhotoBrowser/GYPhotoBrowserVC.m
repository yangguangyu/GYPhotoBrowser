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

//@property (nonatomic, strong) NSArray *<#name#>;


@end

@implementation GYPhotoBrowserVC


- (instancetype)initWithImageURLs:(NSArray *)imageURLs {
    
    if (self = [super init]) {
        _imageUrls = imageURLs;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片数组
    //显示图片 - 图片可以缩放（scrollView）- 原始的大小
    
    //1.创建collectionview
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    _collectionView.backgroundColor = [UIColor grayColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
//    _collectionView.bounces = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[GYCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

    
}

@end
