//
//  GroupItemsViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 17.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "GroupItemsViewController.h"
#import "MenuItemDetailsViewController.h"
#import "MenuItemCell.h"
#import "SVProgressHUD.h"

@interface GroupItemsViewController ()

@end

@implementation GroupItemsViewController

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

//    self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"pattern.png"]];

    if (self.loadedObjects == nil) {
	if ([[ServerAPI sharedServer] isRussian]) {
	    [SVProgressHUD showWithStatus: @"Загрузка..."];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    [SVProgressHUD showWithStatus: @"Carga..."];
	} else {
	    [SVProgressHUD showWithStatus: @"Loading..."];	    
	}
	[[ServerAPI sharedServer] getCurrentMenuItemsbyGroup: myApp.currentGroup.identifier.intValue delegate: self];
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
    return [loadedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndifier = @"MenuItemCell";
    
    MenuItemCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIndifier];

    if (cell == nil) {
	NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"MenuItemCell" owner:self options:NULL];
	if (indexPath.row % 2) {
	    cell = (MenuItemCell *) [nib objectAtIndex:1];
	} else {
	    cell = (MenuItemCell *) [nib objectAtIndex:0];
	}
    }
    
    MenuItem * object = [loadedObjects objectAtIndex: indexPath.row];
    
    cell.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/assets/%@", [[[RKObjectManager sharedManager] baseURL] absoluteString], object.photo]]]];    
    cell.labelName.text = object.name;
    cell.labelDescr.text = object.description;
    cell.labelPrice.text = [NSString stringWithFormat: @" %.2f ", object.cost.floatValue];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myApp.currentMenuItem = [loadedObjects objectAtIndex: indexPath.row];
    [myApp.navigationController pushViewController: [[MenuItemDetailsViewController alloc] initWithNibName:@"MenuItemDetailsViewController" bundle: [NSBundle mainBundle]] animated:YES];
     
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    loadedObjects = [[NSArray alloc] initWithArray: objects];
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

@end
