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
@property (nonatomic, retain) NSData *data;
@end

@implementation PhotoViewController

@synthesize photoId = photoId_;
@synthesize secret = secret_;
@synthesize farm = farm_;
@synthesize server = server_;
@synthesize data = data_;

- (NSData *)data
{
    if (!data_)
    {
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.photoId, @"id",
                              self.secret, @"secret",
                              self.farm, @"farm",
                              self.server, @"server", nil];
        data_ = [FlickrFetcher
                 imageDataForPhotoWithFlickrInfo:info
                 format:FlickrFetcherPhotoFormatLarge];
    }
    return data_;
}

- (id)initWithPhotoId:(NSString *)photoId
               Secret:(NSString *)secret
                 Farm:(NSString *)farm
               Server:(NSString *)server
{
    self = [super init];
    if (self)
    {
        self.photoId = photoId;
        self.secret = secret;
        self.farm = farm;
        self.server = server;
    }
    return self;
}

- (void)dealloc
{
    [photoId_ release];
    [secret_ release];
    [farm_ release];
    [server_ release];
    [data_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{    
    UIImage *image = [UIImage imageWithData:self.data];
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
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // return the imgView inside the scrollView inside self.view
    return [[[[self.view subviews] lastObject] subviews] lastObject];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[[self.view subviews] lastObject] removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
