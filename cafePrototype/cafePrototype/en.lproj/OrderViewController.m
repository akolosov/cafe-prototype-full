//
//  OrderViewController.m
//  cafePrototype
//
//  Created by Alexey Kolosov on 15.04.12.
//  Copyright (c) 2012 customWork. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderItemDetailsViewController.h"
#import "CheckOrderViewController.h"
#import "SVProgressHUD.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

@synthesize itemCell, myApp, changeIt;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {	
    }
    return self;
}

- (void)viewDidLoad
{
    self.myApp = [[UIApplication sharedApplication] delegate];
    
    self.changeIt = NO;
    
    [super viewDidLoad];
}

- (void) viewWillAppear: (BOOL) animated {
    if (myApp.orderChecked) {
	myApp.orderItems = nil;
	myApp.currentOrder = nil;
    } else {
	if ([[ServerAPI sharedServer] isRussian]) {
	    [SVProgressHUD showWithStatus: @"Загрузка..."];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    [SVProgressHUD showWithStatus: @"Carga..."];
	} else {
	    [SVProgressHUD showWithStatus: @"Loading..."];	    
	}

	if (myApp.currentOrder) {
	    [[ServerAPI sharedServer] getOrderItems: myApp.currentOrder.identifier.intValue delegate: self];
	}  else {
	    [[ServerAPI sharedServer] getCurrentOrderHeader: self];
	}
	
    	[super viewWillAppear: animated];  
    }
}

- (void) viewDidAppear: (BOOL) animated {
    if (myApp.orderChecked) {
	myApp.orderChecked = NO;
	self.navigationItem.rightBarButtonItem = nil;	
	[myApp.navigationController popViewControllerAnimated: YES];
    } else {	
	[super viewDidAppear: animated];
    }
}

- (void)viewDidUnload
{
    [self setItemCell:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *) tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myApp.orderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndifier = @"OrderItemCell";

    OrderItemCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIndifier];
	
    if (cell == nil) {
	NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"OrderItemCell" owner:self options:NULL];
	if (indexPath.row % 2) {
	    cell = (OrderItemCell *) [nib objectAtIndex:1];
	} else {
	    cell = (OrderItemCell *) [nib objectAtIndex:0];
	}
    }
    
    OrderItem * object = [myApp.orderItems objectAtIndex: indexPath.row];
    
    cell.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/assets/%@", [[[RKObjectManager sharedManager] baseURL] absoluteString], object.photo]]]];    
    cell.labelName.text = object.name;
    cell.labelDescr.text = object.description;
    cell.labelPrice.text = [NSString stringWithFormat: @" %.2f ", object.cost.floatValue];
    if ([[ServerAPI sharedServer] isRussian]) {
	cell.labelCount.text = [NSString stringWithFormat: @"Кол-во: %d", object.count.intValue];
	cell.labelSumm.text = [NSString stringWithFormat: @"Сумма: %.2f", object.summ.floatValue];
    } else if ([[ServerAPI sharedServer] isEspanian]) {
	cell.labelCount.text = [NSString stringWithFormat: @"Número: %d", object.count.intValue];
	cell.labelSumm.text = [NSString stringWithFormat: @"Suma: %.2f", object.summ.floatValue];
    } else {
	cell.labelCount.text = [NSString stringWithFormat: @"Count: %d", object.count.intValue];
	cell.labelSumm.text = [NSString stringWithFormat: @"Summ: %.2f", object.summ.floatValue];
    }
    
    
    return cell;
}

- (void) handleOrder: (id) sender
{
    [myApp.navigationController pushViewController: [[CheckOrderViewController alloc] initWithNibName: @"CheckOrderViewController" bundle: [NSBundle mainBundle]] animated: YES];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
	myApp.currentOrderItem = [myApp.orderItems objectAtIndex: indexPath.row];

	self.changeIt = YES;

    	[[ServerAPI sharedServer] putOrderItem: myApp.currentOrder.identifier.intValue menuItem: myApp.currentOrderItem.itemID.intValue count: 0 delegate: self];	
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger) section {
    if (myApp.orderSumm) {
	if ([[ServerAPI sharedServer] isRussian]) {
	    return [NSString stringWithFormat: @"Итого на сумму: %@", myApp.orderSumm];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    return [NSString stringWithFormat: @"Costo total: %@", myApp.orderSumm];
	} else {
	    return [NSString stringWithFormat: @"Total cost: %@", myApp.orderSumm];	    
	}
    } else {
	return @"";
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myApp.currentOrderItem = [myApp.orderItems objectAtIndex: indexPath.row];

    OrderItemDetailsViewController * detailViewController = [[OrderItemDetailsViewController alloc] initWithNibName:@"OrderItemDetailsViewController" bundle:nil];

    [myApp.navigationController pushViewController: detailViewController animated:YES];
}

#pragma mark - Delegate
- (void) didFinishLoading: (NSArray *) objects {
    if (self.changeIt) {
	self.changeIt = NO;
	if ([[ServerAPI sharedServer] isRussian]) {
	    [SVProgressHUD showWithStatus: @"Загрузка..."];
	} else if ([[ServerAPI sharedServer] isEspanian]) {
	    [SVProgressHUD showWithStatus: @"Carga..."];
	} else {
	    [SVProgressHUD showWithStatus: @"Loading..."];	    
	}
	[[ServerAPI sharedServer] getOrderItems: myApp.currentOrder.identifier.intValue delegate: self];
    } else {
	if ([objects count] > 0) {	
	    if (!myApp.currentOrder) {
		myApp.currentOrder = [objects objectAtIndex: 0];
		[[ServerAPI sharedServer] getOrderItems: myApp.currentOrder.identifier.intValue delegate: self];
	    } else {
		myApp.orderItems = [[NSMutableArray alloc] initWithArray: objects];

		if ([myApp.orderItems count] > 0) {
		    if ([[ServerAPI sharedServer] isRussian]) {
			self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Оформить заказ" style:UIBarButtonItemStyleBordered target:self action:@selector(handleOrder:)];
		    } else if ([[ServerAPI sharedServer] isEspanian]) {
			self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Para ordenar" style:UIBarButtonItemStyleBordered target:self action:@selector(handleOrder:)];
		    } else {
			self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Check order" style:UIBarButtonItemStyleBordered target:self action:@selector(handleOrder:)];		
		    }
		} else {
		    self.navigationItem.rightBarButtonItem = nil;
		}

		if (myApp.orderItems) {
		    [[ServerAPI sharedServer] getOrderSumm: myApp.currentOrder.identifier.intValue delegate: self]; 
		}

	    }
	}
	[SVProgressHUD dismiss];
    }
}

- (void)didFinishPosting:(NSString *)response {
    NSLog(@"RESPONSE Objects: %@", response);
    NSDictionary * objects = [[[RKParserRegistry sharedRegistry] parserForMIMEType: RKMIMETypeJSON] objectFromString: response error: nil];
    
    if ((objects) && ([objects objectForKey: @"result"])) {
	myApp.orderSumm = [NSString stringWithFormat: @"%@", [objects objectForKey: @"result"]];
	[self.tableView reloadData];	
    }
	
}

@end
