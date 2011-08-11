//
//  PhotoViewController.m
//  Places
//
//  Created by Mike Goodspeed on 7/27/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController()
@property (nonatomic, copy) NSString *photoId;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *farm;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, retain) NSData *imgData;
@end

@implementation PhotoViewController

@synthesize photoId = photoId_;
@synthesize secret = secret_;
@synthesize farm = farm_;
@synthesize server = server_;
@synthesize imgData = imgData_;

- (NSData *)imgData
{
    if (!imgData_)
    {
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.photoId, @"id",
                              self.secret, @"secret",
                              self.farm, @"farm",
                              self.server, @"server", nil];
        imgData_ = [FlickrFetcher
                    imageDataForPhotoWithFlickrInfo:info
                    format:FlickrFetcherPhotoFormatLarge];
    }
    return imgData_;
}

- (id)initWithPhotoId:(NSString *)photoId
               secret:(NSString *)secret
                 farm:(NSString *)farm
               server:(NSString *)server
                title:(NSString *)title
{
    self = [super init];
    if (self)
    {
        self.photoId = photoId;
        self.secret = secret;
        self.farm = farm;
        self.server = server;
        self.title = title;
    }
    return self;
}

- (void)dealloc
{
    [photoId_ release];
    [secret_ release];
    [farm_ release];
    [server_ release];
    [imgData_ release];
    [super dealloc];
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{    
    UIImage *image = [UIImage imageWithData:self.imgData];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize = image.size;
    scrollView.minimumZoomScale = 0.07;
    scrollView.maximumZoomScale = 1.0;
    scrollView.zoomScale = 0.7;
    scrollView.delegate = self;
    [scrollView addSubview:imgView];
    self.view = scrollView;
    [scrollView release];
    [imgView release];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // return the imgView inside the scrollView inside self.view
    return [[[[self.view subviews] lastObject] subviews] lastObject];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
