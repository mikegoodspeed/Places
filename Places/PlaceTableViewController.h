//
//  PlaceTableViewController.h
//  Places
//
//  Created by Mike Goodspeed on 7/27/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceTableViewController : UITableViewController
{
    NSString *placeId_;
    NSArray *photos_;
}

- (id)initWithPlaceId:(NSString *)placeId AndTitle:(NSString *)title;

@end
