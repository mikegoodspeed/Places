//
//  PlacesAppDelegate.h
//  Places
//
//  Created by Mike Goodspeed on 7/9/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesAppDelegate : NSObject <UIApplicationDelegate>
{
    UITabBarController *tb_;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tb;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
