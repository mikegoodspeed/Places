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
//- (NSArray *)retrieveData;
@property (nonatomic, retain) NSArray *data;
@end

@implementation TopRatedTableViewController

@synthesize data = data_;

- (NSArray *)data
{
    if (!data_)
    {
        data_ = [[FlickrFetcher topPlaces] retain];
    }
    return data_;
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
    [data_ release];
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

//- (NSArray *)retrieveData
//{
//    BOOL useCache = YES;
//    NSString *docsDirectory = 
//        [NSSearchPathForDirectoriesInDomains(
//                                             NSDocumentDirectory,
//                                             NSUserDomainMask,
//                                             YES)
//                               objectAtIndex:0];
//    NSString *path = [docsDirectory 
//                      stringByAppendingPathComponent:@"topPlaces.xml"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if (useCache && [fileManager fileExistsAtPath:path])
//    {
//        NSData *xmlData = [[NSData alloc] initWithContentsOfFile:path];
//        NSArray *places = [NSPropertyListSerialization
//                           propertyListWithData:xmlData
//                           options:NSPropertyListImmutable
//                           format:nil
//                           error:nil];
//        [xmlData release];
//        NSLog(@"%@", places);
//        return places;
//    }
//    else
//    {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//        NSArray *places = [FlickrFetcher topPlaces];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        NSData *xmlData = [NSPropertyListSerialization
//                              dataWithPropertyList:places
//                              format:NSPropertyListXMLFormat_v1_0
//                              options:0
//                              error:nil];
//        [xmlData writeToFile:path atomically:YES];
//        return places;
//    }
//}

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
    static NSString *CellIdentifier = @"TopRatedTableViewController";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *item = [self.data objectAtIndex:indexPath.row];
    NSString *content = [item objectForKey:@"_content"];
    NSArray *components = [content componentsSeparatedByString:@","];
    cell.textLabel.text = [components objectAtIndex:0];
    NSRange range = NSMakeRange(1, components.count - 1);
    cell.detailTextLabel.text = [[components subarrayWithRange:range]
                                 componentsJoinedByString:@","];
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
    NSDictionary *item = [self.data objectAtIndex:indexPath.row];
    NSString *content = [item objectForKey:@"_content"];
    NSArray *components = [content componentsSeparatedByString:@","];
    NSString *title = [components objectAtIndex:0];
    NSString *placeId = [item objectForKey:@"place_id"];
    PlaceTableViewController *ptvc = [[PlaceTableViewController alloc]
                                      initWithPlaceId:placeId andTitle:title];
    [self.navigationController pushViewController:ptvc animated:YES];
    [ptvc release];
}

@end
