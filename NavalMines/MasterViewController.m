//
//  MasterViewController.m
//  NavalMines
//
//  Created by Mike_Gazdich_rMBP on 10/29/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    
    // Instance variable object reference declaration must be enclosed between { and }
    NSMutableArray *_objects;
}
// Object reference to a static array containing the list of naval mines topics
@property (strong, nonatomic) NSArray *navalMinesTopicsList;

@end


@implementation MasterViewController

/*
 The awakeFromNib message is sent to each object recreated from an Interface Builder archive,
 but ONLY AFTER (a) all the objects in the archive have been loaded and initialized, and
 (b) all its outlet and action connections are already established.
 */
- (void)awakeFromNib
{
    /*
     The default value of this property is YES. When YES, the table view controller
     clears the table’s current selection when it receives a viewWillAppear: message.
     Setting this property to NO preserves the selection.
     */
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Set the size of the master view controller’s view while displayed in a popover.
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    
    [super awakeFromNib];   // Inform Super
}


- (void)viewDidLoad
{
    // Instantiate a static array containing the names of topics for naval mines
    self.navalMinesTopicsList  = [[NSArray alloc] initWithObjects:@"Classification", @"Countermeasures",
                                  @"Moored Contact Mines", @"Bottom Contact Mines", @"Drifting Contact Mines",
                                  @"Target-attached (Limpet) Mines", @"Influence Mines", @"Remotely Controlled Mines", nil];
    
    /*
     Set the title of the master view and popover menu button:
     In landscape mode, master view's navigation bar title = Naval Mines
     In portrait mode, the popover menu button name = Naval Mines
     */
    self.navigationItem.title = @"Naval Mines";
    
    // Obtain the object reference pointing to the Detail View Controller object
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // Direct the table view to show the first naval mines topic name as selected
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionMiddle];
    
    // Set detailViewController's property detailItem to the selected first naval mines topic name
    self.detailViewController.detailItem = [NSString stringWithFormat:@"%@", [self.navalMinesTopicsList objectAtIndex:0]];
    
    [super viewDidLoad];   // Inform Super
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource Protocol Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 1;   // Return the number of sections as 1.
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows of the section, the number of which is given
    // Number of rows = number of topics
    return [self.navalMinesTopicsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicListCell"];
    
    // Configure cell
    cell.textLabel.text = [self.navalMinesTopicsList objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate Protocol Methods

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set detailViewController's property detailItem to the selected naval mines topic
    self.detailViewController.detailItem = [NSString stringWithFormat:@"%@", [self.navalMinesTopicsList objectAtIndex:indexPath.row]];
    
}

@end
