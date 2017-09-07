//
//  AppDelegate.m
//  i3MSConnecter
//
//  Created by i3 on 2017/8/11.
//  Copyright © 2017年 com.breo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MSFriendController.h"
#import "MSHelpController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBarController *tab = [UITabBarController new];
    UIViewController *vc1 = [ViewController new];
    UIViewController *vc2 = [MSFriendController new];
    UIViewController *vc3 = [MSHelpController new];
    vc1.title = @"添加好友";
    CGSize size = CGSizeMake(35, 35);
    vc1.tabBarItem.image = [self reSizeImage:[UIImage imageNamed:@"添加好友"] toSize:size];
    vc1.tabBarItem.selectedImage = [self reSizeImage:[UIImage imageNamed:@"添加好友-2"] toSize:size];
    vc2.title = @"好友列表";
    vc2.tabBarItem.image = [self reSizeImage:[UIImage imageNamed:@"列表-2"] toSize:size];
    vc2.tabBarItem.selectedImage = [self reSizeImage:[UIImage imageNamed:@"列表"] toSize:size];
    
    vc3.title = @"使用说明";
    vc3.tabBarItem.image = [self reSizeImage:[UIImage imageNamed:@"帮助-2"] toSize:size];
    vc3.tabBarItem.selectedImage = [self reSizeImage:[UIImage imageNamed:@"帮助"] toSize:size];
    tab.viewControllers = @[vc2,vc1,vc3];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
