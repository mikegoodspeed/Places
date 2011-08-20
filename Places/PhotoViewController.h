//
//  PhotoViewController.h
//  Places
//
//  Created by Mike Goodspeed on 7/27/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MostRecentTableViewController.h"

@interface PhotoViewController : UIViewController <UIScrollViewDelegate>
{
    NSString *photoId_;
    NSString *secret_;
    NSString *farm_;
    NSString *server_;
    NSString *description_;
    NSData *imgData_;
    UIScrollView *scrollView_;
    UIImageView *imgView_;
}

- (id)initWithPhotoId:(NSString *)photoId
               secret:(NSString *)secret
                 farm:(NSString *)farm
               server:(NSString *)server
                title:(NSString *)title
          description:(NSString *)description;
@end
