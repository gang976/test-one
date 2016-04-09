//
//  LSTCustomTabBarController.m
//  LiShanTu
//
//  Created by mac on 16/3/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LSTCustomTabBarController.h"

@interface LSTCustomTabBarController ()

@end

@implementation LSTCustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imageName = @[@"home_gray",@"find_gray",@"message_gray",@"me_gray"];
    NSArray *selectimageName = @[@"home_black",@"find_black",@"message_black",@"me_black"];
    
    NSArray *name = @[@"首页",@"发现",@"消息",@"我的"];
    
    for (UINavigationController *nvc in self.viewControllers) {
        UIViewController *vc = nvc.viewControllers[0];
        
        NSInteger index = [self.viewControllers indexOfObject:nvc];
        vc.tabBarItem.image = [UIImage imageNamed:imageName[index]];
        vc.tabBarItem.title = name[index];
        UIImage *selectimage = [[UIImage imageNamed:selectimageName[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = selectimage;
        
        [vc setValue:@(index) forKey:@"index"];
        
    }
    

    
    
}


@end









