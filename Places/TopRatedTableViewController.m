//
//  TopRatedTableViewController.m
//  Places
//
//  Created by Mike Goodspeed on 7/9/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "TopRatedTableViewController.h"
#import "FlickrFetcher.h"
#import "PlaceTableViewController.h"

@interface TopRatedTableViewController()
- (void)setup;
@property (nonatomic, retain) NSArray *places;
@end

@implementation TopRatedTableViewController

@synthesize places = places_;

- (NSArray *)places
{
    if (!places_)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        places_ = [[FlickrFetcher topPlaces] retain];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    return places_;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [places_ release];
    [super dealloc];
}

- (void)setup
{
    self.title = @"Places";
    UITabBarItem *item = [[UITabBarItem alloc] 
                          initWithTabBarSystemItem:UITabBarSystemItemTopRated
                          tag:0];
    self.tabBarItem = item;
    [item release];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopRatedTableViewController";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *item = [self.places objectAtIndex:indexPath.row];
    NSString *content = [item objectForKey:@"_content"];
    NSArray *components = [content componentsSeparatedByString:@","];
    cell.textLabel.text = [components objectAtIndex:0];
    NSRange range = NSMakeRange(1, components.count - 1);
    cell.detailTextLabel.text = [[components subarrayWithRange:range]
                                 componentsJoinedByString:@","];
    return cell;
}

#pragma mark - Table view delegate

- (void)          tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.places objectAtIndex:indexPath.row];
    NSString *content = [item objectForKey:@"_content"];
    NSArray *components = [content componentsSeparatedByString:@","];
    NSString *title = [components objectAtIndex:0];
    NSString *placeId = [item objectForKey:@"place_id"];
    PlaceTableViewController *ptvc = [[PlaceTableViewController alloc]
                                      initWithPlaceId:placeId AndTitle:title];
    [self.navigationController pushViewController:ptvc animated:YES];
    [ptvc release];
}

@end
