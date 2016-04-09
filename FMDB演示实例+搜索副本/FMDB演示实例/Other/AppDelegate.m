//
//  AppDelegate.m
//  FMDB演示实例
//
//  Created by 袁新峰 on 15/11/17.
//  Copyright © 2015年 袁新峰. All rights reserved.
//

#import "AppDelegate.h"

#import "YXFAddressViewController.h"

#import "YXFAddUserViewController.h"
#import "YXFSearchViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    YXFAddressViewController *addressVC = [[YXFAddressViewController alloc] init];
    UINavigationController *addressNC = [[UINavigationController alloc] initWithRootViewController:addressVC];
    addressNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:101];
    
    YXFAddUserViewController *addUserVC = [[YXFAddUserViewController alloc] init];
    UINavigationController *addUserNC = [[UINavigationController alloc] initWithRootViewController:addUserVC];
    addUserNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:102];
    
    YXFSearchViewController *searchVC = [[YXFSearchViewController alloc] init];
    UINavigationController *searchNC = [[UINavigationController alloc] initWithRootViewController:searchVC];
    searchNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:103];
    
    
    tabbar.viewControllers = @[addressNC,addUserNC,searchNC];
    
    self.window.rootViewController = tabbar;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
