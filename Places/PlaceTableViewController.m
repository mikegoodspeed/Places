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
@property (nonatomic, retain) NSArray *data;
@end

@implementation PlaceTableViewController

@synthesize placeId = placeId_;
@synthesize data = data_;

- (NSArray *)data
{
    if (!data_)
    {
        data_ = [[FlickrFetcher photosAtPlace:self.placeId] retain];
        NSLog(@"%@", data_);
    }
    return data_;
}

- (id)initWithPlaceId:(NSString *)placeId andTitle:(NSString *)title
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return self.data.count;
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
    
    NSDictionary *item = [self.data objectAtIndex:indexPath.row];
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
    cell.textLabel.text = title;
    cell.detailTextLabel.text = description;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
//    NSDictionary *item = [self.data objectAtIndex:indexPath.row];
    PhotoViewController *pvc = [[PhotoViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}

@end
