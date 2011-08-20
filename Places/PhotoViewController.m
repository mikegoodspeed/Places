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
@property (nonatomic, copy) NSString *description;
@property (nonatomic, retain) NSData *imgData;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imgView;
@property (readonly) MostRecentTableViewController *recents;
@end

@implementation PhotoViewController

@synthesize photoId = photoId_;
@synthesize secret = secret_;
@synthesize farm = farm_;
@synthesize server = server_;
@synthesize description = description_;
@synthesize imgData = imgData_;
@synthesize scrollView = scrollView_;
@synthesize imgView = imgView_;

- (NSData *)imgData
{
    if (!imgData_)
    {
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.photoId, @"id",
                              self.secret, @"secret",
                              self.farm, @"farm",
                              self.server, @"server", nil];
        imgData_ = [[FlickrFetcher
                    imageDataForPhotoWithFlickrInfo:info
                    format:FlickrFetcherPhotoFormatLarge] retain];
    }
    return imgData_;
}

- (MostRecentTableViewController *)recents
{
    UITabBarController *tbc = self.tabBarController;
    UINavigationController *nc = [tbc.viewControllers lastObject];
    MostRecentTableViewController *mrtvc = [nc.viewControllers objectAtIndex:0];
    return mrtvc;
}

- (id)initWithPhotoId:(NSString *)photoId
               secret:(NSString *)secret
                 farm:(NSString *)farm
               server:(NSString *)server
                title:(NSString *)title
          description:(NSString *)description
{
    self = [super init];
    if (self)
    {
        self.photoId = photoId;
        self.secret = secret;
        self.farm = farm;
        self.server = server;
        self.title = title;
        self.description = description;
        self.hidesBottomBarWhenPushed = YES;
        self.view.backgroundColor = [UIColor blackColor];
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
    [scrollView_ release];
    [imgView_ release];
    [super dealloc];
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{    
    UIImage *image = [UIImage imageWithData:self.imgData];
    self.imgView = [[UIImageView alloc] initWithImage:image];
    [self.imgView release];
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.scrollView release];
    
    self.scrollView.contentSize = image.size;
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.zoomScale = 0.7;
    self.scrollView.delegate = self;
    [self.scrollView addSubview:self.imgView];
    self.view = self.scrollView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.recents addPhotoWithPhotoId:self.photoId
                               secret:self.secret
                                 farm:self.farm
                               server:self.server
                                title:self.title
                          description:self.description];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
