//
//  AppDelegate.m
//  FishTalk
//
//  Created by Ahmed Mostafa Hanafy on 2/29/16.
//  Copyright © 2016 Ahmed Mostafa Hanafy. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CatchesViewController.h"
#import "FriendsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //UIStoryboard* storyboard;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"])
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController* tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"TabVC"];
        
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
        navigationController.navigationBarHidden = YES;
        
        /*
        storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
        HomeViewController* mainVC = [storyboard instantiateViewControllerWithIdentifier:@"home"];
        
        storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:[NSBundle mainBundle]];
        FriendsViewController* friendsVC = [storyboard instantiateViewControllerWithIdentifier:@"friends"];
        
        storyboard = [UIStoryboard storyboardWithName:@"Catches" bundle:[NSBundle mainBundle]];
        CatchesViewController* catchesVC = [storyboard instantiateViewControllerWithIdentifier:@"catches"];
        
        UITabBarController* tabBarController = [[UITabBarController alloc] init];
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
        navigationController.navigationBarHidden = YES;
        [tabBarController setViewControllers:[NSArray arrayWithObjects:mainVC, friendsVC, catchesVC, nil]];
        
        [[tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
        [[tabBarController.tabBar.items objectAtIndex:1] setTitle:@"Friends"];
        [[tabBarController.tabBar.items objectAtIndex:2] setTitle:@"Catches"];
//        [[tabBarController.tabBar.items objectAtIndex:3] setTitle:@"Locations"];
        
        [[tabBarController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"Home"]];
        [[tabBarController.tabBar.items objectAtIndex:0] setSelectedImage:[UIImage imageNamed:@"HomeSelected"]];
        [[tabBarController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"Friends"]];
        [[tabBarController.tabBar.items objectAtIndex:1] setSelectedImage:[UIImage imageNamed:@"FriendsSelected"]];
        [[tabBarController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"Catches"]];
        [[tabBarController.tabBar.items objectAtIndex:2] setSelectedImage:[UIImage imageNamed:@"CatchesSelected"]];
       */
        [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"buttom bar3.png"]];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:42.0/255.0 green:205.0/255.0 blue:255.0/255.0 alpha:1.0]} forState:UIControlStateSelected];
        
        [tabBarController setSelectedIndex:0];
        
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
    }
    
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
