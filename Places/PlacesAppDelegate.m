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
    [self.tb release];
    self.tb.delegate = self;
    
    UINavigationController *trnc = [[UINavigationController alloc] init];
    TopRatedTableViewController *trtvc =
        [[TopRatedTableViewController alloc] init];
    [trnc pushViewController:trtvc animated:NO];
    
    UINavigationController *mrnc = [[UINavigationController alloc] init];
    MostRecentTableViewController *mrtvc =
        [[MostRecentTableViewController alloc] init];
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

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]])
    {
        [((UINavigationController *) viewController)
         popToRootViewControllerAnimated:NO];
    }
}
@end
