//
//  MostRecentTableViewController.m
//  Places
//
//  Created by Mike Goodspeed on 7/9/11.
//  Copyright 2011 Mike Goodspeed. All rights reserved.
//

#import "MostRecentTableViewController.h"
#import "PhotoViewController.h"

#define MAX_ENTRIES 25

@interface MostRecentTableViewController()
- (void)setup;
- (void)serializePhotoList;
- (NSMutableArray *)deserializePhotoList;
@property (nonatomic, retain) NSMutableArray *photoList;
@end

@implementation MostRecentTableViewController

@synthesize photoList = photoList_;

-(NSMutableArray *)photoList
{
    if (!photoList_)
    {
        photoList_ = [self deserializePhotoList];
        if (!photoList_)
        {
            photoList_ = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    return photoList_;
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
    [photoList_ release];
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

- (void)serializePhotoList
{
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES)
                      objectAtIndex:0];
    NSString *path = [docs stringByAppendingPathComponent:@"recents.xml"];
    NSData *data = [NSPropertyListSerialization 
                    dataWithPropertyList:self.photoList
                    format:NSPropertyListXMLFormat_v1_0
                    options:0
                    error:nil];
    [data writeToFile:path atomically:YES];
}

- (NSMutableArray *)deserializePhotoList
{
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES)
                      objectAtIndex:0];
    NSString *path = [docs stringByAppendingPathComponent:@"recents.xml"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path])
    {
        return NULL;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data)
    {
        return NULL;
    }
    NSArray *array = [NSPropertyListSerialization
                      propertyListWithData:data
                      options:NSPropertyListImmutable
                      format:nil
                      error:nil];
    return [NSMutableArray arrayWithArray:array];
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"photoId != %@", photoId];
    [self.photoList filterUsingPredicate:predicate];
    while (self.photoList.count >= MAX_ENTRIES)
    {
        [self.photoList removeLastObject];
    }
    [self.photoList insertObject:item atIndex:0];
    [self serializePhotoList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    return self.photoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MostRecentTableViewController";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *item = [self.photoList objectAtIndex:indexPath.row];
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
    NSDictionary *item = [self.photoList objectAtIndex:indexPath.row];
    NSString *photoId = [item objectForKey:@"photoId"];
    NSString *secret = [item objectForKey:@"secret"];
    NSString *farm = [item objectForKey:@"farm"];
    NSString *server = [item objectForKey:@"server"];
    NSString *title = [item objectForKey:@"title"];
    PhotoViewController *pvc = [[PhotoViewController alloc] 
                                initWithPhotoId:photoId
                                secret:secret
                                farm:farm
                                server:server
                                title:title];
    [self.navigationController pushViewController:pvc animated:YES];
    [pvc release];
}

@end
