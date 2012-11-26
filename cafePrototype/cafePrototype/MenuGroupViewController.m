//
//  MenuGroupViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 15.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "MenuGroupViewController.h"
#import "GroupItemsViewController.h"
#import "SVProgressHUD.h"

@interface MenuGroupViewController ()

@end

@implementation MenuGroupViewController

@synthesize loadedObjects, myApp;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.myApp = [[UIApplication sharedApplication] delegate];
    
    if (self.myApp.menuGroups == nil) {
	if ([[ServerAPI sharedServer] isRussian]) {
	    [SVProgressHUD showWithStatus: @"Загрузка..."];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    [SVProgressHUD showWithStatus: @"Carga..."];
	} else {
	    [SVProgressHUD showWithStatus: @"Loading..."];	    
	}
	[[ServerAPI sharedServer] getCurrentMenuGroups: self];
    } else {
	[self.tableView reloadData];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myApp.menuGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIndifier];
    
    if (cell == nil) {
	cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: cellIndifier];
    }
    
    Group * object = [myApp.menuGroups objectAtIndex: indexPath.row];
    
    cell.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/assets/%@", [[[RKObjectManager sharedManager] baseURL] absoluteString], object.photo]]]];    
    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.description;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    myApp.currentGroup = [myApp.menuGroups objectAtIndex: indexPath.row];

    [myApp.navigationController pushViewController: [[GroupItemsViewController alloc] initWithNibName:@"GroupItemsViewController" bundle: [NSBundle mainBundle]] animated:YES];
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    myApp.menuGroups = [[NSMutableArray alloc] initWithArray: objects];	
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

@end
