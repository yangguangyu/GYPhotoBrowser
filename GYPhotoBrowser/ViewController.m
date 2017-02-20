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
    GYPhotoBrowserVC *vc = [[GYPhotoBrowserVC alloc] init];
    vc.imageUrls = @[
                     @"http://img.taopic.com/uploads/allimg/121203/267873-121203225I999.jpg",
                     @"http://img.taopic.com/uploads/allimg/140316/235039-14031614000099.jpg"];
    
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


@end
