//
//  ViewController.m
//  GYPhotoBrowser
//
//  Created by yangguangyu on 17/2/19.
//  Copyright © 2017年 yangguangyu. All rights reserved.
//

#import "ViewController.h"
#import "GYPhotoBrowserVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *imageUrls = @[
                     @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                     @"http://img.taopic.com/uploads/allimg/121203/267873-121203225I999.jpg",
                     @"http://img.taopic.com/uploads/allimg/140316/235039-14031614000099.jpg",
                     @"http://www.sinaimg.cn/dy/slidenews/52_img/2014_18/42283_345383_769322.gif"
                     
                     ];
    GYPhotoBrowserVC *vc = [[GYPhotoBrowserVC alloc] initWithImageURLs:imageUrls index:3];
    
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
