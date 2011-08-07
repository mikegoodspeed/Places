//
//  MostRecentTableViewController.m
//  Places
//
//  Created by Mike Goodspeed on 7/9/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "MostRecentTableViewController.h"
#import "PhotoViewController.h"

@interface MostRecentTableViewController()
- (void)setup;
@property (nonatomic, retain) NSMutableArray *photoData;
@end

@implementation MostRecentTableViewController

@synthesize photoData = photoData_;

-(NSMutableArray *)photoData
{
    if (!photoData_)
    {
        photoData_ = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return photoData_;
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
    [photoData_ release];
    [super dealloc];
}

- (void)setup
{
    self.title = @"Recents";
    UITabBarItem *item = [[UITabBarItem alloc] 
                          initWithTabBarSystemItem:UITabBarSystemItemMostRecent
                          tag:0];
    self.tabBarItem = item;
    [item release];
}


- (void)addPhotoWithPhotoId:(NSString *)photoId
                     secret:(NSString *)secret
                       farm:(NSString *)farm
                     server:(NSString *)server
                      title:(NSString *)title
                description:(NSString *)description
{
    NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:
                          photoId, @"photoId", secret, @"secret", farm, @"farm",
                          server, @"server", title, @"title", 
                          description, @"description", nil];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:
//                              @"photoId != '%@'", photoId];
//    [self.photoData filterUsingPredicate:predicate];
    [self.photoData insertObject:item atIndex:0];
    [self.tableView reloadData];
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"self.photoData.count = %d", self.photoData.count);
    NSLog(@"photoData_.count = %d", photoData_.count);
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
    NSLog(@"self.photoData.count = %d", self.photoData.count);
    return self.photoData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MostRecentTableViewController";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *item = [self.photoData objectAtIndex:indexPath.row];
    NSString *title = [item objectForKey:@"title"];
    NSString *description = [item objectForKey:@"description"];
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
    NSDictionary *item = [self.photoData objectAtIndex:indexPath.row];
    NSString *photoId = [item objectForKey:@"photoId"];
    NSString *secret = [item objectForKey:@"secret"];
    NSString *farm = [item objectForKey:@"farm"];
    NSString *server = [item objectForKey:@"server"];
    PhotoViewController *pvc = [[PhotoViewController alloc] 
                                initWithPhotoId:photoId
                                secret:secret
                                farm:farm
                                server:server];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}

@end
