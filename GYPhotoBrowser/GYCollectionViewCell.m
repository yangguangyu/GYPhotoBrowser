//
//  GYCollectionViewCell.m
//  GYPhotoBrowser
//
//  Created by yangguangyu on 17/2/20.
//  Copyright © 2017年 yangguangyu. All rights reserved.
//

#import "GYCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface GYCollectionViewCell () <UIScrollViewDelegate>

@end

@implementation GYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];//这里也被坑了，不能用frame
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.maximumZoomScale = 2;
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.delegate = self;
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.userInteractionEnabled = YES;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
    [_imageView addGestureRecognizer:tap];
    
    [_scrollView addSubview:_imageView];
    [self.contentView addSubview:_scrollView];
    
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeStart = 0;
    layer.strokeEnd = 0;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = CGRectMake(0, 0, 80, 80);
    //    layer.position = cell.imageView.center;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.imageView.layer addSublayer:layer];
    
    layer.lineWidth = 10;
    layer.path = [UIBezierPath bezierPathWithOvalInRect:layer.frame].CGPath;
    
    
    //    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    //    anim.keyPath = @"strokeStart";
    //    anim.fromValue = @(0);//动画是一个连续的，只有几个关键状态的点，而且还是有执行时间的，不能根据进度值灵活的控制界面的变化，还是要考绘图来完成
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = (CGFloat)receivedSize / expectedSize;
        NSLog(@"%f",progress);
        
        //        NSLog(@"%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{//这里被坑了，多线程去下载，我说怎么刷新不出动画
            layer.strokeEnd = progress;//就是在不停重绘
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [layer removeFromSuperlayer];
        [self layoutSubviews];
    }];
}


- (void)layoutSubviews {//使用frame布局，必须在这里写
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    
    //_imaggeView的大小需要依据图片来确定
    if (_imageView.image) {
        
        CGSize size =  _imageView.image.size;
        CGFloat ratio =  self.bounds.size.width/size.width;
        CGFloat width = _scrollView.frame.size.width;  //以宽度为基准，等比缩放
        CGFloat height = size.height * ratio;
        
        _imageView.frame = CGRectMake(0, 0, width, height);
        _imageView.center = _scrollView.center;
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    _imageView.center = scrollView.center;
    NSLog(@"%@---%@",NSStringFromCGPoint(scrollView.contentOffset),NSStringFromCGSize(scrollView.contentSize));
}
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    view.center = scrollView.center;
//}




- (void)imageTaped:(UIGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(CollectionViewCell:didTapImageView:)]) {
        [self.delegate CollectionViewCell:self didTapImageView:(UIImageView *)tap.view];
    }
}


@end
