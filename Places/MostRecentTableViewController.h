//
//  MostRecentTableViewController.h
//  Places
//
//  Created by Mike Goodspeed on 7/9/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MostRecentTableViewController : UITableViewController
{
    NSMutableArray *photoList_;
}

- (void)addPhotoWithPhotoId:(NSString *)photoId
                     secret:(NSString *)secret
                       farm:(NSString *)farm
                     server:(NSString *)server
                      title:(NSString *)title
                description:(NSString *)description;
@end
