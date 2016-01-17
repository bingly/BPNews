//
//  AppDelegate.m
//  BPNews
//
//  Created by bingcai on 16/1/16.
//  Copyright © 2016年 bingcai. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    self.window.rootViewController = [self setRootVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UITabBarController *) setRootVC {

    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainVC.title = @"网易";
    mainNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"网易" image:[UIImage imageNamed:@"tabbar_icon_news_normal"] tag:0];
    
    UIViewController *secondVC = [[UIViewController alloc] init];
    UINavigationController *secNVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    secondVC.title = @"阅读";
    secNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"阅读" image:[UIImage imageNamed:@"tabbar_icon_reader_normal"] tag:1];

    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[mainNVC, secNVC];
    
    
    [UITabBar appearance].tintColor = [UIColor redColor];
    
    return tabVC;
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
