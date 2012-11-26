//
//  AppDelegate.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 25.03.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window, navigationController = _navigationController, menuGroups, currentGroup, currentOrder, currentMenuItem, currentOrderItem, orderItems, orderChecked, code, loggedIn, user, orderSumm;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [ServerAPI serverWithBaseURL: [NSURL URLWithString: @"http://app0.emsolutions.ru"]];
    
    self.orderChecked = NO;
    self.loggedIn = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.navigationController = [[UINavigationController alloc] initWithRootViewController: [[MainViewController alloc] initWithNibName:@"MainViewController" bundle: [NSBundle mainBundle]]];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end