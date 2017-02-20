//
//  GYCollectionViewCell.h
//  GYPhotoBrowser
//
//  Created by yangguangyu on 17/2/20.
//  Copyright © 2017年 yangguangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYCollectionViewCell;
@protocol GYCollectionViewCellDelegate <NSObject>

- (void)CollectionViewCell:(GYCollectionViewCell *)cell didTapImageView:(UIImageView *)imageView;

@end

@interface GYCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, weak) id<GYCollectionViewCellDelegate> delegate;

@end
