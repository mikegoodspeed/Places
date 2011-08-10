//
//  PlacesAppDelegate.m
//  Places
//
//  Created by Mike Goodspeed on 7/9/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PlacesAppDelegate.h"
#import "TopRatedTableViewController.h"
#import "MostRecentTableViewController.h"

@implementation PlacesAppDelegate

@synthesize tb = tb_;
@synthesize window=_window;

- (void)dealloc
{
    [tb_ release];
    [_window release];
    [super dealloc];
}

- (BOOL)              application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.tb = [[UITabBarController alloc] init];
    
    UINavigationController *trnc = [[UINavigationController alloc] init];
    TopRatedTableViewController *trtvc = [[TopRatedTableViewController alloc]
                                          init];
    [trnc pushViewController:trtvc animated:NO];
    
    UINavigationController *mrnc = [[UINavigationController alloc] init];
    MostRecentTableViewController *mrtvc = [[MostRecentTableViewController alloc]
                                            init];
    [mrnc pushViewController:mrtvc animated:NO];
    
    self.tb.viewControllers = [NSArray arrayWithObjects: trnc, mrnc, nil];
    [self.window addSubview:self.tb.view];
    [self.window makeKeyAndVisible];
    [trtvc release];
    [trnc release];
    [mrtvc release];
    [mrnc release];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
