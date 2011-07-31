//
//  PhotoViewController.h
//  Places
//
//  Created by Mike Goodspeed on 7/27/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController <UIScrollViewDelegate>
{
    NSString *photoId_;
    NSString *secret_;
    NSString *farm_;
    NSString *server_;
    NSData *data_;
}

- (id)initWithPhotoId:(NSString *)photoId
               Secret:(NSString *)secret
                 Farm:(NSString *)farm
               Server:(NSString *)server;
@end
