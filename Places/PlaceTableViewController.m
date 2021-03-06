//
//  PlaceTableViewController.m
//  Places
//
//  Created by Mike Goodspeed on 7/27/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"

@interface PlaceTableViewController()
@property (nonatomic, copy) NSString *placeId;
@property (nonatomic, retain) NSArray *places;
@end

@implementation PlaceTableViewController

@synthesize placeId = placeId_;
@synthesize places = places_;

- (NSArray *)places
{
    if (!places_)
    {
        places_ = [[FlickrFetcher photosAtPlace:self.placeId] retain];
    }
    return places_;
}

- (id)initWithPlaceId:(NSString *)placeId AndTitle:(NSString *)title
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.title = title;
        self.placeId = placeId;
    }
    return self;
}

- (void)dealloc
{
    [placeId_ release];
    [places_ release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
    (UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.places.count;
}

- (NSArray *)cellInfoFromIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.places objectAtIndex:indexPath.row];
    NSString *title = [item objectForKey:@"title"];
    NSString *description = [[item objectForKey:@"description"]
                             objectForKey:@"_content"];
    if ([title isEqualToString:@""])
    {
        title = description;
        description = @"";
        if ([title isEqualToString:@""])
        {
            title = @"Unknown";
        }
    }
    return [NSArray arrayWithObjects:title, description, nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlaceTableViewController";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSArray *info = [self cellInfoFromIndexPath:indexPath];
    NSString *title = [info objectAtIndex:0];
    NSString *description = [info objectAtIndex:1];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = description;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.places objectAtIndex:indexPath.row];
    NSString *photoId = [item objectForKey:@"id"];
    NSString *secret = [item objectForKey:@"secret"];
    NSString *farm = [item objectForKey:@"farm"];
    NSString *server = [item objectForKey:@"server"];
    NSArray *info = [self cellInfoFromIndexPath:indexPath];
    NSString *title = [info objectAtIndex:0];
    NSString *description = [info objectAtIndex:1];
    PhotoViewController *pvc = [[PhotoViewController alloc] 
                                initWithPhotoId:photoId
                                secret:secret
                                farm:farm
                                server:server
                                title:title
                                description:description];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}

@end
